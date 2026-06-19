import 'package:flutter/material.dart';
import 'package:abc_wonder/theme/app_theme.dart';
import 'package:abc_wonder/bootstrap/router.dart';
import 'package:abc_wonder/core/constants/app_constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routerConfig: router,
    );
  }
}
