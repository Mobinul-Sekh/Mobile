import 'package:flutter/material.dart';

class AppColors {
  static const lightBlue1 = Color(0xFF2CCEFF);
  static const lightBlue2 = Color(0xFF33CFFF);
  static const orange1 = Color(0xFFF15A24);
  static const orange2 = Color(0xFFF68F1F);
  static const red = Color(0xFFB50000);

  static const white = Color(0xFFFFFFFF);
  static const lightGrey = Color(0xFFE5E5E5);
  static const shadowText = Color(0xFF9A9A9A);
  static const nearBlack = Color(0xFF252525);
  static const shadowBlack = Color(0x19000000);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);
}

class AppGradients {
  static const primaryGradient = LinearGradient(
    colors: <Color>[
      AppColors.lightBlue1,
      AppColors.lightBlue2,
    ],
  );
  static const accentGradient = LinearGradient(
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
      errorColor: AppColors.red,
      shadowColor: AppColors.shadowBlack,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.nearBlack,
        centerTitle: true,
        brightness: Brightness.dark,
        textTheme: theme.appBarTheme.textTheme?.copyWith(
          headline6: theme.appBarTheme.textTheme?.headline6?.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline5: theme.textTheme.headline5?.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
        bodyText1: theme.textTheme.bodyText1?.copyWith(
          fontSize: 17,
        ),
      ),
      floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
        backgroundColor: AppColors.nearBlack,
        elevation: 3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: theme.elevatedButtonTheme.style?.copyWith(
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.nearBlack),
          elevation: MaterialStateProperty.all<double>(2),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(6),
          ),
        ),
      ),
    );
  }
}
