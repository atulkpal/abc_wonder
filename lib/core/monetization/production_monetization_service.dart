import 'dart:async';
import 'monetization_service.dart';

class ProductionMonetizationService implements MonetizationService {
  // ignore: prefer_final_fields — reassigned by purchaseRemoveAds()
  bool _premium = false;
  final bool _adsEnabled = false;
  final StreamController<bool> _premiumController =
      StreamController<bool>.broadcast();

  @override
  bool get isPremium => _premium;

  @override
  bool get areAdsEnabled => _adsEnabled;

  @override
  Stream<bool> get premiumStatus => _premiumController.stream;

  @override
  Future<void> initialize() async {
    // TODO: Initialize AdMob once google_mobile_ads dep is added
    // await MobileAds.instance.initialize();
    // TODO: Initialize IAP once in_app_purchase dep is added
    // await InAppPurchase.instance.restorePurchases();
  }

  @override
  Future<bool> purchaseRemoveAds() async {
    // TODO: Real IAP purchase with in_app_purchase
    // final product = InAppPurchase.instance...
    // _premium = true;
    // _premiumController.add(true);
    return false;
  }

  @override
  Future<void> restorePurchases() async {
    // TODO: Check for existing purchases
  }

  @override
  void dispose() {
    _premiumController.close();
  }
}
