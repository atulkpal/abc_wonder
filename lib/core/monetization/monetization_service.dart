abstract class MonetizationService {
  bool get isPremium;

  bool get areAdsEnabled;

  Stream<bool> get premiumStatus;

  Future<void> initialize();

  Future<bool> purchaseRemoveAds();

  Future<void> restorePurchases();

  void dispose();
}

class AdPlacements {
  AdPlacements._();

  static const String alphabetHub = 'alphabet-hub';
  static const String numberHub = 'number-hub';
  static const String colorsHub = 'colors-hub';
  static const String shapesHub = 'shapes-hub';
  static const String daysHub = 'days-hub';
  static const String monthsHub = 'months-hub';
  static const String parentDashboard = 'parent-dashboard';

  static const Map<String, List<String>> keywords = {
    alphabetHub: ['alphabet', 'abc', 'letters', 'kids-learning'],
    numberHub: ['numbers', 'counting', '123', 'kids-math'],
    colorsHub: ['colors', 'rainbow', 'paint', 'kids-art'],
    shapesHub: ['shapes', 'geometry', 'blocks', 'kids-toys'],
    daysHub: ['days', 'week', 'calendar', 'schedule'],
    monthsHub: ['months', 'seasons', 'year', 'weather'],
    parentDashboard: ['parenting', 'education', 'kids-app'],
  };
}
