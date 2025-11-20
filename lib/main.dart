import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'core/theme/app_theme.dart'; // Import the new theme file

void main() {
  runApp(const WejhaApp());
}

class WejhaApp extends StatelessWidget {
  const WejhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wejha App',
          
          // Language and RTL settings
          locale: const Locale('ar', 'AE'), 
          supportedLocales: const [
            Locale('ar', 'AE'),
            Locale('en', 'US'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          theme: AppTheme.lightTheme, // Use the theme from the new file
          
          home: const OnboardingScreen(),
        );
      },
    );
  }
}
