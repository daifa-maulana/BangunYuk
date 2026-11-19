// ═══════════════════════════════════════════════════════════════
// Model Data Alarm — BangunYuk
// PERAN : System & Logic Developer (Anggota 3) - Flow 1
// ═══════════════════════════════════════════════════════════════

class Alarm {
  final int id;
  final int hour;
  final int minute;
  final String label;
  final List<int> repeatDays; // 1 = Senin ... 7 = Minggu. Kosong = Sekali saja
  final List<String> taskIds; // ID teknis misi, misal: ['math', 'typing']
  final bool isActive;
  final bool snoozeEnabled;

  const Alarm({
    required this.id,
    required this.hour,
    required this.minute,
    required this.label,
    required this.repeatDays,
    required this.taskIds,
    this.isActive = true,
    this.snoozeEnabled = true,
  });

  // ── Helper Getter untuk Integrasi Frontend (Orang 2) ──

  /// Format string jam dan menit tampilan, contoh: "06.00"
  String get formattedTime =>
      '${hour.toString().padLeft(2, '0')}.${minute.toString().padLeft(2, '0')}';

  /// Alias time untuk kompatibilitas langsung dengan UI Orang 2
  String get time => formattedTime;

  /// Jumlah tantangan yang dipilih
  int get taskCount => taskIds.length;

  /// Daftar label singkatan hari untuk dirender di kartu alarm
  static const List<String> _dayNames = [
    'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'
  ];

  List<String> get dayLabels {
    if (repeatDays.isEmpty) return ['Sekali'];
    if (repeatDays.length == 7) return ['Setiap hari'];
    if (repeatDays.length == 5 &&
        repeatDays.contains(1) &&
        repeatDays.contains(2) &&
        repeatDays.contains(3) &&
        repeatDays.contains(4) &&
        repeatDays.contains(5)) {
      return ['Sen - Jum'];
    }
    final sorted = List<int>.from(repeatDays)..sort();
    return sorted.map((d) => _dayNames[(d - 1).clamp(0, 6)]).toList();
  }

  /// Alias days untuk kompatibilitas langsung dengan UI Orang 2
  List<String> get days => dayLabels;

  // ── CopyWith Method ──
  Alarm copyWith({
    int? id,
    int? hour,
    int? minute,
    String? label,
    List<int>? repeatDays,
    List<String>? taskIds,
    bool? isActive,
    bool? snoozeEnabled,
  }) {
    return Alarm(
      id: id ?? this.id,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      label: label ?? this.label,
      repeatDays: repeatDays ?? this.repeatDays,
      taskIds: taskIds ?? this.taskIds,
      isActive: isActive ?? this.isActive,
      snoozeEnabled: snoozeEnabled ?? this.snoozeEnabled,
    );
  }

  // ── Serialisasi JSON untuk SharedPreferences ──
  Map<String, dynamic> toJson() => {
    'id': id,
    'hour': hour,
    'minute': minute,
    'label': label,
    'repeatDays': repeatDays,
    'taskIds': taskIds,
    'isActive': isActive,
    'snoozeEnabled': snoozeEnabled,
  };

  factory Alarm.fromJson(Map<String, dynamic> json) => Alarm(
    id: json['id'] as int,
    hour: json['hour'] as int,
    minute: json['minute'] as int,
    label: (json['label'] as String?)?.isNotEmpty == true
        ? json['label'] as String
        : 'Alarm',
    repeatDays: (json['repeatDays'] as List<dynamic>?)
            ?.map((e) => e as int)
            .toList() ??
        [],
    taskIds: (json['taskIds'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [],
    isActive: json['isActive'] as bool? ?? true,
    snoozeEnabled: json['snoozeEnabled'] as bool? ?? true,
  );
}
