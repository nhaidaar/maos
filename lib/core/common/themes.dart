import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: neutralWhite,
    primaryColor: neutralBlack,
    fontFamily: 'PlusJakartaSans',

    // Add the custom color extension
    extensions: <ThemeExtension<dynamic>>[
      AppColorExtension(
        neutral100: neutralBlack,
        neutral90: neutralBlack90,
        neutral80: neutralBlack80,
        neutral70: neutralBlack70,
        neutral60: neutralBlack60,
        neutral50: neutralBlack50,
        neutral40: neutralBlack40,
        neutral30: neutralBlack30,
        neutral20: neutralBlack20,
        neutral10: neutralBlack10,
      ),
    ],

    colorScheme: ColorScheme.light(
      primary: neutralBlack,
      surface: neutralWhite,
      onPrimary: neutralWhite,
      onSurface: neutralBlack,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: neutralBlack,
    primaryColor: neutralWhite,
    fontFamily: 'PlusJakartaSans',
    extensions: <ThemeExtension<dynamic>>[
      AppColorExtension(
        neutral100: neutralWhite,
        neutral90: neutralWhite90,
        neutral80: neutralWhite80,
        neutral70: neutralWhite70,
        neutral60: neutralWhite60,
        neutral50: neutralWhite50,
        neutral40: neutralWhite40,
        neutral30: neutralWhite30,
        neutral20: neutralWhite20,
        neutral10: neutralWhite10,
      ),
    ],
    colorScheme: ColorScheme.dark(
      primary: neutralWhite,
      surface: neutralBlack,
      onPrimary: neutralBlack,
      onSurface: neutralWhite,
    ),
  );
}

class AppColorExtension extends ThemeExtension<AppColorExtension> {
  final Color neutral100;
  final Color neutral90;
  final Color neutral80;
  final Color neutral70;
  final Color neutral60;
  final Color neutral50;
  final Color neutral40;
  final Color neutral30;
  final Color neutral20;
  final Color neutral10;

  AppColorExtension({
    required this.neutral100,
    required this.neutral90,
    required this.neutral80,
    required this.neutral70,
    required this.neutral60,
    required this.neutral50,
    required this.neutral40,
    required this.neutral30,
    required this.neutral20,
    required this.neutral10,
  });

  @override
  ThemeExtension<AppColorExtension> copyWith({
    Color? neutral100,
    Color? neutral90,
    Color? neutral80,
    Color? neutral70,
    Color? neutral60,
    Color? neutral50,
    Color? neutral40,
    Color? neutral30,
    Color? neutral20,
    Color? neutral10,
  }) {
    return AppColorExtension(
      neutral100: neutral100 ?? this.neutral100,
      neutral90: neutral90 ?? this.neutral90,
      neutral80: neutral80 ?? this.neutral80,
      neutral70: neutral70 ?? this.neutral70,
      neutral60: neutral60 ?? this.neutral60,
      neutral50: neutral50 ?? this.neutral50,
      neutral40: neutral40 ?? this.neutral40,
      neutral30: neutral30 ?? this.neutral30,
      neutral20: neutral20 ?? this.neutral20,
      neutral10: neutral10 ?? this.neutral10,
    );
  }

  @override
  ThemeExtension<AppColorExtension> lerp(
    ThemeExtension<AppColorExtension>? other,
    double t,
  ) {
    if (other is! AppColorExtension) {
      return this;
    }
    return AppColorExtension(
      neutral100: Color.lerp(neutral100, other.neutral100, t)!,
      neutral90: Color.lerp(neutral90, other.neutral90, t)!,
      neutral80: Color.lerp(neutral80, other.neutral80, t)!,
      neutral70: Color.lerp(neutral70, other.neutral70, t)!,
      neutral60: Color.lerp(neutral60, other.neutral60, t)!,
      neutral50: Color.lerp(neutral50, other.neutral50, t)!,
      neutral40: Color.lerp(neutral40, other.neutral40, t)!,
      neutral30: Color.lerp(neutral30, other.neutral30, t)!,
      neutral20: Color.lerp(neutral20, other.neutral20, t)!,
      neutral10: Color.lerp(neutral10, other.neutral10, t)!,
    );
  }
}

extension AppColorExtensions on ThemeData {
  AppColorExtension get appColors =>
      extension<AppColorExtension>() ??
      AppColorExtension(
        neutral100: neutralBlack,
        neutral90: neutralBlack90,
        neutral80: neutralBlack80,
        neutral70: neutralBlack70,
        neutral60: neutralBlack60,
        neutral50: neutralBlack50,
        neutral40: neutralBlack40,
        neutral30: neutralBlack30,
        neutral20: neutralBlack20,
        neutral10: neutralBlack10,
      );
}
