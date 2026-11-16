# Panduan Kerja: System & Logic Developer (Anggota 3)
## Proyek: BangunYuk — Smart Habit-Breaking Alarm

Sebagai **System & Logic Developer**, Anda memegang "jantung" fungsionalitas dari BangunYuk. Tugas Anda memastikan alarm berbunyi tanpa kompromi (reliabilitas 100%), volume tidak bisa dikecilkan pengguna, data tersimpan aman secara offline, dan algoritma sensor tugas berfungsi akurat.

---

## 🎯 Target Utama Anda pada Fase Perancangan Awal
1. Riset & validasi native Foreground Service Android dengan package `alarm`.
2. Implementasi mekanisme *Volume Lock* (memaksa volume 100% jika ditekan turun).
3. Penyusunan model data lokal dan penyimpanan via `SharedPreferences`.
4. Pemrograman logika sensor (akselerometer untuk goyang/lompat) dan generator matematika.

---

## 🛠️ Tools & Libraries Utama
- **Alarm Engine**: `package:alarm` (menggunakan AlarmManager Android & Foreground Service `mediaPlayback`).
- **Sensor**: `package:sensors_plus` (membaca accelerometer stream).
- **Kamera**: `package:camera` (viewfinder & capture foto offline).
- **Penyimpanan**: `package:shared_preferences` (serialisasi JSON).
- **Audio Control**: Platform channel / volume listener native.

---

## 🪜 Langkah-Langkah Kerja Tahap Demi Tahap

### Langkah 1: Spike POC Alarm Engine Native (Hari 1–2)
- [ ] Konfigurasi `android/app/src/main/AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM"/>
  <uses-permission android:name="android.permission.USE_EXACT_ALARM"/>
  <uses-permission android:name="android.permission.USE_FULL_SCREEN_INTENT"/>
  <uses-permission android:name="android.permission.WAKE_LOCK"/>
  <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
  <uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK"/>
  <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
  <uses-permission android:name="android.permission.VIBRATE"/>
  ```
- [ ] Buat file spike uji coba untuk membunyikan alarm saat aplikasi di-kill dari recent apps dan saat HP terkunci.

### Langkah 2: Pemodelan Data & Storage Service (Hari 2–3)
- [ ] Buat file `lib/models/alarm.dart`:
  - Model `Alarm`: `id`, `timeOfDay`, `daysOfWeek`, `isActive`, `taskIds`, `snoozeCount`.
  - Serialisasi `toJson()` dan `fromJson()`.
- [ ] Buat file `lib/services/storage_service.dart`:
  - `saveAlarms(List<Alarm> alarms)`
  - `getAlarms(): Future<List<Alarm>>`
  - `saveHistory(HistoryRecord record)`
  - `getStreak(): int`

### Langkah 3: Mekanisme Proteksi & Anti-Cheat (Hari 3–4)
- [ ] **Volume Override**:
  - Pasang timer periodik atau listener volume ketika layar alarm berdering aktif.
  - Jika volume media berada di bawah level maksimal, panggil method untuk menaikkannya kembali ke 1.0 (100%).
- [ ] **Full Screen Intent Handler**:
  - Konfigurasikan package `alarm` agar callback alarm memanggil navigator global `AppNav.openRingingScreen(alarmId)`.

### Langkah 4: Logika Sensor & Engine Tugas Kebangunan (Hari 4–5)
- [ ] **Logika Matematika (`lib/screens/tasks/math_logic.dart`)**:
  - Buat generator soal aritmatika acak dengan tingkat kesulitan berjenjang.
  - Buat state validasi: wajib 3 kali jawaban benar berturut-turut.
- [ ] **Logika Goyang HP (`shake_logic.dart`)**:
  - Berlangganan ke `userAccelerometerEvents`.
  - Hitung magnitudo vektor: $\sqrt{x^2 + y^2 + z^2} > \text{threshold}$ (misal 15.0).
  - Berikan *debouncing* (jeda minimal 250ms antar goyangan) agar tidak terhitung berkali-kali dalam 1 getaran.
- [ ] **Logika Deteksi Lompat (`jump_logic.dart`)**:
  - Deteksi urutan: akselerasi mendekati 0 G (*free fall saat di udara*) diikuti lonjakan mendadak > 2.5 G (*impact saat mendarat*).
- [ ] **Logika Tangkapan Kamera**:
  - Inisialisasi controller kamera belakang (untuk foto barang) atau depan (untuk selfie).
  - Simpan foto sementara ke cache directory untuk memvalidasi bahwa foto telah berhasil diambil.

### Langkah 5: Integrasi & Handoff ke QA (Hari 6–7)
- [ ] Satukan service dengan UI yang sudah dibuat Anggota 2 (Frontend).
- [ ] Jalankan uji coba internal awal sebelum diserahkan ke Anggota 5 (QA).

---

## 📋 Checklist Kriteria Sukses (Definition of Done System Dev)
- [ ] Alarm berbunyi tepat waktu saat aplikasi ditutup total dan HP terkunci.
- [ ] Tombol volume fisik tidak bisa mengecilkan suara alarm hingga padam.
- [ ] Data alarm dan riwayat streak tidak hilang saat aplikasi ditutup atau HP direstart.
- [ ] Tidak ada exception sensor yang menyebabkan aplikasi crash.

