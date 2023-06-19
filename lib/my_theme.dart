import 'package:flutter/material.dart';
// import 'package:cheery_messenger/allConstants/all_constants.dart';
import 'package:weatherpal/color_constants.dart';

final myTheme = ThemeData(
  primaryColor: AppColors.orangeWeb,
  scaffoldBackgroundColor: AppColors.teal,
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.orangeWeb),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.teal),
);
