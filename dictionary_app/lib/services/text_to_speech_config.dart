import 'package:flutter_tts/flutter_tts.dart';

Future flutterTTS(String text) async {
  FlutterTts flutterTts = FlutterTts();

  await flutterTts.setLanguage("en-US");

  await flutterTts.setPitch(1.0);

  await flutterTts.setVolume(1.0);

  bool isAvailable = await flutterTts.isLanguageAvailable("en-US");

  if (isAvailable) {
    await flutterTts.speak(text);
  } else {
    print('text to speech not available');
  }
}
