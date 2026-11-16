# Panduan Kerja: Project Manager (Anggota 1)
## Proyek: BangunYuk — Smart Habit-Breaking Alarm

Sebagai **Project Manager**, Anda adalah dirigen utama dari proyek ini. Fokus utama Anda adalah memastikan tim bergerak dengan visi yang sama, timeline tercapai, tidak ada anggota yang terhambat (*blocked*), dan ruang lingkup proyek (*scope*) terkendali.

---

## 🎯 Target Utama Anda pada Fase Perancangan Awal
1. Dokumen PRD dan Master Checklist terdistribusi dan dipahami oleh seluruh anggota.
2. Timeline rilis dan sistem koordinasi harian terbentuk.
3. Manajemen risiko teknis dan pembagian tugas berjalan tanpa tumpang tindih.

---

## 🛠️ Tools yang Digunakan
- **Dokumentasi**: Markdown (`PRD_BangunYuk.md`, `Checklist_Perancangan_Awal.md`).
- **Project Tracking**: Trello / Notion Board / GitHub Projects.
- **Komunikasi**: WhatsApp Group / Discord / Telegram.
- **Version Control**: GitHub / GitLab (sebagai administrator repo).

---

## 🪜 Langkah-Langkah Kerja Tahap Demi Tahap

### Langkah 1: Setup Workspace & Papan Tugas (Hari 1)
- [ ] Buat Repository Git dan atur cabang `main` dan `develop`.
- [ ] Buat papan Kanban di Trello atau Notion dengan 4 kolom utama:
  - `Backlog` (Semua daftar tugas dari Checklist).
  - `In Progress` (Sedang dikerjakan oleh anggota).
  - `Review / QA` (Selesai koding, sedang diuji QA).
  - `Done` (Lolos verifikasi).
- [ ] Masukkan item pekerjaan untuk Anggota 2, 3, 4, dan 5 sesuai dengan peran masing-masing.

### Langkah 2: Kick-Off Meeting & Penyelarasan Visi (Hari 1–2)
- [ ] Kumpulkan ke-5 anggota dalam sesi singkat (30–45 menit).
- [ ] Jelaskan masalah yang diselesaikan aplikasi BangunYuk dan 6 tugas kebangunannya.
- [ ] Tegaskan aturan **Scope MVP**: *Jangan tambahkan fitur backend online atau ML berat sebelum 6 tugas dasar dan alarm native 100% stabil*.
- [ ] Sepakati jadwal sinkronisasi berkala (misal: update status 10 menit setiap malam).

### Langkah 3: Mengawal Handoff Antar-Divisi (Hari 3–5)
- [ ] Pantau progres Anggota 4 (UI/UX) agar desain Figma selesai tepat waktu untuk di-slicing oleh Anggota 2 (Frontend).
- [ ] Pantau Anggota 3 (System & Logic) agar riset spike package alarm native segera divalidasi.
- [ ] Jika terjadi selisih teknis antara UI dan batas kemampuan Flutter/Android, ambil keputusan penyesuaian desain bersama.

### Langkah 4: Evaluasi Uji Coba & Kesiapan Demo/Rilis (Hari 6–7)
- [ ] Terima laporan bug dari Anggota 5 (QA) dan prioritaskan bug mana yang wajib diperbaiki segera (*Critical / Blocker*).
- [ ] Pastikan file build APK rilis sudah dibuat dan tersimpan aman di folder build.
- [ ] Susun presentasi / berkas laporan akhir perancangan proyek.

---

## 📋 Checklist Kriteria Sukses (Definition of Done PM)
- [ ] Seluruh anggota tim memiliki akses ke repo Git dan papan tugas.
- [ ] PRD dan checklist disetujui tanpa ada ketidakjelasan spesifikasi.
- [ ] Tidak ada tugas yang terbengkalai tanpa pemilik yang jelas.
- [ ] Target rilis versi MVP tercapai sesuai jadwal yang disepakati.

