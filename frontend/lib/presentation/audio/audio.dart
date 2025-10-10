import 'package:commandos/environments/environment.dart';
import 'package:commandos/presentation/audio/music.dart';
import 'package:commandos/presentation/audio/sound.dart';
import 'package:commandos/presistence/storage/audio_storage.dart';
import 'package:commandos/utils/locator.dart';

class Audio with Music, Sound {
  static bool enabled = true;

  static Audio get get => locator<Audio>();

  void toggle() {
    Audio.enabled = !Audio.enabled;
    AudioStorage.save(enabled);
  }

  void speed(double value) {
    soundSpeed(value);
    musicSpeed(value);
  }

  void dispose() {
    disposeSound();
    disposeMusic();
  }

  Future load() async {
    enabled = Environment.get.isReleaseMode && await AudioStorage.load();
    await loadSound();
    await loadMusic();
  }
}
