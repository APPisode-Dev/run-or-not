import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:run_or_not/core/di/injector.dart';

void main() {
  setupDependencies();
  runApp(MyApp(router: getIt<GoRouter>()));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
