import 'package:flutter_tts/flutter_tts.dart';

class TtsHelper {
  static final TtsHelper _instance = TtsHelper._internal();
  factory TtsHelper() => _instance;
  TtsHelper._internal();

  FlutterTts? _tts;

  Future<void> init() async {
    _tts = FlutterTts();
    await _tts?.setLanguage('en-US');
    await _tts?.setSpeechRate(0.4);
    await _tts?.setPitch(1.1);
  }

  Future<void> speak(String text) async {
    if (_tts == null) await init();
    await _tts?.stop();
    await _tts?.speak(text);
  }

  Future<void> dispose() async {
    await _tts?.stop();
    _tts = null;
  }
}
