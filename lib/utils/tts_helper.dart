import 'package:flutter_tts/flutter_tts.dart';

class TtsHelper {
  static final TtsHelper _instance = TtsHelper._internal();
  factory TtsHelper() => _instance;
  TtsHelper._internal();

  FlutterTts? _tts;
  double _rate = 0.4;

  double get rate => _rate;

  Future<void> init() async {
    _tts = FlutterTts();
    await _tts?.setLanguage('en-US');
    await _tts?.setSpeechRate(_rate);
    await _tts?.setPitch(1.1);
  }

  Future<void> setRate(double rate) async {
    _rate = rate;
    await _tts?.setSpeechRate(rate);
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
