import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/splash/presentation/views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design size from Figma (standard mobile design)
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          title: 'E-commerce App',
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const SplashView(), // Your initial screen
    );
  }
}
