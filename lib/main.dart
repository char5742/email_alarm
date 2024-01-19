import 'package:email_alarm/providers/auth_service_provider.dart';
import 'package:email_alarm/providers/config_provider.dart';
import 'package:email_alarm/providers/email_alarm_service_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    // Fixed to landscape
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final container = ProviderContainer();
  await container.read(configRepositoryProvider).initialize();

  await Future.wait([
    container.read(emailAlarmServiceProvider).initialize(),
    container.read(authServiceProvider).initialize(),
    container.read(emailAlarmServiceProvider).initializeService(),
  ]);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}
