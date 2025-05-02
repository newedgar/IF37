import 'package:flutter_tts/flutter_tts.dart';

class SyntheseVocale {
  static final SyntheseVocale _instance = SyntheseVocale._internal();

  factory SyntheseVocale() {
    return _instance;
  }

  SyntheseVocale._internal() {
    initTts();
  }

  late FlutterTts flutterTts;


  dynamic initTts() {
    flutterTts = FlutterTts(); 

    flutterTts.setLanguage("fr-FR");
    flutterTts.setPitch(0.9);
    flutterTts.setSpeechRate(0.65);

  }


  Future<void> speak(String text) async {
    if (text.isNotEmpty) {
      await flutterTts.speak(text);
    }
  }
}