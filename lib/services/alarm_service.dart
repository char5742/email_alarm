import 'dart:async';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class AlarmService {
  final _player = FlutterRingtonePlayer();
  bool isPlaying = false;
  final StreamController<bool> _isPlayingStateController =
      StreamController<bool>.broadcast();

  late final playingStateChanges = _isPlayingStateController.stream;

  Future<void> playSound() async {
    await _player.playAlarm(volume: 1);
    isPlaying = true;
    _isPlayingStateController.add(true);
  }

  Future<void> stopSound() async {
    await _player.stop();
    isPlaying = false;
    _isPlayingStateController.add(false);
  }
}
