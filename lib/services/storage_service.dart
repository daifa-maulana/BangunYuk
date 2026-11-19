// ═══════════════════════════════════════════════════════════════
// Storage Service — BangunYuk
// PERAN : System & Logic Developer (Anggota 3) - Flow 1
// ═══════════════════════════════════════════════════════════════

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/alarm.dart';

class NextAlarmInfo {
  final Alarm alarm;
  final Duration remaining;
  final String relativeTimeText; // contoh: "Besok · 8 jam 15 menit lagi"

  NextAlarmInfo({
    required this.alarm,
    required this.remaining,
    required this.relativeTimeText,
  });
}

class StorageService {
  static const String _alarmStorageKey = 'bangunyuk_alarms_v1';

  /// 1. Mengambil semua alarm yang tersimpan dari SharedPreferences.
  /// Otomatis diurutkan berdasarkan jam dan menit (paling pagi di atas).
  static Future<List<Alarm>> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_alarmStorageKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      final alarms = decoded
          .map((item) => Alarm.fromJson(item as Map<String, dynamic>))
          .toList();

      // Urutkan dari jam paling awal
      alarms.sort((a, b) {
        final timeA = a.hour * 60 + a.minute;
        final timeB = b.hour * 60 + b.minute;
        return timeA.compareTo(timeB);
      });

      return alarms;
    } catch (e) {
      // Jika terjadi kegagalan parsing, kembalikan list kosong
      return [];
    }
  }

  /// 2. Menyimpan alarm baru atau memperbarui alarm yang sudah ada (berdasarkan ID).
  static Future<void> saveAlarm(Alarm alarm) async {
    final alarms = await loadAlarms();
    final index = alarms.indexWhere((a) => a.id == alarm.id);

    if (index >= 0) {
      alarms[index] = alarm; // Update mode
    } else {
      alarms.add(alarm); // Tambah baru
    }

    await _saveAll(alarms);
  }

  /// 3. Mengubah status aktif/nonaktif alarm (toggle Switch di HomeScreen).
  static Future<void> toggleAlarm(int id, bool isActive) async {
    final alarms = await loadAlarms();
    final index = alarms.indexWhere((a) => a.id == id);
    if (index >= 0) {
      alarms[index] = alarms[index].copyWith(isActive: isActive);
      await _saveAll(alarms);
    }
  }

  /// 4. Menghapus alarm berdasarkan ID uniknya.
  static Future<void> deleteAlarm(int id) async {
    final alarms = await loadAlarms();
    alarms.removeWhere((a) => a.id == id);
    await _saveAll(alarms);
  }

  /// 5. Menghitung dan mencari alarm aktif berikutnya yang paling dekat dengan waktu saat ini.
  static NextAlarmInfo? getNextAlarm(List<Alarm> alarms) {
    final activeAlarms = alarms.where((a) => a.isActive).toList();
    if (activeAlarms.isEmpty) return null;

    final now = DateTime.now();
    Alarm? closestAlarm;
    DateTime? closestTime;
    Duration? minDiff;

    for (final alarm in activeAlarms) {
      final scheduled = _calculateNextTriggerTime(alarm, now);
      final diff = scheduled.difference(now);

      if (minDiff == null || diff < minDiff) {
        minDiff = diff;
        closestTime = scheduled;
        closestAlarm = alarm;
      }
    }

    if (closestAlarm == null || closestTime == null || minDiff == null) {
      return null;
    }

    // Bangun teks deskripsi selisih waktu
    final hours = minDiff.inHours;
    final minutes = minDiff.inMinutes % 60;
    String timeDiffText = '';
    if (hours > 0) {
      timeDiffText = '$hours jam ${minutes > 0 ? '$minutes menit ' : ''}lagi';
    } else {
      timeDiffText = '${minutes.clamp(1, 60)} menit lagi';
    }

    String dayPrefix = 'Hari ini';
    if (closestTime.day != now.day) {
      final tomorrow = now.add(const Duration(days: 1));
      if (closestTime.day == tomorrow.day && closestTime.month == tomorrow.month) {
        dayPrefix = 'Besok';
      } else {
        const hariList = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
        dayPrefix = hariList[closestTime.weekday - 1];
      }
    }

    return NextAlarmInfo(
      alarm: closestAlarm,
      remaining: minDiff,
      relativeTimeText: '$dayPrefix · $timeDiffText',
    );
  }

  // ── Helper Privat: Hitung waktu berdering berikutnya untuk sebuah alarm ──
  static DateTime _calculateNextTriggerTime(Alarm alarm, DateTime now) {
    if (alarm.repeatDays.isEmpty) {
      // Alarm sekali bunyi:
      var candidate = DateTime(now.year, now.month, now.day, alarm.hour, alarm.minute);
      if (candidate.isBefore(now) || candidate.isAtSameMomentAs(now)) {
        // Jika jamnya sudah lewat hari ini, jadwalkan besok
        candidate = candidate.add(const Duration(days: 1));
      }
      return candidate;
    }

    // Alarm berulang: cari hari terdekat yang ada di repeatDays (1 = Senin ... 7 = Minggu)
    for (int dayOffset = 0; dayOffset <= 7; dayOffset++) {
      final candidateDate = now.add(Duration(days: dayOffset));
      final candidateWeekday = candidateDate.weekday;

      if (alarm.repeatDays.contains(candidateWeekday)) {
        final candidate = DateTime(
          candidateDate.year,
          candidateDate.month,
          candidateDate.day,
          alarm.hour,
          alarm.minute,
        );
        if (candidate.isAfter(now)) {
          return candidate;
        }
      }
    }

    // Fallback default: besok pada jam yang sama
    return now.add(const Duration(days: 1));
  }

  // ── Helper Privat: Simpan daftar alarm ke SharedPreferences ──
  static Future<void> _saveAll(List<Alarm> alarms) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = alarms.map((a) => a.toJson()).toList();
    await prefs.setString(_alarmStorageKey, jsonEncode(jsonList));
  }
}