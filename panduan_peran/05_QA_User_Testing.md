# Panduan Kerja: QA, Performance & Release Specialist (Anggota 5)
## Proyek: BangunYuk — Smart Habit-Breaking Alarm

Sebagai **QA, Performance & Release Specialist**, Anda adalah "penjaga gerbang kualitas dan efisiensi" dari BangunYuk. Peran Anda bukan hanya menguji tombol dan mencari bug, tetapi juga **mengendalikan ukuran APK agar tetap ramping (< 10 MB)**, memvalidasi performa di HP fisik, dan mendokumentasikan laporan pengujian di setiap flow.

---

## 🎯 Target Utama Anda
1. Mengawal **optimasi ukuran APK** agar tidak membengkak (sukses terpangkas dari 179 MB ke **9.19 MB**).
2. Mengisi dan memperbarui dokumen **[DOKUMENTASI_QA_DAN_HASIL_TESTING.md](../DOKUMENTASI_QA_DAN_HASIL_TESTING.md)** di setiap flow.
3. Melakukan pengujian langsung di berbagai perangkat fisik Android (Xiaomi, Samsung, Oppo).
4. Memvalidasi skenario kritis: alarm saat HP terkunci, restart HP, dan mekanisme *Volume Lock*.

---

## 🛠️ Tools yang Digunakan
- **Alat Uji & Dokumentasi**: [DOKUMENTASI_QA_DAN_HASIL_TESTING.md](../DOKUMENTASI_QA_DAN_HASIL_TESTING.md).
- **Build & Optimization Command**:
  ```powershell
  # Perintah build andalan Anda untuk menghasilkan APK ramping < 10 MB:
  flutter build apk --release --split-per-abi
  ```
- **Device Lab**: Perangkat fisik Android asli (utamakan HP dengan sistem baterai agresif seperti Xiaomi MIUI/HyperOS).
- **Log Viewer**: `adb logcat` / terminal Flutter.

---

## 🪜 Langkah Kerja Anda di Setiap Flow

### 🔁 Flow 1: Tampilan & Penyetelan Alarm
- [ ] **Uji Empty State**: Pastikan saat database kosong, layar menampilkan *"02 - Beranda kosong"* persis seperti desain Figma.
- [ ] **Uji Tambah Alarm**: Klik `+ Buat alarm pertama`, pastikan langsung berpindah ke Beranda Berisi + Banner Kuning.
- [ ] **Uji Persistence Data**: Hapus aplikasi dari *Recent Apps*, buka lagi, pastikan data alarm tidak hilang.
- [ ] Catat hasil uji di Bagian 2 (TC-1.01 s/d TC-1.05) pada file `DOKUMENTASI_QA_DAN_HASIL_TESTING.md`.

### 🔁 Flow 2: Pemicu Alarm Berdering & Misi
- [ ] **Uji Layar Terkunci**: Kunci layar HP, tunggu jam alarm, pastikan layar menyala otomatis (*Full Screen Intent*).
- [ ] **Uji Anti-Cheat Volume**: Tekan tombol volume bawah berkali-kali saat alarm bunyi $\rightarrow$ pastikan volume tetap 100%.
- [ ] **Uji Misi**:
  * Matematika: coba salahkan 1 soal $\rightarrow$ hitungan wajib reset.
  * Goyang & Lompat: uji apakah sensor membedakan getaran palsu.
- [ ] Catat hasil uji di Bagian 2 (TC-2.01 s/d TC-2.07).

### 🔁 Flow 3: Statistik, Gamifikasi & Profil
- [ ] **Uji Navigasi**: Coba klik tab Beranda, Statistik, dan Profil di Bottom Bar.
- [ ] **Uji Streak**: Selesaikan misi alarm pagi, cek apakah streak bertambah $+1$ (ikon api 🔥).
- [ ] Catat hasil uji di Bagian 2 (TC-3.01 s/d TC-3.03).

### 📦 Tugas Khusus: Optimasi & Packaging APK
- [ ] Jalankan perintah:
  ```powershell
  flutter build apk --release --split-per-abi
  ```
- [ ] Periksa ukuran file di `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`.
- [ ] Pastikan ukurannya tetap **ramping di kisaran 9 MB** (jika membengkak, cek apakah ada asset gambar besar atau package yang belum di-minify).
- [ ] Berikan file `app-arm64-v8a-release.apk` ke teman-teman kelompok untuk diinstall.

---

## 📋 Checklist Kriteria Sukses (Definition of Done Anggota 5)
- [ ] File [DOKUMENTASI_QA_DAN_HASIL_TESTING.md](../DOKUMENTASI_QA_DAN_HASIL_TESTING.md) terisi lengkap dari Flow 1 sampai Flow 3.
- [ ] Ukuran APK final terverifikasi $\le 10$ MB.
- [ ] Tidak ada bug berkategori *Critical* / *Blocker* yang belum terselesaikan.
- [ ] QA memberikan tanda tangan pengesahan (*Sign-off*) bahwa aplikasi siap didemokan ke dosen / dipresentasikan.
