import 'package:flutter/material.dart';
import '../theme.dart';

// ═══════════════════════════════════════════════════════════════
// ProfileScreen (Profil) — Placeholder layar profil / pengaturan.
// Akan diisi nama pengguna, setting tema, panduan baterai, dll.
// ═══════════════════════════════════════════════════════════════

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_rounded,
              size: 64,
              color: AppColors.primary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'Profil',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pengaturan & info profil akan tampil di sini.',
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
