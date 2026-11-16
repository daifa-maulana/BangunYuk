# Panduan Kerja: UI/UX Designer (Anggota 4)
## Proyek: BangunYuk — Smart Habit-Breaking Alarm

Sebagai **UI/UX Designer**, Anda bertugas merancang pengalaman visual dan alur pengguna yang efektif. Aplikasi alarm bangun tidur memiliki tantangan unik: antarmuka saat menyetel alarm harus **tenang dan menyenangkan**, sedangkan antarmuka saat alarm berdering harus **jelas, kontras tinggi, dan tidak membingungkan orang yang baru membuka mata**.

---

## 🎯 Target Utama Anda pada Fase Perancangan Awal
1. Dokumen User Journey & User Flow terperinci dari kondisi HP terkunci hingga bangun.
2. Design System di Figma (Material 3: Warna, Font, Spacing, Icon).
3. Wireframe & Mockup Hi-Fi untuk seluruh layar utama dan 6 tugas kebangunan.

---

## 🛠️ Tools yang Digunakan
- **Desain Utama**: Figma / FigJam.
- **Standar Desain**: Google Material Design 3 (Material You).
- **Aset Grafis**: Material Symbols / Feather Icons / Phosphor Icons.

---

## 🪜 Langkah-Langkah Kerja Tahap Demi Tahap

### Langkah 1: User Journey & Information Architecture (Hari 1–2)
- [ ] Buat diagram **User Flow** di FigJam:
  - *Flow A*: Menyetel alarm baru (pilih jam $\rightarrow$ pilih hari $\rightarrow$ tentukan tugas $\rightarrow$ simpan).
  - *Flow B*: Alarm berbunyi saat layar mati $\rightarrow$ layar menyala $\rightarrow$ urutan pengerjaan tugas $\rightarrow$ alarm mati $\rightarrow$ ucapan selamat pagi.
  - *Flow C*: Pengguna mencoba mematikan paksa (tombol volume/back) $\rightarrow$ pesan peringatan di layar.

### Langkah 2: Design System & Style Guide (Hari 2–3)
- [ ] **Palet Warna**:
  - *Primary*: Warna enerjik (misal: Deep Orange / Electric Amber / Indigo).
  - *Dark Theme*: Latar belakang hitam pekat / abu-abu gelap (menghemat baterai & ramah mata malam hari).
  - *Alert / Wake-up State*: Warna kontras tinggi agar langsung menarik fokus mata pengguna yang mengantuk.
- [ ] **Tipografi**:
  - Font angka jam digital yang tebal, tegas, dan mudah dibaca dari jarak jauh.
  - Ukuran teks instruksi tugas minimal 16–18sp agar tidak perlu memicingkan mata.
- [ ] **Ikonografi**:
  - Ikon untuk masing-masing tugas: 🧮 Matematika, ⌨️ Ketik, 📳 Goyang, 🤸 Lompat, 📷 Foto Barang, 🤳 Selfie.

### Langkah 3: Perancangan Layar Utama (Hari 3–5)
- [ ] **1. Home Screen (Daftar Alarm)**:
  - Tampilan jam alarm aktif dengan tombol toggle yang besar dan mudah ditekan.
  - Ringkasan hari aktif (Senin–Jumat) dan chip indikator tugas yang dipilih.
  - Card pengingat izin baterai/notifikasi jika belum aktif.
- [ ] **2. Alarm Edit Screen**:
  - Time picker intuitif (roda putar atau dial jam Material 3).
  - Seleksi hari dengan chip bulat (M S S R K J S).
  - Daftar pemilihan tugas kebangunan dengan urutan pengerjaan (drag & drop reorder atau nomor urut).
  - Slider batasan snooze (Maksimal 0, 1, 2, atau 3 kali).
- [ ] **3. Ringing Screen (Saat Alarm Menyala)**:
  - Jam digital besar berkedip dengan waktu berjalan (real-time).
  - Header status: *"Tugas 1 dari 2"* dengan progress bar di bagian atas.
  - Area pengerjaan tugas: Keypad besar untuk angka, textfield kontras untuk ketik, animasi progres goyang/lompat.
- [ ] **4. Stats Screen**:
  - Indikator api untuk *Streak Hari* (contoh: 🔥 7 Hari Bangun Tepat Waktu).
  - Grafik batang sederhana jam bangun selama 7 hari terakhir.
- [ ] **5. Settings & Battery Guide**:
  - Panduan bergambar langkah-langkah mematikan optimasi baterai di HP Xiaomi, Samsung, Oppo.

### Langkah 4: Handoff ke Frontend Developer (Hari 5–6)
- [ ] Bersihkan file Figma: kelompokkan frame per screen dan beri penamaan layer yang teratur.
- [ ] Sediakan spesifikasi ukuran padding, margin, border-radius, dan kode warna hex yang siap diinspeksi oleh Anggota 2 (Frontend).
- [ ] Adakan sesi walkthrough desain dengan Anggota 2 untuk menjelaskan animasi dan transisi yang diharapkan.

---

## 📋 Checklist Kriteria Sukses (Definition of Done UI/UX)
- [ ] Semua alur layar di Figma memiliki status interaktif (*clickable prototype*).
- [ ] Komponen telah disesuaikan dengan pedoman ergonomi jempol (*thumb-friendly zone*).
- [ ] Frontend Developer memahami seluruh aset dan spesifikasi tanpa kebingungan.

