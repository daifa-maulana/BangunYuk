# Panduan Kerja Tim Berdasarkan Alur (Flow-Based Collaboration)
## Proyek: BangunYuk — Smart Habit-Breaking Alarm

Metode ini membagi pekerjaan **berdasarkan alur fitur nyata (*feature-by-feature*)**, bukan teori divisi terpisah. Dengan cara ini, semua anggota tim langsung bergerak serentak (*paralel*) di setiap fitur, tanpa saling tunggu.

---

## 🔁 FLOW 1: Pengaturan & Tampilan Alarm (Alarm Setup & List Flow)

> **Goal Flow Ini**: Pengguna bisa melihat daftar alarm di Home Screen, menekan tombol `+`, memilih jam & hari, lalu alarm tersimpan rapi.

```
[UI/UX / Sketsa Layout] ──▶ [Frontend: Bikin Layar Flutter]
                                      │
[System: Bikin Model & Storage] ──────┴──▶ [Wiring & Integrasi] ──▶ [QA: Uji Fungsi] ──▶ [PM: ACC Selesai]
```

### 1. 🎨 Anggota UI/UX (atau yang memegang alur tampilan)
**Tugas Konkret**:
- Menentukan komponen apa saja yang wajib ada di layar:
  - **Layar 1 (Home Screen)**: Jam digital besar untuk alarm berikutnya, daftar kartu alarm (waktu, repetisi hari, tombol switch on/off), dan tombol `+` (Floating Action Button).
  - **Layar 2 (Alarm Edit Screen)**: Pemilih jam (Time Picker), chip hari (Senin–Minggu), tombol pilih tugas, dan slider snooze.
- **Output Cepat**: Sketsa kasar di kertas / Figma / Excalidraw yang menunjukkan letak tombol-tombol tersebut agar Frontend langsung tahu apa yang harus diketik.

### 2. 💻 Anggota Frontend Developer
**Tugas Konkret**:
- Membuat file `lib/screens/home_screen.dart`:
  - Bangun `ListView.builder` untuk menampilkan deretan kartu alarm.
  - Pasang komponen `Switch` aktif/nonaktif di setiap kartu.
  - Buat tombol `FloatingActionButton` untuk berpindah (*navigasi*) ke layar edit.
- Membuat file `lib/screens/alarm_edit_screen.dart`:
  - Pasang widget `showTimePicker()` bawaan Flutter (Material 3).
  - Pasang sederet `FilterChip` untuk pilihan hari (Sen, Sel, Rab, Kam, Jum, Sab, Min).
  - Buat tombol "Simpan" di bagian bawah.

### 3. ⚙️ Anggota System & Logic Developer
**Tugas Konkret**:
- Membuat blueprint data di `lib/models/alarm.dart`:
  ```dart
  class Alarm {
    final int id;
    final int hour;
    final int minute;
    final List<int> repeatDays; // contoh: [1, 2, 3, 4, 5] untuk Sen-Jum
    final bool isActive;
    final List<String> taskIds;
  }
  ```
- Membuat fungsi penyimpanan lokal di `lib/services/storage_service.dart`:
  - Buat fungsi `saveAlarm(Alarm alarm)` menggunakan `SharedPreferences`.
  - Buat fungsi `loadAlarms()` untuk mengambil daftar alarm yang pernah disimpan.
- **Serah terima ke Frontend**: Berikan fungsi `saveAlarm()` ke Frontend agar saat tombol "Simpan" ditekan, datanya langsung tersimpan.

### 4. 🧪 Anggota QA & Testing
**Tugas Konkret**:
- Menyiapkan lembar uji untuk flow ini dan langsung mencoba di HP/Emulator:
  - **Tes 1**: Tambah alarm baru jam 06:30 $\rightarrow$ Apakah muncul di Home Screen?
  - **Tes 2**: Matikan switch alarm $\rightarrow$ Apakah statusnya berubah jadi abu-abu/tidak aktif?
  - **Tes 3**: Tutup aplikasi (*Swipe kill*) lalu buka lagi $\rightarrow$ Apakah alarm yang tadi dibuat masih ada atau hilang?
  - **Tes 4**: Coba tekan tombol "Batal" saat edit $\rightarrow$ Pastikan data tidak berubah sembarangan.
- Laporkan jika ada error, teks kepotong (*overflow*), atau data yang gagal tersimpan.

### 5. 📋 Anggota Project Manager (PM)
**Tugas Konkret**:
- Menyatukan kesepakatan format: Memastikan Frontend dan System Developer sepakat menggunakan format jam yang sama (misal: 24 jam atau AM/PM).
- Memastikan flow ini selesai 100% dan tidak ada bug sebelum tim pindah ke flow berikutnya.
- Menandai centang di checklist bahwa **Flow 1 SUKSES**.

---

## 🔁 FLOW 2: Alarm Berdering & Layar Misi Kebangunan (Ringing & Task Flow)

> **Goal Flow Ini**: Saat jam alarm tiba, suara berbunyi kencang, layar terkunci otomatis menyala, volume dikunci 100%, dan pengguna wajib menyelesaikan tugas.

| Anggota | Tugas Konkret di Flow Ini |
| :--- | :--- |
| **UI/UX** | Merancang tampilan layar darurat: Jam besar berkedip, teks instruksi *"Kerjakan 3 Soal Matematika untuk Mematikan Alarm"*, keypad angka besar. |
| **System & Logic** | Mengaktifkan package `alarm` (Foreground Service Android), memasang listener pengunci volume suara (jika volume ditekan turun $\rightarrow$ otomatis balik 100%), dan logika generator soal matematika acak. |
| **Frontend** | Membuat `lib/screens/ringing_screen.dart`, mengunci tombol Back (`PopScope` agar tidak bisa ditekan keluar), dan menampilkan widget soal matematika. |
| **QA** | Menguji skenario nyata: Kunci layar HP, tunggu jam alarm tiba, pastikan HP menyala sendiri, coba tekan tombol fisik volume bawah (wajib tidak bisa mati). |
| **PM** | Memantau integrasi antara event bunyi alarm dari System Dev dengan layar UI yang dibuka Frontend. |

---
 
## 🔁 FLOW 3: Statistik & Riwayat Bangun (Gamifikasi)

> **Goal Flow Ini**: Setiap kali pengguna sukses menyelesaikan tugas di Flow 2, streak bangun bertambah dan tercatat di halaman riwayat.

| Anggota | Tugas Konkret di Flow Ini |
| :--- | :--- |
| **UI/UX** | Desain kartu statistik: Ikon api streak (🔥), angka hari sukses, dan grafik mingguan sederhana. |
| **System & Logic** | Fungsi penambah streak harian di `storage_service.dart`: Hitung apakah hari ini sudah bangun tepat waktu, catat timestamp selesai tugas. |
| **Frontend** | Membuat `lib/screens/stats_screen.dart`: Menampilkan data streak dari System Dev dan merender bar chart sederhana 7 hari terakhir. |
| **QA** | Uji coba: Selesaikan tugas alarm $\rightarrow$ buka halaman statistik $\rightarrow$ cek apakah streak bertambah 1. Coba ubah tanggal HP untuk tes ketahanan streak. |
| **PM** | Evaluasi keseluruhan produk, persiapan dokumentasi akhir, dan demo video progres. |

