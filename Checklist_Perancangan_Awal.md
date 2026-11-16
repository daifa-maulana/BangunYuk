# Master Checklist: To-Do List Perancangan Awal BangunYuk

Dokumen ini berisi panduan kerja (*actionable checklist*) perancangan awal untuk tim pengembang yang terdiri dari **5 anggota**. Disusun berdasarkan pembagian peran dan alur kerja kolaboratif agar setiap anggota memiliki tanggung jawab yang terukur dan tidak saling tumpang tindih.

---

## 👥 Struktur & Pembagian Peran Tim (5 Orang)

| No | Anggota / Jabatan | Tanggung Jawab Utama | Fokus Output Perancangan Awal |
| :---: | :--- | :--- | :--- |
| **1** | **Project Manager (PM)** | Manajemen, dokumentasi, koordinasi, timeline | PRD, Master Checklist, RACI Matrix, Sprint Schedule, koordinasi antar-anggota |
| **2** | **Frontend Developer** | Tampilan & navigasi Flutter | Desain struktur screen, routing, state widget, integrasi UI tema Material 3 |
| **3** | **System & Logic Developer** | Alarm native, database lokal, logika fitur & sensor | Integrasi package `alarm`, Foreground Service, SharedPreferences, algoritma task |
| **4** | **UI/UX Designer** | User Flow, Wireframe, Figma, Design System | User Journey, Wireframe Lo-Fi/Hi-Fi, UI Kit komponen, aset icon & warna |
| **5** | **QA & User Testing** | Pengujian, bug report, skenario edge case, validasi | Test Plan, Matriks Uji Coba, Checklist UAT, Log Pelaporan Bug |

---

## 📊 Matriks Tanggung Jawab (RACI Matrix)

> **Keterangan**: 
> - **R** (*Responsible*): Yang mengeksekusi tugas.
> - **A** (*Accountable*): Penanggung jawab utama & pengambil keputusan akhir.
> - **C** (*Consulted*): Dimintai masukan / diskusi dua arah.
> - **I** (*Informed*): Diberitahu hasil akhirnya.

| Area Pekerjaan | PM (1) | Frontend (2) | System & Logic (3) | UI/UX (4) | QA (5) |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **PRD & Scope MVP** | **A/R** | C | C | C | I |
| **User Flow & Figma Design** | C | C | I | **A/R** | C |
| **Arsitektur Alarm & Background Service** | I | C | **A/R** | I | C |
| **Struktur Kode & Routing UI Flutter** | I | **A/R** | C | C | I |
| **Logika Sensor & Task Kebangunan** | I | C | **A/R** | I | C |
| **Setup Repository & Tooling** | A | R | R | I | I |
| **Penyusunan Test Plan & Skenario Uji** | C | I | I | I | **A/R** |

---

## 🚀 Checklist Kerja Per Fase (Berdasarkan PIC)

### 🎯 Fase 1: Discovery, Scope & Product Definition
*Tujuan: Memastikan spesifikasi produk jelas dan disepakati oleh seluruh tim.*

- [ ] `[PM]` Finalisasi dokumen PRD v1.0 dan bagikan ke seluruh anggota tim.
- [ ] `[PM]` Tentukan *deadline* milestone perancangan awal dan jadwal sinkronisasi rutin (daily standup / weekly sync).
- [ ] `[PM]` Tentukan batasan tegas fitur MVP (6 tugas dasar, 100% lokal, tanpa backend luar).
- [ ] `[UI/UX]` Petakan User Persona utama (*Heavy Sleeper* & Mahasiswa/Komuter).
- [ ] `[QA]` Bedah dokumen PRD untuk memahami ekspektasi fungsional dan kriteria penerimaan (*Acceptance Criteria*).

---

### 🎨 Fase 2: UI/UX Design & Information Architecture
*Tujuan: Menyediakan acuan visual dan alur layar yang jelas sebelum implementasi kode.*

- [ ] `[UI/UX]` **User Flow Lengkap**:
  - [ ] Alur pembuatan/edit alarm dan penentuan tugas berurutan.
  - [ ] Alur pemicu alarm dari kondisi layar terkunci hingga seluruh tugas selesai.
  - [ ] Alur penolakan tombol keluar / volume down (*anti-cheat flow*).
- [ ] `[UI/UX]` **Figma Design System (Material 3)**:
  - [ ] Palet warna (Light & Dark theme) dengan kontras tinggi untuk suasana bangun tidur.
  - [ ] Tipografi jam besar (digital clock font) dan kartu status.
- [ ] `[UI/UX]` **Wireframe & Mockup Layar Utama**:
  - [ ] Layar 1: *Home Screen* (Daftar alarm, toggle on/off, banner status izin).
  - [ ] Layar 2: *Alarm Edit Screen* (Time picker, chip pengulangan hari, seleksi tugas).
  - [ ] Layar 3: *Ringing Screen* (Layar alarm meraung + antrean widget tugas).
  - [ ] Layar 4: *Stats & History Screen* (Streak api, grafik jam bangun mingguan).
  - [ ] Layar 5: *Settings & Battery Guide* (Panduan izin OEM Xiaomi/Oppo/Samsung).
- [ ] `[Frontend]` *Design Review*: Berikan umpan balik kepada UI/UX terkait kelayakan implementasi komponen di Flutter.

---

### 🔬 Fase 3: Technical Feasibility & System Architecture (Spike POC)
*Tujuan: Memastikan package alarm native dan background execution berfungsi tanpa kendala OS.*

- [ ] `[System & Logic]` **POC Background Alarm Engine**:
  - [ ] Pasang dan uji coba package `alarm` pada Android SDK 34+.
  - [ ] Verifikasi alarm tetap bersuara kencang ketika aplikasi di-swipe dari *Recent Apps*.
  - [ ] Uji alarm saat layar HP terkunci (*Full-Screen Intent display*).
- [ ] `[System & Logic]` **Mekanisme Volume Override**:
  - [ ] Buat logika listener tombol volume; kembalikan nilai audio ke 100% jika pengguna menekan volume down.
- [ ] `[System & Logic]` **Algoritma Sensor & Task Logic**:
  - [ ] Algoritma matematika adaptif (3 soal benar berurutan, penalti jika salah).
  - [ ] Stream akselerometer untuk deteksi goyangan ponsel (20x threshold).
  - [ ] Deteksi lompatan (kombinasi *free-fall* dan *impact acceleration* 15x).
  - [ ] Inisialisasi cepat kamera untuk foto barang & selfie.
- [ ] `[System & Logic]` **Desain Model Data & Storage**:
  - [ ] Skema model `Alarm`, `TaskItem`, dan `HistoryRecord` (JSON serializable untuk SharedPreferences).

---

### 💻 Fase 4: Frontend Scaffolding & State Wiring
*Tujuan: Membangun kerangka aplikasi Flutter dan menghubungkan antarmuka dengan logika.*

- [ ] `[PM]` Inisialisasi Git Repository (GitHub/GitLab), atur branch protection (`main`, `develop`), dan format commit message.
- [ ] `[Frontend]` Setup struktur direktori modular Flutter:
  ```
  lib/
  ├── models/
  ├── screens/
  │   └── tasks/
  ├── services/
  ├── theme/
  └── widgets/
  ```
- [ ] `[Frontend]` Implementasi Theme Material 3 (Dark/Light mode) sesuai spesifikasi Figma.
- [ ] `[Frontend]` Bangun widget navigasi dasar dan kerangka screen:
  - [ ] `HomeScreen` dengan list view alarm interaktif.
  - [ ] `AlarmEditScreen` dengan form interaktif.
  - [ ] `RingingScreen` dengan penampung dinamis (*Task Container*).
  - [ ] `StatsScreen` dengan komponen ringkasan streak.
- [ ] `[Frontend] + [System & Logic]` Integrasi Controller: Sambungkan tombol aksi UI ke fungsi scheduler alarm dan penyimpanan lokal.

---

### 🧪 Fase 5: QA Testing & Edge Case Validation
*Tujuan: Memastikan alarm tidak pernah gagal berbunyi dan aplikasi bebas dari crash.*

- [ ] `[QA]` **Penyusunan Test Matrix & Skenario Uji**:
  - [ ] Uji skenario aplikasi dibuka (*Foreground*).
  - [ ] Uji skenario aplikasi di latar belakang (*Background*).
  - [ ] Uji skenario HP terkunci (*Lockscreen display*).
  - [ ] Uji skenario HP di-restart (*Boot Completed Receiver*).
  - [ ] Uji mode Jangan Ganggu (*Do Not Disturb bypass*).
- [ ] `[QA]` **Pengujian Fungsional Seluruh Tugas**:
  - [ ] Pastikan tugas matematika tidak bisa dilewati tanpa 3 jawaban benar.
  - [ ] Pastikan sensor akselerometer merespons goyangan dan lompatan dengan akurat.
  - [ ] Pastikan kamera tidak menyebabkan memory leak saat mengambil foto.
- [ ] `[QA]` **Uji Daya Tahan & Anti-Bypass**:
  - [ ] Uji perilaku tombol fisik volume dan tombol navigasi Back/Home.
  - [ ] Uji ketahanan alarm pada HP vendor agresif (Xiaomi HyperOS, Oppo ColorOS, Samsung OneUI).
- [ ] `[QA]` **Bug Tracking**:
  - [ ] Catat setiap temuan bug ke dalam lembar pelaporan (*steps to reproduce*, *expected vs actual*, *severity*).
- [ ] `[PM]` Validasi akhir: Selenggarakan sesi review bersama sebelum versi rilis disetujui.

---

## 📌 Checklist Khusus Per Anggota (Personal To-Do Summary)

### 👤 Anggota 1 (Project Manager)
- [ ] Memastikan PRD dan spesifikasi fitur dipahami oleh ke-4 anggota lain.
- [ ] Membuat papan tugas tim (Trello / Notion / Jira / GitHub Project).
- [ ] Memantau kemajuan harian dan mengatasi hambatan (*blockers*) antar divisi.
- [ ] Mengontrol jadwal rilis agar sesuai timeline perancangan awal.

### 👤 Anggota 2 (Frontend Developer)
- [ ] Mengonversi rancangan Figma dari Anggota 4 ke dalam kode Flutter yang rapi.
- [ ] Menyediakan komponen widget modular untuk antrean tugas bangun tidur.
- [ ] Memastikan transisi antar-layar dan animasi berjalan mulus (60 FPS).
- [ ] Bekerja sama dengan Anggota 3 untuk menghubungkan data alarm ke tampilan.

### 👤 Anggota 3 (System & Logic Developer)
- [ ] Menjamin reliabilitas pemicu alarm di latar belakang (Foreground Service).
- [ ] Mengamankan logika volume lock agar suara alarm tidak bisa dikecilkan.
- [ ] Mengimplementasikan algoritma perhitungan sensor (goyang, lompat, matematika).
- [ ] Mengelola penyimpanan data lokal (SharedPreferences) yang cepat dan aman.

### 👤 Anggota 4 (UI/UX Designer)
- [ ] Menyelesaikan visual design lengkap di Figma beserta prototipe klik interaktif.
- [ ] Menyediakan aset grafis (ikon tugas, ilustrasi, audio nada alarm bila diperlukan).
- [ ] Melakukan pengecekan konsistensi visual hasil kodingan Anggota 2 (*UI review*).

### 👤 Anggota 5 (QA & User Testing)
- [ ] Membuat lembar dokumen Test Case formal.
- [ ] Melakukan pengujian langsung di berbagai perangkat fisik Android (bukan hanya emulator).
- [ ] Memvalidasi skenario sulit (baterai hemat, restart HP, layar terkunci).
- [ ] Memberikan status "Pass / Fail" terhadap setiap rilis build APK.
