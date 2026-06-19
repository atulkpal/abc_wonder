/// Single source of truth for the app display name.
///
/// To rename the app, change [appName] here, then update:
///   - Android: `android/app/src/main/res/values/strings.xml`  (`app_name` key)
///   - iOS:     `ios/Runner/Info.plist`                          (`CFBundleDisplayName` + `CFBundleName`)
///   - macOS:   `macos/Runner/Info.plist`                        (`CFBundleName`)
///   - pubspec.yaml                                              (`description`)
class AppConstants {
  AppConstants._();

  static const String appName = 'ABC Wonder';
  static const String appTitle = 'ABC Wonder';
  static const String ttsLanguage = 'en-US';
  static const double ttsRate = 0.4;
  static const double ttsPitch = 1.1;
  static const int splashDurationMs = 2000;
}
