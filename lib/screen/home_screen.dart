import 'package:flutter/material.dart';
import '../models/alarm.dart';
import '../services/storage_service.dart';
import '../theme.dart';
import 'alarm_edit_screen.dart';

// ═══════════════════════════════════════════════════════════════
// HomeScreen (Beranda)
//
// PERAN : Frontend Developer (Anggota 2) & System Logic (Anggota 3)
// ALUR INTEGRASI (Penyimpanan Lokal SharedPreferences):
//   1. Saat aplikasi dibuka, load data alarm dari StorageService.
//   2. Jika kosong -> tampilkan Page 02 (Beranda Kosong).
//   3. Jika ada alarm -> tampilkan Page 01 (Beranda Berisi + Kartu Alarm Berikutnya).
//   4. Perubahan toggle switch, tambah alarm, edit, dan hapus tersimpan permanen.
// ═══════════════════════════════════════════════════════════════

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── List Alarm Asli dari StorageService ──
  List<Alarm> _alarms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlarms();
  }

  Future<void> _loadAlarms() async {
    final alarms = await StorageService.loadAlarms();
    if (mounted) {
      setState(() {
        _alarms = alarms;
        _isLoading = false;
      });
    }
  }

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

  // Fungsi navigasi ke Tambah Alarm (Page 03)
  Future<void> _navigateToAddAlarm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AlarmEditScreen(),
      ),
    );

    if (result != null) {
      await _loadAlarms();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
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
    final nextInfo = StorageService.getNextAlarm(_alarms);
    final nextTime = nextInfo != null ? nextInfo.alarm.formattedTime : 'Belum ada';
    final nextLabel = nextInfo != null ? nextInfo.alarm.label : 'Tidak ada alarm aktif';
    final relativeText = nextInfo != null
        ? nextInfo.relativeTimeText
        : 'Aktifkan alarm untuk mulai';

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
                Text(
                  relativeText,
                  style: const TextStyle(fontSize: 13, color: AppColors.textOnCard),
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

    if (result != null) {
      await _loadAlarms();
    }
  }

  Widget _buildAlarmCard({required Alarm item, required int index}) {
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
                onChanged: (val) async {
                  setState(() {
                    _alarms[index] = item.copyWith(isActive: val);
                  });
                  await StorageService.toggleAlarm(item.id, val);
                  await _loadAlarms();
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
