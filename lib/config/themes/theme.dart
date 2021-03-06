// Flutter imports:
import 'package:flutter/material.dart';

class AppColors {
  static const lightBlue1 = Color(0xFF30AAFF);
  static const lightBlue2 = Color(0xFF33CFFF);
  static const orange1 = Color(0xFFF15A24);
  static const orange2 = Color(0xFFF68F1F);
  static const green = Color(0xFF4BB543);
  static const red = Color(0xFFB50000);

  static const white = Color(0xFFFFFFFF);
  static const darkGrey = Color(0xFF696969);
  static const grey = Color(0xFFD9D9D9);
  static const lightGrey = Color(0xFFE5E5E5);
  static const shadowText = Color(0xFF9A9A9A);
  static const nearBlack = Color(0xFF252525);
  static const shadowBlack = Color(0x19000000); // Opacity 25/255
  static const darkShadowBlack = Color(0x32000000); // Opacity 50/255
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);
}

class AppGradients {
  static const primaryLinear = LinearGradient(
    colors: <Color>[
      AppColors.lightBlue1,
      AppColors.lightBlue2,
    ],
  );
  static const accentLinear = LinearGradient(
    colors: <Color>[
      AppColors.orange1,
      AppColors.orange2,
    ],
  );
}

class AppTheme {
  static ThemeData of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      brightness: Brightness.light,
      primaryColor: AppColors.nearBlack,
      accentColor: AppColors.orange1,
      backgroundColor: AppColors.lightGrey,
      scaffoldBackgroundColor: AppColors.lightGrey,
      errorColor: AppColors.red,
      shadowColor: AppColors.shadowBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightGrey,
        centerTitle: true,
        brightness: Brightness.dark,
        elevation: 0,
        textTheme: TextTheme(
          headline5: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
          headline6: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
          color: AppColors.black,
        ),
        headline2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: AppColors.black,
        ),
        headline3: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 48,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        headline4: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.black,
        ),
        headline5: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        headline6: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: AppColors.black,
        ),
        subtitle1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: AppColors.black,
        ),
        subtitle2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.black,
        ),
        bodyText1: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: AppColors.black,
        ),
        bodyText2: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.shadowText,
        ),
        button: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
          color: AppColors.white,
        ),
        caption: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.black,
        ),
        overline: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          color: AppColors.black,
        ),
      ),
    );
  }
}
