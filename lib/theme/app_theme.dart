import 'package:flutter/material.dart';

class AppTheme {
  // 颜色定义（对应CSS变量）
  static const Color background = Color(0xFFFFFFFF);
  static const Color foreground = Color(0xFF111111);
  static const Color card = Color(0xFFF5F5F5);
  static const Color cardForeground = Color(0xFF111111);
  static const Color primary = Color(0xFF111111);
  static const Color primaryForeground = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF222222);
  static const Color secondaryForeground = Color(0xFFFFFFFF);
  static const Color muted = Color(0xFFEFEFEF);
  static const Color mutedForeground = Color(0xFF555555);
  static const Color accent = Color(0xFF111111);
  static const Color accentForeground = Color(0xFFFFFFFF);
  static const Color highlight = Color(0xFF000000);
  static const Color destructive = Color(0xFFD4183D);
  static const Color destructiveForeground = Color(0xFFE5E7EB);
  static const Color border = Color(0xFFE0E0E0);
  static const Color success = Color(0xFF4CAF50);
  static const Color progressTrack = Color(0x22000000);
  static const Color divider = Color(0xFFDDDDDD);
  static const Color tertiaryForeground = Color(0xFF666666);

  // 圆角定义
  static const double radius = 16.0;
  static const double radiusCard = 16.0;
  static const double radiusFrame = 24.0;

  // 字体大小定义
  static const double fontSizeBase = 16.0;
  static const double fontSizeSmall = 12.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeXLarge = 24.0;
  static const double fontSizeXXLarge = 28.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.light(
        primary: primary,
        onPrimary: primaryForeground,
        secondary: secondary,
        onSecondary: secondaryForeground,
        surface: card,
        onSurface: foreground,
        background: background,
        onBackground: foreground,
        error: destructive,
        onError: destructiveForeground,
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
          side: const BorderSide(color: border, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: fontSizeXXLarge,
          fontWeight: FontWeight.w500,
          color: foreground,
          height: 1.5,
        ),
        displayMedium: TextStyle(
          fontSize: fontSizeXLarge,
          fontWeight: FontWeight.w500,
          color: foreground,
          height: 1.5,
        ),
        displaySmall: TextStyle(
          fontSize: fontSizeLarge,
          fontWeight: FontWeight.w500,
          color: foreground,
          height: 1.5,
        ),
        bodyLarge: TextStyle(
          fontSize: fontSizeBase,
          fontWeight: FontWeight.normal,
          color: foreground,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: fontSizeBase,
          fontWeight: FontWeight.normal,
          color: foreground,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontSize: fontSizeSmall,
          fontWeight: FontWeight.normal,
          color: mutedForeground,
          height: 1.5,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: primaryForeground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme => lightTheme;
}


