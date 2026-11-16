# Panduan Kerja: Frontend Developer (Anggota 2)
## Proyek: BangunYuk — Smart Habit-Breaking Alarm

Sebagai **Frontend Developer**, Anda bertanggung jawab atas seluruh antarmuka visual, interaktivitas pengguna, tema (Material 3), dan alur navigasi aplikasi Flutter. Tampilan yang Anda bangun harus responsif, modern, dan mudah dipahami oleh orang yang baru saja bangun tidur.

---

## 🎯 Target Utama Anda pada Fase Perancangan Awal
1. Struktur arsitektur folder kode Flutter rapi dan modular.
2. Slicing seluruh screen dari Figma buatan Anggota 4 (UI/UX) menjadi widget Flutter yang hidup.
3. Menyediakan wadah komponen dinamis untuk antrean tugas bangun tidur (*RingingScreen & Task Container*).

---

## 🛠️ Tools & Tech Stack
- **Framework**: Flutter 3.x / Dart 3.x.
- **Design Reference**: Figma (disediakan oleh Anggota 4).
- **Komponen Utama**: Material 3 Design (`ThemeData`, `ColorScheme`, `FilledButton`, `Card`, `Switch`).
- **State Management**: Sederhana & terarah (`StatefulWidget` / `ValueNotifier` / `Provider`).

---

## 🪜 Langkah-Langkah Kerja Tahap Demi Tahap

### Langkah 1: Setup Struktur Proyek & Tema (Hari 1–2)
- [ ] Atur folder dalam `lib/`:
  ```
  lib/
  ├── main.dart
  ├── theme.dart                 # Konfigurasi Material 3 (Dark/Light Mode)
  ├── app_nav.dart               # Global navigator & route names
  ├── models/                    # Diambil dari Anggota 3
  ├── services/                  # Diambil dari Anggota 3
  └── screens/
      ├── home_screen.dart       # Daftar alarm aktif
      ├── alarm_edit_screen.dart # Form pembuatan/edit alarm
      ├── ringing_screen.dart    # Layar alarm meraung
      ├── stats_screen.dart      # Statistik & streak
      ├── settings_screen.dart   # Pengaturan & panduan baterai
      └── tasks/
          └── task_widgets.dart  # UI untuk 6 tugas kebangunan
  ```
- [ ] Implementasikan `theme.dart` sesuai palet warna dan tipografi dari Figma (sertakan tema gelap dan terang).

### Langkah 2: Slicing Halaman Konfigurasi Alarm (Hari 2–3)
- [ ] **Home Screen**:
  - Tampilkan list alarm yang tersimpan dengan kartu modern.
  - Tambahkan toggle switch on/off, informasi repetisi hari, dan badge jenis tugas yang dipilih.
  - Sediakan banner peringatan jika izin alarm/baterai belum aktif.
  - Floating Action Button (FAB) `+` untuk menambah alarm baru.
- [ ] **Alarm Edit Screen**:
  - Time picker besar (jam & menit).
  - Pilihan repetisi: Sekali, Setiap Hari, Senin–Jumat, atau Custom hari.
  - Selector tugas bangun tidur (bisa memilih lebih dari satu tugas, diatur nomor urutnya).
  - Pengaturan jumlah snooze (0 sampai 3x).

### Langkah 3: Slicing Layar Alarm Berdering & Komponen Tugas (Hari 3–5)
- [ ] **Ringing Screen**:
  - Tampilan jam digital besar berkedip dengan kontras tinggi.
  - Indikator antrean tugas: *"Tugas 1 dari 2: Kerjakan Soal Matematika"*.
  - Sembunyikan tombol navigasi default dan tangani `PopScope` agar pengguna tidak bisa menekan tombol Back untuk keluar.
- [ ] **Wadah Tugas (Task Widgets)**:
  - Widget Soal Matematika (input keypad angka besar & feedback benar/salah).
  - Widget Ketik Frasa (box teks motivasi & textfield input).
  - Widget Goyang HP (progress bar goyangan 0/20 & animasi getar).
  - Widget Lompat (progress bar lompatan 0/15).
  - Widget Kamera (viewfinder kamera sederhana & tombol shutter).

### Langkah 4: Slicing Halaman Statistik & Pengaturan (Hari 5–6)
- [ ] **Stats Screen**: Kartu *Streak Bangun* (ikon api), total hari sukses, dan grafik ringkasan 7 hari terakhir.
- [ ] **Settings Screen**: Pilihan tema, status izin sistem, dan tombol pintas panduan optimasi baterai OEM.

### Langkah 5: Wiring Bersama System Developer (Hari 6–7)
- [ ] Sambungkan tombol "Simpan" ke service penyimpanan milik Anggota 3.
- [ ] Sambungkan layar *Ringing Screen* agar terbuka saat event alarm native terpicu.

---

## 📋 Checklist Kriteria Sukses (Definition of Done Frontend)
- [ ] Semua screen berjalan mulus tanpa error `RenderFlex overflow`.
- [ ] Tidak ada hardcoded warna; semua menggunakan `Theme.of(context)`.
- [ ] Skenario multi-task menampilkan transisi tugas berikutnya secara mulus saat tugas sebelumnya selesai.

