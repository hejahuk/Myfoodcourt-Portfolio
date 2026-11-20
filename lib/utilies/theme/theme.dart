import 'package:flutter/material.dart';
import 'package:food_court/utilies/theme/appBar_theme.dart';
import 'package:food_court/utilies/theme/botton_theme.dart';
import 'package:food_court/utilies/theme/checkbox_theme.dart';
import 'package:food_court/utilies/theme/chip_theme.dart';
import 'package:food_court/utilies/theme/custom_theme.dart';
import 'package:food_court/utilies/theme/elevated_button.dart';
import 'package:food_court/utilies/theme/outline_theme.dart';
import 'package:food_court/utilies/theme/textfield_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.red,
    textTheme: AppTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.LightCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.LightOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData dorkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    textTheme: AppTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: Color.fromARGB(0, 18, 18, 18),
    appBarTheme: AAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
