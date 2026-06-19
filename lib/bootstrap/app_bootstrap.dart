import 'package:abc_wonder/utils/tts_helper.dart';
import 'package:abc_wonder/core/monetization/monetization_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBootstrap {
  static Future<void> init(ProviderContainer container) async {
    await TtsHelper().init();
    final monetization = container.read(monetizationProvider);
    await monetization.initialize();
  }
}
