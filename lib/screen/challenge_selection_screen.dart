import 'package:flutter/material.dart';
import '../theme.dart';

// ═══════════════════════════════════════════════════════════════
// ChallengeSelectionScreen (04 · Pilih tantangan)
//
// PERAN : Frontend Developer (Anggota 2)
// ATURAN: File ini HANYA mengatur antarmuka pemilihan & urutan tantangan.
//         Tanpa integrasi sensor / kamera / evaluasi matematika.
//         Ketika tombol "Gunakan X tantangan" ditekan, ia mengembalikan
//         daftar tantangan terpilih ke layar Tambah Alarm.
// ═══════════════════════════════════════════════════════════════

class ChallengeItemUI {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  ChallengeItemUI({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class ChallengeSelectionScreen extends StatefulWidget {
  final List<String> initialSelectedIds;

  const ChallengeSelectionScreen({
    super.key,
    this.initialSelectedIds = const ['math', 'typing', 'shake'],
  });

  @override
  State<ChallengeSelectionScreen> createState() => _ChallengeSelectionScreenState();
}

class _ChallengeSelectionScreenState extends State<ChallengeSelectionScreen> {
  // Daftar 6 jenis tantangan kebangunan dasar sesuai PRD & Mockup
  final List<ChallengeItemUI> _allChallenges = [
    ChallengeItemUI(
      id: 'math',
      title: 'Matematika',
      subtitle: '3 jawaban benar beruntun',
      icon: Icons.calculate_outlined,
    ),
    ChallengeItemUI(
      id: 'typing',
      title: 'Mengetik kalimat',
      subtitle: 'Salin 1 kalimat tanpa salah',
      icon: Icons.text_fields_rounded,
    ),
    ChallengeItemUI(
      id: 'shake',
      title: 'Goyang ponsel',
      subtitle: '20 goyangan terdeteksi',
      icon: Icons.vibration_rounded,
    ),
    ChallengeItemUI(
      id: 'jump',
      title: 'Lompat',
      subtitle: '10 lompatan · sensor gerak',
      icon: Icons.directions_run_rounded,
    ),
    ChallengeItemUI(
      id: 'photo',
      title: 'Foto objek',
      subtitle: 'Cari gelas · kamera belakang',
      icon: Icons.camera_alt_outlined,
    ),
    ChallengeItemUI(
      id: 'selfie',
      title: 'Selfie',
      subtitle: 'Wajah terdeteksi · kamera depan',
      icon: Icons.person_outline_rounded,
    ),
  ];

  // List ID tantangan yang terpilih (berurutan)
  late List<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.initialSelectedIds);
  }

  void _toggleChallenge(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        // Jangan izinkan unselect jika tersisa hanya 1 (sesuai aturan "Pilih minimal 1")
        if (_selectedIds.length > 1) {
          _selectedIds.remove(id);
        }
      } else {
        _selectedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedIds.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              // ── Header: Back button + Judul ──
              _buildTopBar(context),
              const SizedBox(height: 8),

              // ── Subtitle motivasi ──
              const Text(
                'Bikin mata melek, satu per satu.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),

              // ── Banner Info Peach ──
              _buildInfoBanner(selectedCount),
              const SizedBox(height: 16),

              // ── Daftar 6 Kartu Tantangan ──
              ..._allChallenges.map((item) {
                final isSelected = _selectedIds.contains(item.id);
                final orderIndex = isSelected ? _selectedIds.indexOf(item.id) + 1 : 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildChallengeCard(item, isSelected, orderIndex),
                );
              }),

              const SizedBox(height: 8),

              // ── Catatan Izin Sensor / Kamera Bawah ──
              const Center(
                child: Text(
                  'Kamera & sensor diminta saat tantangan dimulai.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Tombol CTA Gunakan Tantangan ──
              _buildSubmitButton(context, selectedCount),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ═════════════════════════ WIDGETS KOMPONEN ═════════════════════════

  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          color: AppColors.textPrimary,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 16),
        const Text(
          'Pilih tantangan',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBanner(int count) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2E2), // soft peach/krem sesuai mockup
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pilih minimal 1. Geser  untuk urutan.',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$count dipilih · ~${count * 1} menit untuk selesai',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard(ChallengeItemUI item, bool isSelected, int orderIndex) {
    return GestureDetector(
      onTap: () => _toggleChallenge(item.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF3EFE9), // putih bila aktif, abu lembut bila tidak
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF9540) : Colors.transparent, // border oranye tipis saat aktif
            width: 1.5,
          ),
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Color(0x0CFF9540),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // ── Ikon Tantangan ──
            Icon(
              item.icon,
              size: 26,
              color: isSelected ? const Color(0xFF1E293B) : const Color(0xFF64748B),
            ),
            const SizedBox(width: 16),

            // ── Teks Judul & Deskripsi ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.textPrimary : const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? AppColors.textSecondary : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),

            // ── Badge Nomor Urut atau Kotak Kosong ──
            if (isSelected) ...[
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF8533), // badge oranye
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$orderIndex',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Ikon drag handle titik 6 (::: drag icon)
              const Icon(
                Icons.drag_indicator_rounded,
                size: 22,
                color: Color(0xFF94A3B8),
              ),
            ] else ...[
              // Kotak kosong saat tidak terpilih (rounded checkbox style)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFFCBD5E1),
                    width: 1.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, int count) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () {
          // Ambil nama tantangan terpilih untuk dikirim balik ke Edit Alarm
          final selectedTitles = _selectedIds.map((id) {
            final match = _allChallenges.firstWhere((c) => c.id == id);
            return match.title;
          }).toList();

          Navigator.pop(context, selectedTitles);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF8533),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          'Gunakan $count tantangan',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
