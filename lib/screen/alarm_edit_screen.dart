import 'package:flutter/material.dart';
import '../models/alarm.dart';
import '../services/storage_service.dart';
import '../theme.dart';
import 'challenge_selection_screen.dart';

// ═══════════════════════════════════════════════════════════════
// AlarmEditScreen (03 · Tambah alarm & 05 · Edit alarm)
//
// PERAN : Frontend Developer (Anggota 2) & System Logic (Anggota 3)
// FITUR:
//   - Mode Tambah: Jam awal otomatis jam saat ini, judul "Tambah alarm".
//   - Mode Edit: Judul "Edit alarm", tombol teks merah "Hapus alarm".
//   - Drum-wheel interaktif jam & menit.
//   - Terhubung dengan Page 04 (Pilih tantangan).
//   - Menyimpan permanen ke SharedPreferences via StorageService.
// ═══════════════════════════════════════════════════════════════

class AlarmEditScreen extends StatefulWidget {
  final Alarm? existingAlarm;
  final int? alarmIndex;

  const AlarmEditScreen({
    super.key,
    this.existingAlarm,
    this.alarmIndex,
  });

  bool get isEditMode => existingAlarm != null;

  @override
  State<AlarmEditScreen> createState() => _AlarmEditScreenState();
}

class _AlarmEditScreenState extends State<AlarmEditScreen> {
  late TextEditingController _labelController;
  late FixedExtentScrollController _hourScrollController;
  late FixedExtentScrollController _minuteScrollController;

  int _selectedHour = 6;
  int _selectedMinute = 0;

  // Visual hari: default semua nonaktif (alarm berdering sekali saja)
  final List<bool> _repeatDays = [false, false, false, false, false, false, false];
  final List<String> _dayLabels = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];
  final List<String> _dayNames = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];

  bool _snoozeEnabled = true;

  // Daftar nama tantangan terpilih (visual)
  List<String> _selectedChallenges = ['Matematika', 'Mengetik kalimat', 'Goyang ponsel'];

  @override
  void initState() {
    super.initState();

    if (widget.isEditMode) {
      final alarm = widget.existingAlarm!;
      _labelController = TextEditingController(text: alarm.label);
      _selectedHour = alarm.hour;
      _selectedMinute = alarm.minute;
      _snoozeEnabled = alarm.snoozeEnabled;
      if (alarm.taskIds.isNotEmpty) {
        _selectedChallenges = List.from(alarm.taskIds);
      }

      // Parsing hari pengulangan (1 = Senin ... 7 = Minggu)
      for (int i = 0; i < 7; i++) {
        _repeatDays[i] = alarm.repeatDays.contains(i + 1);
      }
    } else {
      // Inisialisasi awal mengikuti jam dan menit saat ini
      final now = DateTime.now();
      _selectedHour = now.hour;
      _selectedMinute = now.minute;
      // Kolom label dikosongkan (default placeholder hint text)
      _labelController = TextEditingController(text: '');
    }

    _hourScrollController = FixedExtentScrollController(initialItem: _selectedHour);
    _minuteScrollController = FixedExtentScrollController(initialItem: _selectedMinute);
  }

  @override
  void dispose() {
    _labelController.dispose();
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildTopBar(context),
              const SizedBox(height: 20),

              // ── Interactive Drum-Wheel Time Picker Card ──
              _buildInteractiveTimePickerCard(),
              const SizedBox(height: 24),

              const Text(
                'Label alarm',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              _buildLabelField(),
              const SizedBox(height: 20),

              const Text(
                'Ulangi',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              _buildRepeatDayChips(),
              const SizedBox(height: 20),

              _buildSnoozeCard(),
              const SizedBox(height: 12),

              _buildChallengesCard(),
              const SizedBox(height: 16),

              _buildSoundRow(),
              const SizedBox(height: 16),

              // ── Tombol Hapus Alarm (Khusus Page 05 · Edit Alarm) ──
              if (widget.isEditMode) ...[
                Center(
                  child: TextButton(
                    onPressed: _showDeleteConfirmDialog,
                    child: const Text(
                      'Hapus alarm',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFE53935), // warna merah soft sesuai mockup
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // ── Tombol Simpan Alarm ──
              _buildSaveButton(context),
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
        Text(
          widget.isEditMode ? 'Edit alarm' : 'Tambah alarm',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveTimePickerCard() {
    return Container(
      width: double.infinity,
      height: 170,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: SizedBox(
          width: 260,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Wheel Jam (00 - 23) ──
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: _hourScrollController,
                  itemExtent: 52,
                  perspective: 0.003,
                  diameterRatio: 1.4,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedHour = index % 24;
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final h = index % 24;
                      final isSelected = h == _selectedHour;
                      return Center(
                        child: Text(
                          h.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: isSelected ? 48 : 20,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF1D2939)
                                : const Color(0x669E9E9E),
                          ),
                        ),
                      );
                    },
                    childCount: 240,
                  ),
                ),
              ),

              // ── Titik Dua (:) ──
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  ':',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1D2939),
                  ),
                ),
              ),

              // ── Wheel Menit (00 - 59) ──
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  controller: _minuteScrollController,
                  itemExtent: 52,
                  perspective: 0.003,
                  diameterRatio: 1.4,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedMinute = index % 60;
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final m = index % 60;
                      final isSelected = m == _selectedMinute;
                      return Center(
                        child: Text(
                          m.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: isSelected ? 48 : 20,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF1D2939)
                                : const Color(0x669E9E9E),
                          ),
                        ),
                      );
                    },
                    childCount: 600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabelField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFB37C), width: 1.5),
      ),
      child: TextField(
        controller: _labelController,
        style: const TextStyle(
          fontSize: 15,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
          hintText: 'Nama alarm (opsional)',
          hintStyle: TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildRepeatDayChips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final isSelected = _repeatDays[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              _repeatDays[index] = !_repeatDays[index];
            });
          },
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF1E293B) : AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                if (!isSelected)
                  const BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
              ],
            ),
            child: Center(
              child: Text(
                _dayLabels[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSnoozeCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.access_time_rounded,
              size: 20,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Snooze',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '5 menit · maksimal 3 kali',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _snoozeEnabled,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.activeGreen,
            onChanged: (val) {
              setState(() {
                _snoozeEnabled = val;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChallengesCard() {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push<List<String>>(
          context,
          MaterialPageRoute(
            builder: (context) => const ChallengeSelectionScreen(),
          ),
        );
        if (result != null && result.isNotEmpty) {
          setState(() {
            _selectedChallenges = result;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF2E2),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.tune_rounded,
              color: AppColors.textPrimary,
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_selectedChallenges.length} tantangan dipilih',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _selectedChallenges.join(' → '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoundRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Icon(
            Icons.wb_sunny_outlined,
            size: 22,
            color: AppColors.textPrimary,
          ),
          SizedBox(width: 12),
          Text(
            'Nada: Pagi ceria',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Spacer(),
          Text(
            'Ubah',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus alarm?'),
        content: const Text('Alarm ini akan dihapus dari daftar.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx); // Tutup dialog
              if (widget.existingAlarm != null) {
                await StorageService.deleteAlarm(widget.existingAlarm!.id);
              }
              if (context.mounted) {
                Navigator.pop(context, 'DELETE');
              }
            },
            child: const Text('Hapus', style: TextStyle(color: Color(0xFFE53935), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () async {
          final activeDays = <int>[];
          for (int i = 0; i < 7; i++) {
            if (_repeatDays[i]) {
              activeDays.add(i + 1); // 1 = Senin ... 7 = Minggu
            }
          }

          final alarm = Alarm(
            id: widget.existingAlarm?.id ??
                (DateTime.now().millisecondsSinceEpoch % 2147483647),
            hour: _selectedHour,
            minute: _selectedMinute,
            label: _labelController.text.trim().isEmpty
                ? 'Alarm'
                : _labelController.text.trim(),
            repeatDays: activeDays,
            taskIds: _selectedChallenges,
            isActive: true,
            snoozeEnabled: _snoozeEnabled,
          );

          await StorageService.saveAlarm(alarm);

          if (context.mounted) {
            Navigator.pop(context, alarm);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF8533),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Simpan alarm',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
