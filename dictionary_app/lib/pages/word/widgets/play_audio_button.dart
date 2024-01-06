import 'package:dictionary_app/services/text_to_speech_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PlayAudioButton extends StatelessWidget {
  String audioText;

  PlayAudioButton({required this.audioText});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.play_arrow),
      color: Colors.deepPurple,
      iconSize: 40,
      onPressed: () async {
        await flutterTTS(audioText);
      },
    );
  }
}
