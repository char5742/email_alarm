import 'package:email_alarm/services/alarm_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_service_provider.g.dart';

@Riverpod(keepAlive: true)
AlarmService alarmService(AlarmServiceRef _) => AlarmService();

@Riverpod(keepAlive: true)
Stream<bool> isPlaying(IsPlayingRef ref) async* {
  yield ref.read(alarmServiceProvider).isPlaying;
  yield* ref.watch(alarmServiceProvider).playingStateChanges;
}
