# BangunYuk ⏰

Aplikasi alarm Flutter untuk orang yang sulit bangun meski sudah memasang alarm.
Alarm tidak bisa dimatikan sebelum pengguna menyelesaikan **tugas kebangunan** yang memaksa otak atau tubuh bekerja.

---

## 🚀 Fitur Utama

- **Alarm Lokal** — Tambah/edit/hapus, pola sekali, tiap hari, Senin–Jumat, atau hari custom.
- **Alarm Native (Package `alarm`)** — Suara, getar, dan layar tugas dijalankan oleh Foreground Service Android, sehingga alarm **tetap berbunyi walau aplikasi ditutup / di-swipe dari recent apps / HP terkunci**, dan dijadwalkan ulang otomatis setelah HP restart.
- **Volume Terkunci (*Anti-Cheat*)** — Menekan tombol fisik volume tidak bisa mengecilkan alarm (volume langsung otomatis dikembalikan penuh 100%).
- **Banyak Tugas Sekaligus (*Multi-Task Sequencing*)** — Pilih sebanyak yang kamu mau; dikerjakan berurutan sesuai nomor urut, dan alarm baru berhenti setelah SEMUA selesai.
- **6 Tugas Kebangunan**:
  1. 🧮 **Matematika** — 3 jawaban benar berturut-turut, kesulitan naik saat salah.
  2. ⌨️ **Ketik Frasa** — Frasa motivasi acak harus diketik persis.
  3. 📳 **Goyang HP** — 20 goyangan dalam 30 detik (sensor akselerometer).
  4. 🤸 **Lompat** — 15 lompatan dalam 60 detik (deteksi percepatan *free-fall + impact*).
  5. 📷 **Foto Barang** — Foto barang yang dipilih (buku, gelas, sikat gigi, dll).
  6. 🤳 **Selfie** — Foto wajah dengan kamera depan.
- **Snooze Terbatas** — Maksimal 0–3 kali per alarm.
- **Statistik & Gamifikasi** — Streak bangun pagi, total berhasil, dan grafik jam bangun 7 hari.
- **Privasi 100% Offline** — Semua data tersimpan lokal (`SharedPreferences`). Tanpa backend luar, tanpa analitik, tanpa izin aksesibilitas.

---

## 📁 Dokumentasi Perancangan Proyek

Dokumentasi lengkap perancangan awal untuk tim 5 orang telah disusun rapi:

- 📄 **[PRD_BangunYuk.md](PRD_BangunYuk.md)** — *Product Requirement Document* (Spesifikasi produk, problem statement, OKR/KPI, NFR, user flow).
- 📋 **[Checklist_Perancangan_Awal.md](Checklist_Perancangan_Awal.md)** — Master To-Do List perancangan awal lengkap dengan *RACI Matrix*.
- 🗺️ **[PANDUAN_TIM_DAN_ALUR_KERJA.md](PANDUAN_TIM_DAN_ALUR_KERJA.md)** — Peta kolaborasi tim, alur *handoff*, dan aturan branching Git.
- 🔁 **[Panduan_Pengerjaan_Per_Flow.md](Panduan_Pengerjaan_Per_Flow.md)** — Pembagian kerja konkret per alur fitur (Flow 1: Setup Alarm, Flow 2: Ringing & Misi, Flow 3: Statistik).
- 🎬 **[Naskah_Video_Progres.md](Naskah_Video_Progres.md)** — Naskah presentasi video progres berdurasi 4–5 menit untuk 5 anggota kelompok.
- 👥 **Panduan Peran Mandiri**:
  - `panduan_peran/01_Project_Manager.md`
  - `panduan_peran/02_Frontend_Developer.md`
  - `panduan_peran/03_System_Logic_Developer.md`
  - `panduan_peran/04_UI_UX_Designer.md`
  - `panduan_peran/05_QA_User_Testing.md`

---

## 🏗️ Struktur Arsitektur Kode (Rencana)

```
lib/
├── main.dart                     # bootstrap, navigasi alarm
├── theme.dart                    # Material 3, tema gelap/terang
├── models/alarm.dart             # model alarm + pola ulang + task
├── app_nav.dart                  # navigator + pembuka layar alarm
├── services/
│   ├── storage_service.dart      # SharedPreferences: alarm, riwayat, tema
│   ├── alarm_scheduler.dart      # jadwal + bunyi alarm (package alarm)
│   └── notification_service.dart # request & cek status perizinan
└── screens/
    ├── home_screen.dart          # daftar alarm + status izin
    ├── alarm_edit_screen.dart    # form alarm + pilih tugas
    ├── ringing_screen.dart       # layar alarm penuh (Full Screen Intent)
    ├── stats_screen.dart         # streak & grafik 7 hari
    ├── settings_screen.dart      # tema, izin, panduan baterai OEM, reset
    └── tasks/task_widgets.dart   # implementasi 6 widget tugas kebangunan
```

---

## 🔐 Izin Android Utama

- `POST_NOTIFICATIONS` — Menampilkan alarm & notifikasi.
- `SCHEDULE_EXACT_ALARM` / `USE_EXACT_ALARM` — Pemicu alarm presisi tepat waktu.
- `USE_FULL_SCREEN_INTENT` — Menyalakan layar penuh saat HP terkunci.
- `RECEIVE_BOOT_COMPLETED` — Menjadwalkan ulang alarm setelah HP reboot.
- `VIBRATE`, `WAKE_LOCK` — Getar dan membangunkan layar dari mode tidur.
- `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PLAYBACK` — Service audio alarm saat aplikasi di-swipe.
