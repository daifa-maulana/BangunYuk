import 'package:flutter/material.dart';
import '../theme.dart';

// ═══════════════════════════════════════════════════════════════
// StatsScreen (Statistik) — Placeholder layar statistik.
// Akan diisi komponen streak, grafik 7 hari, dll. nanti.
// ═══════════════════════════════════════════════════════════════

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              size: 64,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'Statistik',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Streak & grafik jam bangun akan tampil di sini.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
