import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'monetization_service.dart';
import 'dev_monetization_service.dart';

final monetizationProvider = Provider<MonetizationService>((ref) {
  return DevMonetizationService();
});
