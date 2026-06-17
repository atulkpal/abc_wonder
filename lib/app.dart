import 'package:flutter/material.dart';
import 'package:abc_wonder/theme/app_theme.dart';
import 'package:abc_wonder/screens/home_screen.dart';
import 'package:abc_wonder/screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABC Wonder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const SplashScreen(),
      routes: {
        '/home': (_) => const HomeScreen(),
      },
    );
  }
}
