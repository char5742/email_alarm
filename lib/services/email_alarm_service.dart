import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:email_alarm/providers/alarm_service_provider.dart';
import 'package:email_alarm/providers/email_provider.dart';
import 'package:email_alarm/repositories/config_repository.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

  StreamSubscription<Map<String, dynamic>?>? _subscription;

  Future<void> initialize() async {
    await initializeService();
  }

  Future<void> dispose() async {
    await stopMonitaring();
  }

  Future<void> startMonitaring() async {
    await service.startService();
    _isMonitoringStateController.add(true);
    _subscription = service.on('check').listen((event) async {
      final emails = await ref.read(fetchEmailsProvider.future);

      if (emails.isEmpty) {
        return;
      }
      await ref.read(alarmServiceProvider).playSound();
      await _showFullScreenNotification(emails.first.content ?? '');
    });
  }

  Future<void> stopMonitaring() async {
    service.invoke('stopService');
    await _subscription?.cancel();
    _subscription = null;
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
      importance: Importance.low, // importance must be at low or higher level
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS || Platform.isAndroid) {
      await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
          iOS: DarwinInitializationSettings(),
          android: AndroidInitializationSettings('ic_bg_service_small'),
        ),
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
      iosConfiguration: IosConfiguration(),
    );
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

  if (service is AndroidServiceInstance) {
    if (await service.isForegroundService()) {
      await flutterLocalNotificationsPlugin.show(
        notificationId,
        '',
        '',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            notificationChannelId,
            'MY FOREGROUND SERVICE',
            icon: 'ic_bg_service_small',
            ongoing: true,
          ),
        ),
      );

      await service.setForegroundNotificationInfo(
        title: 'Waiting for email',
        content: 'Updated at ${DateTime.now()}',
      );
    }
  }
  // bring to foreground
  Timer.periodic(Duration(minutes: config.intervalInMinutes), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        await flutterLocalNotificationsPlugin.show(
          notificationId,
          '',
          '',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              notificationChannelId,
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        await service.setForegroundNotificationInfo(
          title: 'Waiting for email',
          content: 'Updated at ${DateTime.now()}',
        );
        service.invoke('check');
      }
    }
  });
}

Future<void> _showFullScreenNotification(String body) async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'email_notification_channel',
    'email_recieve',
    priority: Priority.high,
    importance: Importance.high,
    fullScreenIntent: true,
  );
  const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

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
