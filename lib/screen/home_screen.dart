import 'package:flutter/material.dart';
import '../theme.dart';
import 'alarm_edit_screen.dart';

// ═══════════════════════════════════════════════════════════════
// HomeScreen (Beranda)
//
// PERAN : Frontend Developer (Anggota 2)
// ALUR UI MURNI (In-Memory Dummy List untuk Pengetesan Frontend):
//   1. Awalnya daftar alarm kosong (Page 02 · Beranda Kosong).
//   2. Pengguna klik "+ Buat alarm pertama" -> buka Page 03 (Tambah Alarm).
//   3. Di Page 03 klik "Simpan alarm" -> kembali ke Beranda dan
//      data dummy langsung masuk ke tampilan (Page 01 · Beranda Berisi).
//   Semua tanpa backend/database/service. Murni simulasi interaksi UI.
// ═══════════════════════════════════════════════════════════════

class DummyAlarmUI {
  final String time;
  final String label;
  final int taskCount;
  final List<String> days;
  bool isActive;

  DummyAlarmUI({
    required this.time,
    required this.label,
    required this.taskCount,
    required this.days,
    this.isActive = true,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── List UI Dummy (Murni State Lokal Widget) ──
  // Awalnya kosong agar menampilkan Page 02 (Beranda Kosong)
  final List<DummyAlarmUI> _alarms = [];

  // ── Helper format presentasi tanggal & sapaan ──
  static const _hari = [
    'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
  ];
  static const _bulan = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  String get _formattedDate {
    final now = DateTime.now();
    return '${_hari[now.weekday - 1]}, ${now.day} ${_bulan[now.month - 1]}';
  }

  String get _greeting {
    final jam = DateTime.now().hour;
    if (jam < 11) return 'Pagi';
    if (jam < 15) return 'Siang';
    if (jam < 18) return 'Sore';
    return 'Malam';
  }

  // Fungsi navigasi ke Tambah Alarm (Page 03) dan menerima hasil visual
  Future<void> _navigateToAddAlarm() async {
    final result = await Navigator.push<DummyAlarmUI>(
      context,
      MaterialPageRoute(
        builder: (context) => const AlarmEditScreen(),
      ),
    );

    // Jika user klik "Simpan alarm", tambahkan ke list visual lokal
    if (result != null) {
      setState(() {
        _alarms.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _alarms.isEmpty ? _buildEmptyHome() : _buildFilledHome(),
    );
  }

  // ══════════════════════════════════════════════════════════════════
  // PAGE 02: BERANDA KOSONG
  // ══════════════════════════════════════════════════════════════════
  Widget _buildEmptyHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 120,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  _formattedDate,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$_greeting, Naya!',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 48),

                // Ilustrasi jam
                Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: const BoxDecoration(
                      color: AppColors.primarySoft,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('⏰', style: TextStyle(fontSize: 72)),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                const Center(
                  child: Text(
                    'Pagi baru, cerita baru.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Belum ada alarm. Yuk, atur waktu bangun dan mulai pagi dengan lebih semangat.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.4,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),

            // Tombol CTA ke Page 03 (Tambah Alarm)
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _navigateToAddAlarm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8533),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      '+ Buat alarm pertama',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Alarm tetap berbunyi saat aplikasi ditutup.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════
  // PAGE 01: BERANDA BERISI
  // ══════════════════════════════════════════════════════════════════
  Widget _buildFilledHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          _buildFilledHeader(),
          const SizedBox(height: 20),
          _buildNextAlarmCard(),
          const SizedBox(height: 28),
          _buildAlarmListHeader(),
          const SizedBox(height: 12),

          // Render daftar alarm dari state lokal widget
          ...List.generate(_alarms.length, (index) {
            final item = _alarms[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildAlarmCard(item: item, index: index),
            );
          }),

          const SizedBox(height: 20),
          _buildQuote(),
          const SizedBox(height: 16),

          // Tombol "+ Tambah alarm" ke Page 03
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _navigateToAddAlarm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8533),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                '+ Tambah alarm',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildFilledHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formattedDate,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$_greeting, Naya!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.primarySoft,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.wb_sunny_rounded,
            color: AppColors.primary,
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget _buildNextAlarmCard() {
    final nextTime = _alarms.isNotEmpty ? _alarms.first.time : '06.00';
    final nextLabel = _alarms.isNotEmpty ? _alarms.first.label : 'Pagi produktif';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.nextAlarmStart, AppColors.nextAlarmEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ALARM BERIKUTNYA',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: AppColors.textOnCard,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  nextTime,
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Besok · 20 jam 19 menit lagi',
                  style: TextStyle(fontSize: 13, color: AppColors.textOnCard),
                ),
                const SizedBox(height: 2),
                Text(
                  nextLabel,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textOnCard,
                  ),
                ),
              ],
            ),
          ),
          const Text('⏰', style: TextStyle(fontSize: 48)),
        ],
      ),
    );
  }

  Widget _buildAlarmListHeader() {
    final activeCount = _alarms.where((a) => a.isActive).length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Alarm kamu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          '$activeCount aktif',
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // Fungsi navigasi ke Edit Alarm (Page 05) saat kartu diklik
  Future<void> _navigateToEditAlarm(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AlarmEditScreen(
          existingAlarm: _alarms[index],
          alarmIndex: index,
        ),
      ),
    );

    if (result == 'DELETE') {
      setState(() {
        _alarms.removeAt(index);
      });
    } else if (result is DummyAlarmUI) {
      setState(() {
        _alarms[index] = result;
      });
    }
  }

  Widget _buildAlarmCard({required DummyAlarmUI item, required int index}) {
    return GestureDetector(
      onTap: () => _navigateToEditAlarm(index),
      child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                item.time,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Switch(
                value: item.isActive,
                activeThumbColor: Colors.white,
                activeTrackColor: AppColors.activeGreen,
                onChanged: (val) {
                  setState(() {
                    item.isActive = val;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${item.label} · ${item.taskCount} tantangan',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: item.days
                .map((d) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        d,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildQuote() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.wb_sunny_outlined,
          size: 18,
          color: AppColors.textSecondary,
        ),
        SizedBox(width: 8),
        Text(
          'Pagi kecil, perubahan besar.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
