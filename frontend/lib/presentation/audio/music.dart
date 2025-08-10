import 'package:commandos/presentation/audio/audio.dart';
import 'package:just_audio/just_audio.dart';

mixin Music {
  final Map<String, AudioPlayer> _musicPlayers = {};
  AudioPlayer? _playerToResume;

  Future playMusic(String music) async {
    if (Audio.enabled) {
      await stopMusic();
      await _musicPlayers[music]?.seek(Duration.zero);
      await _musicPlayers[music]?.play();
    }
  }

  void pauseMusic() {
    for (final AudioPlayer player in _musicPlayers.values) {
      if (player.playing) {
        _playerToResume = player;
        break;
      }
    }

    _playerToResume?.pause();
  }

  void resumeMusic() {
    _playerToResume?.play();
    _playerToResume = null;
  }

  Future stopMusic() =>
      Future.wait(_musicPlayers.values.map((player) => player.stop()));

  Future loadMusic() async {
    //_musicPlayers[musidPath] = await _getPlayer(musidPath);
  }

  void musicSpeed(double value) {
    _musicPlayers.forEach((key, player) => player.setSpeed(value));
  }

  void disposeMusic() {
    stopMusic();
    _musicPlayers.forEach((key, player) => player.dispose());
  }
}
