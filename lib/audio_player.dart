import 'package:audioplayers/audioplayers.dart';

class AudioP {
  static final AudioPlayer audioPlayer = AudioPlayer();
  static bool canPlay = true;

  static Future<void> loadMusic() async {
    if (canPlay) {
      await audioPlayer.setReleaseMode(ReleaseMode.loop);
      await audioPlayer
          .play(AssetSource('music/bensound-theelevatorbossanova.mp3'));
    }
  }

  static Future<void> stop() async {
    await audioPlayer.stop();
  }
}
