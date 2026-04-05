import 'package:flutter/material.dart';

/// Black surfaces with red accents across Echo Realm.
ThemeData buildEchoRealmTheme() {
  final base = ColorScheme.fromSeed(
    seedColor: const Color(0xFFDC2626),
    brightness: Brightness.dark,
  );

  final colorScheme = base.copyWith(
    primary: const Color(0xFFE53935),
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFF5C0F0F),
    onPrimaryContainer: const Color(0xFFFFDAD6),
    secondary: const Color(0xFFB91C1C),
    onSecondary: Colors.white,
    tertiary: const Color(0xFF7F1D1D),
    surface: const Color(0xFF0A0A0A),
    onSurface: const Color(0xFFE8E8E8),
    onSurfaceVariant: const Color(0xFFB8B8B8),
    surfaceContainerHighest: const Color(0xFF181818),
    outline: const Color(0xFF404040),
    outlineVariant: const Color(0xFF2C2C2C),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFF050505),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black.withValues(alpha: 0.78),
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      titleTextStyle: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF121212),
      elevation: 10,
      shadowColor: Colors.black.withValues(alpha: 0.55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: BorderSide(
          color: colorScheme.primary.withValues(alpha: 0.22),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
      labelStyle: TextStyle(
        color: colorScheme.onSurfaceVariant,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      contentTextStyle: TextStyle(color: Color(0xFFF5F5F5)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
