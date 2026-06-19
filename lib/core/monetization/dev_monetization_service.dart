import 'dart:async';
import 'monetization_service.dart';

class DevMonetizationService implements MonetizationService {
  @override
  bool get isPremium => false;

  @override
  bool get areAdsEnabled => false;

  @override
  Stream<bool> get premiumStatus => const Stream<bool>.empty();

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> purchaseRemoveAds() async => false;

  @override
  Future<void> restorePurchases() async {}

  @override
  void dispose() {}
}
