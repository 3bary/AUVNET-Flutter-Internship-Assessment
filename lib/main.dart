import 'package:auvnet_app/features/auth/presentation/view_model/auth_bloc/auth_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/services/firebase_auth_service.dart';
import 'core/utils/simple_bloc_observer.dart';
import 'features/auth/data/repos/auth_repo.dart';
import 'features/splash/presentation/views/splash_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();
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
        return BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: AuthRepository(FirebaseAuthService())),
          child: MaterialApp(
            title: 'E-commerce App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.rubikTextTheme(),
            ),
            home: child,
          ),
        );
      },
      child: const SplashView(), // Your initial screen
    );
  }
}
