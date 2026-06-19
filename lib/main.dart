import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:abc_wonder/app.dart';
import 'package:abc_wonder/bootstrap/app_bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await AppBootstrap.init(container);
  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
