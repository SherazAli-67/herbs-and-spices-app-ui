import 'package:flutter/material.dart';
import 'package:herbs_and_spices_app/constants/string_const.dart';
import 'package:herbs_and_spices_app/core/app_colors.dart';
import 'package:herbs_and_spices_app/routing/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .light,
        fontFamily: StringConst.appFontFamily,
        scaffoldBackgroundColor: AppColors.whiteColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreenColor,
          primary: AppColors.primaryGreenColor,
          surface: AppColors.offWhiteColor,
          brightness: .light,
        ),
      ),
      routerConfig: router,
      builder: (ctx, child) => child!,
    );
  }
}
