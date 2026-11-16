import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════
// Palet warna & tema BangunYuk — diambil dari mockup Figma.
// File ini hanya berisi DEFINISI TAMPILAN, tanpa logika bisnis.
// ═══════════════════════════════════════════════════════════════

class AppColors {
  AppColors._();

  // ── Background & Surface ──────────────────────────────
  static const Color background = Color(0xFFFFF8F0);
  static const Color surface = Color(0xFFFFFFFF);

  // ── Primary (kuning-oranye hangat) ────────────────────
  static const Color primary = Color(0xFFFFB340);
  static const Color primarySoft = Color(0xFFFFF0D4);

  // ── Gradient kartu "Alarm Berikutnya" ─────────────────
  static const Color nextAlarmStart = Color(0xFFFFE8A8);
  static const Color nextAlarmEnd = Color(0xFFFFCF54);

  // ── Teks ──────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color textOnCard = Color(0xFF5C3D00);

  // ── Aksen ─────────────────────────────────────────────
  static const Color activeGreen = Color(0xFF34C759);
  static const Color navActive = Color(0xFFFF9500);

  // ── Border & Shadow ───────────────────────────────────
  static const Color cardBorder = Color(0xFFF0F0F0);
  static const Color shadow = Color(0x0A000000);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          surface: AppColors.background,
          brightness: Brightness.light,
        ),
      );
}
