import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassTheme {
  // Colors inspired by iOS and MT5
  static const Color iosBlue = Color(0xFF007AFF);
  static const Color iosGreen = Color(0xFF34C759);
  static const Color iosRed = Color(0xFFFF3B30);
  static const Color iosGrey = Color(0xFF8E8E93);
  static const Color iosLightGrey = Color(0xFFD1D1D6);
  static const Color iosSystemGrey6 = Color(0xFFF2F2F7);
  static const Color glassBackground = Color(0xCCFFFFFF);
  static const Color glassBorder = Color(0x4D000000);
  static const Color lightBackground = Colors.white;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackground,
    primaryColor: iosBlue,
    dividerColor: iosLightGrey,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(color: iosBlue),
    ),
    textTheme: GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: Colors.black.withOpacity(0.9),
      ),
    ),
  );

  static LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.8),
      Colors.white.withOpacity(0.4),
    ],
  );
}

