# ABC Wonder — Monetization Activation Guide

## Architecture Overview

```
lib/core/monetization/
├── monetization_service.dart        ← Abstract interface
├── dev_monetization_service.dart    ← No-op impl (no SDKs needed)
├── production_monetization_service.dart ← Real AdMob + IAP impl (stub)
├── monetization_provider.dart       ← Riverpod provider
├── ad_banner_widget.dart            ← Banner widget (returns SizedBox.shrink until active)
└── parent_gate.dart                 ← Math puzzle gate + ParentGatedWidget
```

### Two Implementations

| Class | When used | Shows ads? | SDK deps? |
|-------|-----------|------------|-----------|
| `DevMonetizationService` | Default (development) | Never | None |
| `ProductionMonetizationService` | Production (after activation) | When `areAdsEnabled && !isPremium` | google_mobile_ads + in_app_purchase |

The provider lives in `lib/core/monetization/monetization_provider.dart` and is the single point to swap implementations.

---

## Step 1 — Add SDK Dependencies

Open `pubspec.yaml` and add these under `dependencies`:

```yaml
google_mobile_ads: ^5.2.0
in_app_purchase: ^3.2.0
```

Run:

```bash
flutter pub get
```

---

## Step 2 — Android Configuration

### 2a. Update `android/app/build.gradle`

Ensure these minimums:

```groovy
android {
    compileSdkVersion 34

    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

### 2b. Add AdMob App ID to `AndroidManifest.xml`

File: `android/app/src/main/AndroidManifest.xml`

Add inside `<application>` tag:

```xml
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-3940256099942544~3347511713"/>
```

Use the **test app ID** (`ca-app-pub-3940256099942544~3347511713`) during development. Replace with your real AdMob app ID before release.

### 2c. Internet Permission

The Internet permission is included by default in Flutter's debug manifest. For release, ensure it's in your main `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

---

## Step 3 — iOS Configuration

### 3a. Add AdMob App ID to `ios/Runner/Info.plist`

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~3347511713</string>
```

### 3b. Add SKAdNetwork identifiers (iOS 14+)

In `ios/Runner/Info.plist`:

```xml
<key>SKAdNetworkItems</key>
<array>
    <dict>
        <key>SKAdNetworkIdentifier</key>
        <string>cstr6suwn9.skadnetwork</string>
    </dict>
</array>
```

Refer to [Google's SKAdNetwork list](https://developers.google.com/admob/ios/ios14#skadnetwork) for the full list.

---

## Step 4 — Create AdMob Account & Ad Units

1. Go to [https://admob.google.com/](https://admob.google.com/)
2. Create an app entry for ABC Wonder (Android + iOS)
3. Create **Banner** ad units (one per module hub + one for parent dashboard):

| Placement Key | Ad Unit Name | Format | Size |
|---------------|-------------|--------|------|
| `alphabet-hub` | Alphabet Hub Banner | Banner | 320×50 |
| `number-hub` | Number Hub Banner | Banner | 320×50 |
| `colors-hub` | Colors Hub Banner | Banner | 320×50 |
| `shapes-hub` | Shapes Hub Banner | Banner | 320×50 |
| `days-hub` | Days Hub Banner | Banner | 320×50 |
| `months-hub` | Months Hub Banner | Banner | 320×50 |
| `parent-dashboard` | Parent Dashboard Native | Native advanced | Flexible |

4. Copy the ad unit IDs (format: `ca-app-pub-XXXXXXXXXXXXXX/YYYYYYYYYY`)

---

## Step 5 — Wire Ad Unit IDs

Create a config file (or add to an existing one). The ad unit IDs map from `AdPlacements` keys:

```dart
// lib/core/monetization/ad_unit_ids.dart

class AdUnitIds {
  static const Map<String, String> banner = {
    AdPlacements.alphabetHub: 'ca-app-pub-3940256099942544/6300978111',  // test ID
    AdPlacements.numberHub: 'ca-app-pub-3940256099942544/6300978111',
    AdPlacements.colorsHub: 'ca-app-pub-3940256099942544/6300978111',
    AdPlacements.shapesHub: 'ca-app-pub-3940256099942544/6300978111',
    AdPlacements.daysHub: 'ca-app-pub-3940256099942544/6300978111',
    AdPlacements.monthsHub: 'ca-app-pub-3940256099942544/6300978111',
  };

  static const String parentDashboardNative =
      'ca-app-pub-3940256099942544/3986624511';  // test native ID
}
```

> Use **test ad unit IDs** during development. Replace with real IDs before release.

---

## Step 6 — Implement the Production Service

Edit `lib/core/monetization/production_monetization_service.dart`:

### 6a. Import SDKs

```dart
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
```

### 6b. Initialize in `initialize()`

```dart
@override
Future<void> initialize() async {
  await MobileAds.instance.initialize();
  final iap = InAppPurchase.instance;
  if (await iap.isAvailable()) {
    // Restore existing purchases
    await restorePurchases();
  }
}
```

### 6c. Implement `bannerAd()` in `AdBannerWidget`

The `AdBannerWidget` in `lib/core/monetization/ad_banner_widget.dart` should become a `StatefulWidget` that loads and manages a `BannerAd`:

```dart
class _AdBannerWidgetState extends ConsumerState<AdBannerWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    final adUnitId = AdUnitIds.banner[widget.placementKey]!;
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          _bannerAd = null;
          if (mounted) setState(() {});
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.watch(monetizationProvider);
    if (service.isPremium || !service.areAdsEnabled) {
      _bannerAd?.dispose();
      return const SizedBox.shrink();
    }
    if (_bannerAd == null) return const SizedBox.shrink();
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: AdWidget(ad: _bannerAd!),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }
}
```

### 6d. Enable ads

Change `_adsEnabled` from `final` to mutable:

```dart
bool _adsEnabled = false; // ← remove final
```

Then expose a method or config:

```dart
/// Call once from bootstrap when ads should be active
void enableAds() {
  _adsEnabled = true;
}
```

### 6e. Wire IAP purchase

```dart
@override
Future<bool> purchaseRemoveAds() async {
  final iap = InAppPurchase.instance;
  if (!await iap.isAvailable()) return false;

  const productId = 'remove_ads';
  final result = await iap.buyNonConsumable(
    purchaseParam: PurchaseParam(
      productDetails: ProductDetails(
        id: productId,
        title: 'Remove Ads',
        description: 'Remove all ads from ABC Wonder',
        price: '\$2.99',
        rawPrice: 2.99,
        currencyCode: 'USD',
        rawDiscountPrice: null,
      ),
    ),
  );

  if (result != null) {
    _premium = true;
    _premiumController.add(true);
    return true;
  }
  return false;
}

@override
Future<void> restorePurchases() async {
  final iap = InAppPurchase.instance;
  if (!await iap.isAvailable()) return;

  final purchases = await iap.restorePurchases();
  final hasAdsRemoved = purchases.any((p) => p.productID == 'remove_ads');
  if (hasAdsRemoved) {
    _premium = true;
    _premiumController.add(true);
  }
}
```

---

## Step 7 — Configure Google Play Billing

### 7a. Create product in Google Play Console

1. Go to **Google Play Console** → your app → **Monetize** → **Products** → **In-app products**
2. Create a new managed product:
   - Product ID: `remove_ads`
   - Name: "Remove Ads"
   - Description: "Remove all ads from ABC Wonder"
   - Price: Select your desired price
3. Publish the product

### 7b. Add Billing permission (auto-added by `in_app_purchase`)

The plugin automatically adds `com.android.vending.BILLING` permission. Verify it's in your merged manifest.

---

## Step 8 — Swap Provider to Production

Edit `lib/core/monetization/monetization_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'monetization_service.dart';
import 'production_monetization_service.dart';

final monetizationProvider = Provider<MonetizationService>((ref) {
  return ProductionMonetizationService();
});
```

**Using `--dart-define` for flavor-based swapping:**

```dart
final monetizationProvider = Provider<MonetizationService>((ref) {
  const flavor = String.fromEnvironment('flavor', defaultValue: 'dev');
  if (flavor == 'production') {
    return ProductionMonetizationService();
  }
  return DevMonetizationService();
});
```

Run production build:
```bash
flutter run --dart-define=flavor=production
```

---

## Step 9 — Enable Ads for Real

In `ProductionMonetizationService`, call `enableAds()` when the app is ready to show ads:

```dart
// In app_bootstrap.dart or after initialization
final monetization = container.read(monetizationProvider);
if (monetization is ProductionMonetizationService) {
  monetization.enableAds();
}
```

Or set it via a remote config / feature flag once implemented.

---

## Step 10 — Test with Test Ads

Google provides test ad unit IDs:

| Platform | Ad Format | Test Ad Unit ID |
|----------|-----------|-----------------|
| Android | Banner | `ca-app-pub-3940256099942544/6300978111` |
| Android | Native advanced | `ca-app-pub-3940256099942544/3986624511` |
| iOS | Banner | `ca-app-pub-3940256099942544/6300978111` |
| iOS | Native advanced | `ca-app-pub-3940256099942544/3986624511` |

Test ads will show "Test Ad" badges. Replace with real IDs before release.

---

## Step 11 — COPPA Compliance

For children under 13 (required for ABC Wonder's age 2-4 target):

```dart
final request = AdRequest(
  // Mark as child-directed treatment
  extras: <String, String>{
    'max_ad_content_rating': 'G',
  },
);
```

Additionally, tag the entire app as child-directed in AdMob settings:
1. Go to AdMob → App settings → **Child-directed treatment**
2. Set to **"Yes, this app is directed to children"**

This disables:
- Interest-based advertising
- Remarketing
- Ads that require behavioral data

Only contextual banners remain (keywords are based on the module content, not user behavior).

---

## Step 12 — Verify Parent Gate

The `ParentGatedWidget` is already wired into the `/parent` route:

```dart
// router.dart
GoRoute(
  path: '/parent',
  builder: (context, state) => const ParentGatedWidget(
    child: ParentDashboardScreen(),
  ),
),
```

After activation, you should also add parent gate before:
- Any ad click navigates to an external URL
- The IAP purchase flow begins

To trigger the gate programmatically:

```dart
final ok = await ParentGate.verify(context);
if (ok) {
  // proceed with ad click / purchase
}
```

---

## Step 13 — Adding Ads to Future Module Hubs

When building new module hub screens (Days, Months, Rewards, etc.), add the banner slot:

```dart
Scaffold(
  // ...
  bottomNavigationBar: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      AdBannerWidget(placementKey: AdPlacements.<module>Hub),
      _BottomNav(),
    ],
  ),
)
```

Add the new placement key to `AdPlacements` in `monetization_service.dart`:

```dart
static const String myModuleHub = 'my-module-hub';
```

And add an ad unit ID in `AdUnitIds`.

---

## Step 14 — Reverting to Dev Mode

To disable all ads and remove SDK dependency:

1. Swap the provider back:
```dart
return DevMonetizationService();
```

2. Remove `google_mobile_ads` and `in_app_purchase` from `pubspec.yaml`
3. Run `flutter pub get`
4. Remove AdMob app ID from `AndroidManifest.xml` and `Info.plist`
5. Remove `com.android.vending.BILLING` permission (auto-removed with plugin removal)

---

## File Reference

| File | What to change |
|------|---------------|
| `pubspec.yaml` | Add google_mobile_ads + in_app_purchase |
| `android/app/build.gradle` | Bump compileSdkVersion to 34 |
| `android/app/src/main/AndroidManifest.xml` | Add AdMob app ID meta-data |
| `ios/Runner/Info.plist` | Add GADApplicationIdentifier + SKAdNetworkItems |
| `lib/core/monetization/monetization_provider.dart` | Swap Dev → Production |
| `lib/core/monetization/production_monetization_service.dart` | Flesh out AdMob + IAP |
| `lib/core/monetization/ad_banner_widget.dart` | Replace SizedBox with real AdWidget |
| `lib/core/monetization/ad_unit_ids.dart` *(create)* | Map placement keys → ad unit IDs |
