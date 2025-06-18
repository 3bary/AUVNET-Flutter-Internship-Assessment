import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.rubikTextTheme(),
          ),
          home: child,
        );
      },
      child: const SplashView(), // Your initial screen
    );
  }
}
