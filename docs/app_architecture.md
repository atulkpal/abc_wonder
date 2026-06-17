# ABC Wonder — Architecture

## Stack

| Layer | Choice |
|---|---|
| Framework | Flutter 3.x |
| Language | Dart 3.x |
| State Management | provider (read-only — no mutations) |
| Routing | go_router |
| Responsive | flutter_screenutil |
| Text-to-Speech | flutter_tts |
| Min SDK | Android 5.0 (API 21), iOS 13 |

## Project Structure

```
lib/
├── main.dart                  # Entry point, ScreenUtilInit, runApp
├── app.dart                   # MaterialApp.router → GoRouter
├── theme/
│   └── app_theme.dart         # ThemeData with custom palette
├── models/                    # Data classes (no logic)
│   ├── letter.dart
│   ├── number.dart
│   ├── day.dart
│   └── month.dart
├── data/                      # Static data repositories
│   ├── alphabet_data.dart
│   ├── number_data.dart
│   ├── days_data.dart
│   └── months_data.dart
├── screens/
│   ├── splash_screen.dart
│   ├── home_screen.dart
│   ├── alphabet_screen.dart
│   ├── number_screen.dart
│   ├── days_screen.dart
│   └── months_screen.dart
├── widgets/
│   ├── category_card.dart
│   ├── letter_card.dart
│   ├── number_card.dart
│   ├── day_card.dart
│   ├── month_card.dart
│   └── audio_fab.dart
└── utils/
    └── tts_helper.dart
```

## Data Flow

```
[Static Data] → [Screen reads data directly] → [Widget displays + TTS on tap]
```

No backend. No mutations. All data is compile-time constants. The `TtsHelper` singleton wraps `flutter_tts`.

## Routing

| Route | Screen | Transition |
|---|---|---|
| `/` | SplashScreen | None (2s → auto-navigate `/home`) |
| `/home` | HomeScreen | Fade + scale |
| `/alphabet` | AlphabetScreen | Slide from right |
| `/numbers` | NumberScreen | Slide from right |
| `/days` | DaysScreen | Slide from right |
| `/months` | MonthsScreen | Slide from right |

## Responsive Strategy

- Use `flutter_screenutil` throughout (`ScreenUtil().setSp`, `.setWidth`, `.setHeight`)
- **Home grid**: 2 columns on phone, 4 columns on tablet
- **Letter/Number grid**: 4 columns on phone, 6 columns on tablet
- **Test breakpoints**: 360dp (small phone), 412dp (typical), 600dp (7" tablet), 800dp (10" tablet)

## Audio Strategy

- `flutter_tts` package — no audio files needed
- Speech rate: 0.4 (slow, child-friendly)
- Language: `en-US`
- Letters: speak the letter name + example ("A for Apple")
- Numbers: speak the number name
- Days/Months: speak the name

## Performance Targets

- APK size < 30 MB
- Cold start < 2s
- No jank on 60fps scrolling through 100 numbers
- Memory < 100 MB
