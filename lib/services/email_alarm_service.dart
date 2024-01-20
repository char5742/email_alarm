import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:email_alarm/providers/alarm_service_provider.dart';
import 'package:email_alarm/providers/email_provider.dart';
import 'package:email_alarm/repositories/config_repository.dart';
import 'package:email_alarm/router.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class EmailAlarmService {
  EmailAlarmService(this.ref);
  final Ref ref;

  Timer? _timer;

  final StreamController<bool> _isMonitoringStateController =
      StreamController<bool>.broadcast();

  /// 監視中かどうか
  late final monitoringStateChanges = _isMonitoringStateController.stream;

  /// 監視中かどうか
  bool get isMonitoring => _timer != null;

  late FlutterBackgroundService service;

  StreamSubscription<Map<String, dynamic>?>? _checkSubscription;
  StreamSubscription<Map<String, dynamic>?>? _stopSubscription;

  Future<void> initialize() async {
    await initializeService();
  }

  Future<void> dispose() async {
    await stopMonitaring();
  }

  Future<void> startMonitaring() async {
    final isGranted = await Permission.notification.isGranted;
    if (!isGranted) {
      final res = await Permission.notification.request();
      if (res != PermissionStatus.granted) {
        ref.read(routerProvider).go('/requestPermission');
      }
      return;
    }

    await service.startService();
    _isMonitoringStateController.add(true);
    service.invoke('showNotification');
    _checkSubscription = service.on('check').listen((event) async {
      final emails = await ref.refresh(fetchEmailsProvider.future);
      service.invoke('showNotification');
      if (emails.isEmpty) {
        return;
      }
      await ref.read(alarmServiceProvider).playSound();
      await _showFullScreenNotification(emails.first.content ?? '');
    });

    _stopSubscription = service.on('stop').listen((event) async {
      await stopMonitaring();
    });
  }

  Future<void> stopMonitaring() async {
    service.invoke('stopService');
    await ref.read(alarmServiceProvider).stopSound();
    await _checkSubscription?.cancel();
    _checkSubscription = null;
    await _stopSubscription?.cancel();
    _stopSubscription = null;
    _isMonitoringStateController.add(false);
    _timer?.cancel();
    _timer = null;
  }

  Future<void> stopSound() async {
    await ref.read(alarmServiceProvider).stopSound();
  }

  Future<void> initializeService() async {
    service = FlutterBackgroundService();

    const channel = AndroidNotificationChannel(
      notificationChannelId, // id
      'EmailAlarm', // title
      description: 'Waiting for Emails from Specific Senders', // description
      importance: Importance.max, // importance must be at low or higher level
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(
          iOS: DarwinInitializationSettings(
            notificationCategories: [
              DarwinNotificationCategory(
                'email_notification_category',
                actions: [
                  DarwinNotificationAction.plain(
                    'stop',
                    'Stop',
                  ),
                ],
              ),
            ],
          ),
          android: const AndroidInitializationSettings('ic_bg_service_small'),
        ),
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        isForegroundMode: true,
        autoStart: false,
        notificationChannelId: notificationChannelId,
        foregroundServiceNotificationId: notificationId,
      ),
      iosConfiguration: IosConfiguration(
        onForeground: onStart,
        autoStart: false,
      ),
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.notificationResponseType ==
      NotificationResponseType.selectedNotificationAction) {
    switch (notificationResponse.actionId) {
      case 'stop':
        FlutterBackgroundService().invoke('stop');
      default:
        break;
    }
  }
}

const notificationChannelId = 'my_foreground';

const notificationId = 888;

@pragma('vm:entry-point')
Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final repository = ConfigRepository();
  await repository.initialize();
  final config = await repository.getConfig();

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  service.on('stop').listen((event) {
    service.invoke('stop');
  });

  service.on('showNotification').listen((event) async {
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      'Waiting for email',
      'Updated at ${DateTime.now()}',
      const NotificationDetails(
        iOS: DarwinNotificationDetails(
          threadIdentifier: notificationChannelId,
        ),
        android: AndroidNotificationDetails(
          notificationChannelId,
          'MY FOREGROUND SERVICE',
          icon: 'ic_bg_service_small',
          ongoing: true,
          importance: Importance.max,
          priority: Priority.max,
          actions: [
            AndroidNotificationAction(
              'stop',
              'Stop',
            ),
          ],
        ),
      ),
    );
  });

  // bring to foreground
  Timer.periodic(Duration(minutes: config.intervalInMinutes), (timer) async {
    service.invoke('check');
  });
}

Future<void> _showFullScreenNotification(String body) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'email_notification_channel',
    'email_recieve',
    priority: Priority.max,
    importance: Importance.high,
    fullScreenIntent: true,
    actions: [
      AndroidNotificationAction(
        'stop',
        'Stop',
      ),
    ],
  );
  const iOSPlatformChannelSpecifics = DarwinNotificationDetails(
    threadIdentifier: 'email_notification_channel',
  );

  const platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'Email recieved',
    body,
    platformChannelSpecifics,
  );
}
