import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class AudioP {
  static AudioPlayer audioPlayer;
  static bool canPlay = true;

  static Future<void> loadMusic() async {
    if (canPlay) {
      audioPlayer = await AudioCache().loop('music/bensound-theelevatorbossanova.mp3');
    }
  }
}