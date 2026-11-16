# Naskah Video Progres Perancangan Proyek: BangunYuk
## Format: Presentasi Kolaboratif Kelompok (5 Orang)

| Metadata Video | Keterangan |
| :--- | :--- |
| **Judul Proyek** | **BangunYuk — Smart Habit-Breaking Alarm** |
| **Target Durasi** | 4 – 5 Menit (Standar Video Progres Akademik / Presentasi Sprint) |
| **Format Rekaman** | Kombinasi *Talking Head* (wajah anggota bergantian) + *Screen Recording* (B-Roll Figma, Kode, Emulator, & HP Fisik) |
| **Pemeran** | 5 Anggota (PM, Frontend, System/Logic, UI/UX, QA) |

---

## 🎬 Panduan Visual & Pembagian Waktu (Cue Sheet)

```
[00:00 - 00:45] Scene 1: Pembuka & Latar Belakang Masalah (Anggota 1 - Project Manager)
[00:45 - 01:35] Scene 2: Alur Pengguna & Desain Antarmuka di Figma (Anggota 4 - UI/UX Designer)
[01:35 - 02:30] Scene 3: Arsitektur Native, Alarm & Sensor Logic (Anggota 3 - System & Logic Dev)
[02:30 - 03:20] Scene 4: Slicing UI & Navigasi di Flutter (Anggota 2 - Frontend Developer)
[03:20 - 04:10] Scene 5: Pengujian HP Fisik & Skenario Edge Case (Anggota 5 - QA Tester)
[04:10 - 04:45] Scene 6: Kesimpulan, Next Step & Penutup (Anggota 1 - PM + Seluruh Anggota)
```

---

## 📜 Naskah Dialog & Panduan Visual (Lengkap per Scene)

### ⏱️ SCENE 1: Pembuka & Latar Belakang Masalah (00:00 – 00:45)
**Pemeran**: **Anggota 1 (Project Manager)**  
**Visual**:
- Detik 00:00–00:15: Wajah Anggota 1 berbicara ke kamera dengan percaya diri dan ramah. Di sudut bawah layar terdapat lower-third teks: `[Nama Anggota 1] — Project Manager`.
- Detik 00:15–00:45: Cuplikan orang mematikan alarm sambil mengantuk (bisa diperagakan sebentar) lalu muncul logo/mockup aplikasi **BangunYuk**.

> **[DIALOG ANGGOTA 1 - PROJECT MANAGER]**:
> 
> *"Halo semuanya! Selamat datang di video progres perancangan aplikasi kelompok kami. Saya [Nama], berperan sebagai Project Manager.*
> 
> *Pernahkah kalian menyetel alarm jam 5 pagi, tapi begitu bunyi, tangan kalian refleks mematikan alarm secara setengah sadar lalu lanjut tidur lagi? Fenomena ini disebut sleep inertia, dan alarm bawaan ponsel saat ini terlalu mudah dimatikan hanya dengan satu sentuhan.*
> 
> *Untuk menjawab masalah tersebut, kami merancang **BangunYuk**, aplikasi alarm Flutter berintegritas tinggi dengan mekanisme anti-cheat. Alarm BangunYuk pantang berhenti sebelum pengguna menyelesaikan tugas kebangunan fisik dan kognitif. Berikut adalah laporan progres perancangan dari masing-masing divisi kami."*

---

### ⏱️ SCENE 2: Riset UX & Desain Antarmuka (00:45 – 01:35)
**Pemeran**: **Anggota 4 (UI/UX Designer)**  
**Visual**:
- Detik 00:45–01:00: Wajah Anggota 4 menyapa. Lower-third: `[Nama Anggota 4] — UI/UX Designer`.
- Detik 01:00–01:35: Rekaman layar (*Screen Recording*) file Figma BangunYuk. Kursor menyorot alur User Flow di FigJam, palet warna Material 3, dan frame desain: Home, Edit Alarm, serta Layar Alarm Meraung (*Ringing Screen*).

> **[DIALOG ANGGOTA 4 - UI/UX DESIGNER]**:
> 
> *"Halo, saya [Nama], bertindak sebagai UI/UX Designer.*
> 
> *Dari sisi perancangan pengalaman pengguna, tantangan terbesar kami adalah: bagaimana membuat antarmuka yang tetap jelas dan tidak membingungkan bagi pengguna yang baru saja membuka mata.*
> 
> *Kami menyusun User Flow di FigJam mulai dari layar terkunci, antrean tugas bertingkat, hingga alarm berhasil dimatikan. Di Figma, kami menerapkan Google Material Design 3 dengan kontras warna tinggi dan tipografi angka jam digital yang tegas.*
> 
> *Kami juga merancang komponen untuk 6 jenis misi kebangunan, mulai dari keypad besar untuk tugas matematika, progress bar goyangan ponsel, hingga tampilan viewfinder kamera. Seluruh wireframe dan mockup Hi-Fi ini sudah selesai dan siap diimplementasikan oleh tim developer."*

---

### ⏱️ SCENE 3: Arsitektur Sistem, Alarm Native & Sensor (01:35 – 02:30)
**Pemeran**: **Anggota 3 (System & Logic Developer)**  
**Visual**:
- Detik 01:35–01:50: Wajah Anggota 3. Lower-third: `[Nama Anggota 3] — System & Logic Developer`.
- Detik 01:50–02:30: *Screen Recording* VS Code / Android Studio. Menampilkan file `AndroidManifest.xml` (daftar izin foreground service & exact alarm) dan potongan kode pembacaan sensor akselerometer (`sensors_plus`) serta logika pengunci volume.

> **[DIALOG ANGGOTA 3 - SYSTEM & LOGIC DEVELOPER]**:
> 
> *"Halo semua, saya [Nama], sebagai System & Logic Developer.*
> 
> *Kunci utama dari aplikasi alarm adalah reliabilitas: alarm TIDAK BOLEH gagal berbunyi dalam kondisi apa pun. Pada tahap perancangan awal ini, saya telah menyelesaikan riset teknis atau Spike POC integrasi native Android.*
> 
> *Pertama, kami memanfaatkan package alarm yang berjalan di atas Foreground Service Android bertipe mediaPlayback. Artinya, alarm tetap akan berbunyi tepat waktu meskipun aplikasi di-swipe dari recent apps atau ponsel baru saja di-restart.*
> 
> *Kedua, kami menerapkan fitur Anti-Cheat: sistem pengunci volume yang secara otomatis mengembalikan volume suara ke 100% jika pengguna mencoba mengecilkannya.*
> 
> *Ketiga, dari sisi sensor, logika deteksi akselerometer untuk menghitung 20 kali goyangan dan deteksi lompatan tubuh menggunakan kalkulasi vektor percepatan gravitasi sudah berhasil kami uji dan siap diintegrasikan."*

---

### ⏱️ SCENE 4: Slicing UI & Navigasi Flutter (02:30 – 03:20)
**Pemeran**: **Anggota 2 (Frontend Developer)**  
**Visual**:
- Detik 02:30–02:45: Wajah Anggota 2. Lower-third: `[Nama Anggota 2] — Frontend Developer`.
- Detik 02:45–03:20: *Screen Recording* Emulator Android atau rekaman HP yang menjalankan aplikasi Flutter. Menampilkan transisi mulus dari Home Screen $\rightarrow$ membuka form Edit Alarm $\rightarrow$ memilih chip hari $\rightarrow$ memilih multi-task $\rightarrow$ preview Layar Alarm Berdering.

> **[DIALOG ANGGOTA 2 - FRONTEND DEVELOPER]**:
> 
> *"Halo, saya [Nama], selaku Frontend Developer.*
> 
> *Fokus saya adalah menerjemahkan desain indah dari Figma menjadi kode Flutter yang responsif dan modular. Struktur project sudah kami bagi ke dalam folder tema, model, screen, dan sub-folder khusus komponen tugas.*
> 
> *Seperti yang terlihat di layar, kami telah berhasil membangun Home Screen yang menampilkan daftar alarm aktif lengkap dengan switch on/off, serta form pembuatan alarm dengan Time Picker interaktif dan selektor multi-task.*
> 
> *Pada Ringing Screen, kami menggunakan PopScope untuk mengunci tombol navigasi Back, sehingga pengguna tidak bisa keluar dari layar secara curang sebelum antrean tugas diselesaikan. Saat ini, seluruh komponen tampilan sudah terhubung dengan rapi ke alur navigasi global."*

---

### ⏱️ SCENE 5: Pengujian HP Fisik & Skenario Kritis (03:20 – 04:10)
**Pemeran**: **Anggota 5 (QA & User Testing)**  
**Visual**:
- Detik 03:20–03:35: Wajah Anggota 5. Lower-third: `[Nama Anggota 5] — QA & User Testing`.
- Detik 03:35–04:10: Kamera menyorot HP fisik di atas meja. Menampilkan alarm berbunyi saat layar HP mati/terkunci, mencoba menekan tombol volume turun tapi volume langsung kembali penuh, dan peragaan menyelesaikan tugas matematika 3 soal. Tampilkan sekilas tabel *Test Matrix*.

> **[DIALOG ANGGOTA 5 - QA & USER TESTING]**:
> 
> *"Halo, saya [Nama], bertugas sebagai Quality Assurance dan User Testing.*
> 
> *Bagi aplikasi alarm, pengujian tidak cukup hanya di emulator. Oleh karena itu, saya telah menyusun Test Matrix berisi 16 skenario uji kritis dan mengujinya langsung di beberapa perangkat fisik Android.*
> 
> *Hasil pengujian awal menunjukkan hasil yang sangat memuaskan:*
> *Pertama, fitur Full Screen Intent terbukti sukses menyalakan layar HP yang sedang terkunci.*
> *Kedua, uji coba tombol fisik membuktikan bahwa tombol volume tidak bisa mematikan suara alarm.*
> *Dan ketiga, tugas matematika terbukti memvalidasi jawaban secara ketat; jika salah, hitungan jawaban benar akan direset kembali.*
> 
> *Kami juga sudah menyusun panduan optimasi baterai khusus untuk mengatasi sistem background killer pada merek ponsel seperti Xiaomi dan Samsung."*

---

### ⏱️ SCENE 6: Kesimpulan, Next Step & Penutup (04:10 – 04:45)
**Pemeran**: **Anggota 1 (PM) + Muncul Semua Anggota (Split Screen / Bersama)**  
**Visual**:
- Detik 04:10–04:30: Anggota 1 berbicara merangkum pencapaian. Di sampingnya muncul grafis infografis: *"Progres Perancangan Awal: 100% Selesai | Tahap Berikutnya: Finalisasi Integrasi & UAT"*.
- Detik 04:30–04:45: Tampilan video membagi layar menjadi 5 kotak (Grid 5 orang) atau semua anggota berdiri bersama sambil melambaikan tangan ke kamera.

> **[DIALOG ANGGOTA 1 - PROJECT MANAGER]**:
> 
> *"Secara keseluruhan, tahap perancangan awal aplikasi BangunYuk telah mencapai 100% dari target yang kami tetapkan di dokumen PRD.*
> 
> *Langkah kami selanjutnya adalah mematangkan integrasi sensor kamera, memperluas uji coba pengguna nyata, dan mempersiapkan build akhir aplikasi siap rilis.*
> 
> *Terima kasih banyak atas perhatian Anda.*
> 
> **[SEMUA ANGGOTA BERSAMAAN]**:
> *'BangunYuk — Bangun Pasti, Harimu Berarti! Sampai jumpa di rilis final!'*"*  
> *(Semua tersenyum dan melambaikan tangan).*

---

## 💡 Tips & Trik Syuting Agar Nilai Video Maksimal
1. **Perekaman Suara**: Gunakan mic earphone/clip-on agar suara jernih dan bebas gaung ruangan.
2. **Kamera & Pencahayaan**: Pastikan wajah menghadap sumber cahaya (jendela atau lampu meja). Posisikan kamera sejajar mata (*eye-level*).
3. **Screen Recording**: Rekam layar laptop/HP dengan resolusi 1080p pada 60fps agar teks kode dan animasi Figma terbaca tajam.
4. **Transisi Editing**: Berikan potongan B-Roll (rekaman layar) saat masing-masing anggota menjelaskan teknisnya, sehingga video terasa dinamis dan profesional.

