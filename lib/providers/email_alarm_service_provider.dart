import 'package:email_alarm/services/email_alarm_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_alarm_service_provider.g.dart';

@Riverpod(keepAlive: true)
EmailAlarmService emailAlarmService(EmailAlarmServiceRef ref) {
  ref.onDispose(() async {
    await ref.read(emailAlarmServiceProvider).dispose();
  });
  return EmailAlarmService(ref);
}

@Riverpod(keepAlive: true)
Stream<bool> isMonitaring(IsMonitaringRef ref) async* {
  yield ref.read(emailAlarmServiceProvider).isMonitoring;
  yield* ref.watch(emailAlarmServiceProvider).monitoringStateChanges;
}
