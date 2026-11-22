# Naskah Video Progres Terkini (Sprint 1: Dari Perancangan ke Flow 1 & Optimasi)
## Format: Presentasi Kolaboratif Kelompok (5 Orang)

| Metadata Video | Keterangan |
| :--- | :--- |
| **Judul Proyek** | **BangunYuk — Smart Habit-Breaking Alarm** |
| **Target Durasi** | 4 – 5 Menit (Padat, Terstruktur, Standar Penilaian Kuliah/Sprint) |
| **Pemeran** | 5 Anggota (PM, Frontend, System/Logic, UI/UX, QA & Release) |
| **Fokus Cerita** | Perjalanan dari ide awal $\rightarrow$ desain Figma $\rightarrow$ kode Flutter $\rightarrow$ database lokal $\rightarrow$ optimasi APK 179 MB ke 9.19 MB $\rightarrow$ laporan QA. |

---

## 🎬 Panduan Visual & Pembagian Waktu (Timeline)

```
[00:00 - 00:50] Scene 1: Pembuka, Masalah, & Manajemen Tim (Anggota 1 - Project Manager)
[00:50 - 01:40] Scene 2: Perancangan UI/UX & Dua Kondisi Beranda di Figma (Anggota 4 - UI/UX Designer)
[01:40 - 02:30] Scene 3: Slicing Flutter & Navigasi 5 Layar (Anggota 2 - Frontend Developer)
[02:30 - 03:20] Scene 4: Arsitektur Model Data & Database SharedPreferences (Anggota 3 - System & Logic Dev)
[03:20 - 04:20] Scene 5: Laporan Audit QA & Terobosan Optimasi APK 9 MB (Anggota 5 - QA & Release Specialist)
[04:20 - 04:50] Scene 6: Evaluasi PM, Rencana Flow 2, & Penutup (Semua Anggota)
```

---

## 📜 Naskah Dialog & Panduan Visual (Lengkap Kata per Kata)

### ⏱️ SCENE 1: Pembuka, Masalah, & Manajemen Tim (00:00 – 00:50)
**Pemeran**: **Anggota 1 (Project Manager)**  
**Visual On-Screen**:
* *00:00–00:15*: Wajah Anggota 1 berbicara ke kamera dengan ramah dan percaya diri. Lower-third nama: `[Nama Anggota 1] — Project Manager`.
* *00:15–00:50*: Cuplikan orang mematikan alarm sambil mengantuk (*sleep inertia*), lalu muncul diagram alur kerja tim di dokumen `PANDUAN_TIM_DAN_ALUR_KERJA.md` serta repositori GitHub BangunYuk.

> **[DIALOG ANGGOTA 1 - PROJECT MANAGER]**:
> 
> *"Halo semuanya! Selamat datang di video progres proyek kelompok kami. Saya [Nama], berperan sebagai Project Manager untuk aplikasi **BangunYuk**.*
> 
> *Masalah yang sering kita alami setiap pagi adalah fenomena sleep inertia—di mana kita mematikan alarm secara setengah sadar lalu lanjut tidur lagi karena alarm bawaan HP terlalu mudah dimatikan.*
> 
> *Untuk mengatasi masalah ini, tim kami merancang **BangunYuk**, aplikasi alarm pintar berintegritas tinggi dengan misi kebangunan dan sistem anti-cheat.*
> 
> *Sebagai PM, saya membagi tugas 5 anggota secara paralel menggunakan metode **Flow-Based Sprint**. Pada progres kali ini, kami telah menuntaskan perancangan awal hingga eksekusi **Flow 1: Penyetelan & Penyimpanan Alarm**. Mari kita simak laporan dari masing-masing divisi!"*

---

### ⏱️ SCENE 2: Desain UI/UX & Dua Kondisi Beranda (00:50 – 01:40)
**Pemeran**: **Anggota 4 (UI/UX Designer)**  
**Visual On-Screen**:
* *00:50–01:05*: Wajah Anggota 4 menyapa. Lower-third: `[Nama Anggota 4] — UI/UX Designer`.
* *01:05–01:40*: *Screen recording* file Figma BangunYuk. Menyorot perbandingan frame **Page 02 (Beranda Kosong)** dengan ilustrasi jam matahari, lalu beralih ke **Page 01 (Beranda Berisi)** dengan banner kuning 06.00 dan kartu alarm.

> **[DIALOG ANGGOTA 4 - UI/UX DESIGNER]**:
> 
> *"Halo, saya [Nama], bertindak sebagai UI/UX Designer.*
> 
> *Tantangan utama dalam mendesain aplikasi alarm adalah membuat antarmuka yang ramah mata saat bangun tidur sekaligus jelas navigasinya.*
> 
> *Pada Flow 1 ini, saya merancang dua kondisi antarmuka utama di Figma:*
> *Pertama, **Beranda Kosong (Empty State)**: Ditujukan untuk pengguna baru, dilengkapi ilustrasi jam matahari tersenyum dan pesan motivasi 'Pagi baru, cerita baru' agar pengguna terdorong membuat alarm pertamanya.*
> *Kedua, **Beranda Berisi**: Menampilkan banner kuning alarm berikutnya dengan jam digital besar dan kartu daftar alarm yang rapi.*
> 
> *Desain ini menggunakan standar Google Material 3 dengan warna hangat dan kontras tinggi. Seluruh rancangan telah diserahterimakan ke tim frontend untuk diimplementasikan ke dalam kode Flutter."*

---

### ⏱️ SCENE 3: Slicing Flutter & Navigasi 5 Layar (01:40 – 02:30)
**Pemeran**: **Anggota 2 (Frontend Developer)**  
**Visual On-Screen**:
* *01:40–01:55*: Wajah Anggota 2. Lower-third: `[Nama Anggota 2] — Frontend Developer`.
* *01:55–02:30*: *Screen recording* VS Code dan rekaman layar HP yang menjalankan aplikasi Flutter. Menampilkan transisi otomatis dari Beranda Kosong $\rightarrow$ klik tombol oranye $\rightarrow$ muncul Beranda Berisi, lalu memperlihatkan 3 tab navigasi bawah (Beranda, Statistik, Profil).

> **[DIALOG ANGGOTA 2 - FRONTEND DEVELOPER]**:
> 
> *"Halo semua, saya [Nama], selaku Frontend Developer.*
> 
> *Tugas saya adalah menerjemahkan desain Figma dari Anggota 4 ke dalam kode Flutter yang responsif dan modular di dalam folder `lib/screen/`.*
> 
> *Kami berhasil membangun logika pergantian antarmuka otomatis: jika database masih kosong, layar merender Beranda Kosong; namun begitu alarm dibuat, tampilan otomatis berganti ke Beranda Berisi lengkap dengan kartu alarm dan switch toggle aktif.*
> 
> *Selain Beranda, kami juga telah menyiapkan kerangka untuk 5 layar utama, termasuk form edit alarm dengan TimePicker, halaman pemilihan misi tantangan, halaman statistik, dan profil yang dihubungkan melalui Bottom Navigation Bar yang mulus."*

---

### ⏱️ SCENE 4: Arsitektur Model Data & Database Lokal (02:30 – 03:20)
**Pemeran**: **Anggota 3 (System & Logic Developer)**  
**Visual On-Screen**:
* *02:30–02:45*: Wajah Anggota 3. Lower-third: `[Nama Anggota 3] — System & Logic Developer`.
* *02:45–03:20*: *Screen recording* file `lib/models/alarm.dart` dan `lib/services/storage_service.dart`. Menunjukkan kode serialisasi JSON dan fungsi `SharedPreferences`. Peragakan aplikasi ditutup total / direfresh di HP dan datanya tetap tersimpan aman.

> **[DIALOG ANGGOTA 3 - SYSTEM & LOGIC DEVELOPER]**:
> 
> *"Halo, saya [Nama], bertindak sebagai System & Logic Developer.*
> 
> *Di balik tampilan antarmuka yang rapi, tugas saya adalah membangun 'otak' penyimpanan data agar alarm tidak pernah hilang.*
> 
> *Saya merancang model data `Alarm` di `alarm.dart` yang memuat identitas jam, menit, label, hari berulang, dan status aktif.*
> *Kemudian, saya mengimplementasikan `StorageService` menggunakan SharedPreferences. Layanan ini menyediakan fungsi simpan, ambil, hapus, dan pengubahan status switch secara offline.*
> 
> *Koneksi antara frontend dan backend lokal ini terbukti berhasil: ketika pengguna membuat alarm atau mematikan switch, perubahannya tersimpan permanen di memori HP bahkan saat aplikasi ditutup total. Pondasi data ini siap kami gunakan untuk integrasi pemicu alarm native di Flow 2."*

---

### ⏱️ SCENE 5: Laporan Audit QA & Terobosan Optimasi APK 9 MB (03:20 – 04:20)
**Pemeran**: **Anggota 5 (QA, Performance & Release Specialist)**  
**Visual On-Screen**:
* *03:20–03:35*: Wajah Anggota 5. Lower-third: `[Nama Anggota 5] — QA, Performance & Release Specialist`.
* *03:35–04:00*: Tampilkan dokumen PDF *"Laporan Pengujian Flow 1"* yang dibuatnya (tabel lembar uji T1-T5 dan bug tracker).
* *04:00–04:20*: Tampilkan screenshot folder `build/app/outputs/flutter-apk/` yang memperlihatkan ukuran file APK: perbandingan angka **179 MB vs 9.19 MB**.

> **[DIALOG ANGGOTA 5 - QA, PERFORMANCE & RELEASE SPECIALIST]**:
> 
> *"Halo semuanya, saya [Nama], berperan sebagai QA, Performance & Release Specialist.*
> 
> *Saya bertugas menjaga kualitas aplikasi dan melakukan audit menyeluruh. Pada Flow 1 ini, saya telah menyelesaikan dokumen formal Laporan Pengujian Flow 1 berbasis static code review.*
> *Dari pengujian tersebut, saya berhasil menemukan 9 catatan penting, salah satunya bug kritis di mana alarm nonaktif sempat aktif kembali saat disimpan, yang kini telah kami evaluasi bersama tim.*
> 
> *Selain pengujian fungsional, pencapaian terbesar divisi kami adalah **Optimasi Ukuran File APK**.*
> *Awalnya, build APK rilis membengkak hingga **179 MegaByte**. Melalui pemisahan arsitektur Split ABI, upgrade Kotlin 1.9, dan pengaktifan R8 Code Shrinking, kami berhasil **memangkas ukuran APK hingga 95%, menjadi hanya 9.19 MegaByte**!*
> *Aplikasi kini sangat ringan, hemat memori, dan siap dibagikan ke pengguna."*

---

### ⏱️ SCENE 6: Evaluasi PM, Rencana Flow 2, & Penutup (04:20 – 04:50)
**Pemeran**: **Anggota 1 (PM) + Muncul Semua Anggota (Split Screen 5 Kotak / Berdiri Bersama)**  
**Visual On-Screen**:
* *04:20–04:35*: Anggota 1 merangkum kesimpulan progres.
* *04:35–04:50*: Seluruh anggota tim tersenyum, mengucapkan slogan bersama, dan melambaikan tangan ke kamera.

> **[DIALOG ANGGOTA 1 - PROJECT MANAGER]**:
> 
> *"Secara keseluruhan, milestone Flow 1 telah tercapai 100%. Mulai dari desain antarmuka, arsitektur kode Flutter, database lokal, hingga optimasi ukuran rilis.*
> 
> *Langkah tim kami berikutnya adalah memasuki **Flow 2: Pemicu Alarm Berdering & Misi Anti-Cheat**, untuk memastikan alarm mampu menembus layar terkunci dan mengaktifkan misi kebangunan.*
> 
> *Terima kasih atas perhatian Anda.*
> 
> **[SEMUA ANGGOTA BERSAMAAN]**:
> *'BangunYuk — Bangun Pasti, Harimu Berarti! Sampai jumpa di progres berikutnya!'*"* 👋✨
