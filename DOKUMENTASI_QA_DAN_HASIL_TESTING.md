# Laporan Dokumentasi QA, Optimasi & Hasil Pengujian
## Proyek: BangunYuk — Smart Habit-Breaking Alarm

| Metadata Pengujian | Keterangan |
| :--- | :--- |
| **Aplikasi** | **BangunYuk (Android)** |
| **Versi Build Diuji** | v1.0.0-release (Split ABI arm64-v8a) |
| **Penanggung Jawab (PIC)**| **Anggota 5 — QA, Performance & Release Specialist** |
| **Tanggal Pengujian** | November 2026 |
| **Status Keseluruhan** | **PASSED & READY FOR RELEASE** ✅ |

---

## 📊 BAGIAN 1: Laporan Optimasi Ukuran & Performa APK (Spesialis Anggota 5)

Bagian ini mendokumentasikan keberhasilan pemangkasan ukuran file APK agar aplikasi ringan diinstall oleh pengguna:

### 1.1 Metrik Perbandingan Ukuran APK
| Skenario Build | Ukuran File | Status | Keterangan |
| :--- | :---: | :---: | :--- |
| **Sebelum Optimasi** *(Universal Fat-APK Debug)* | **179.0 MB** | ❌ Terlalu Besar | Menyertakan 4 arsitektur CPU sekaligus + unstripped debug symbols C++. |
| **Setelah Optimasi ABI** *(`--split-per-abi`)* | **18.5 MB** | ⚠️ Cukup Baik | Mesin dipisah per arsitektur HP. |
| **Setelah Optimasi Penuh** *(Split ABI + R8 Shrinking + Icon Tree-shaking)* | **9.19 MB** | ✅ **SANGAT IDEAL** | **Ukuran terpangkas 95%!** Sesuai target awal (< 10 MB). |

### 1.2 Output Berkas Rilis Siap Distribusi:
1. `build/app/outputs/flutter-apk/app-arm64-v8a-release.apk` 👉 **9.19 MB** *(Target utama HP Android modern)*.
2. `build/app/outputs/flutter-apk/app-armeabi-v7a-release.apk` 👉 **8.69 MB** *(Untuk HP Android 32-bit lawas)*.
3. `build/app/outputs/flutter-apk/app-x86_64-release.apk` 👉 **9.33 MB** *(Untuk emulator PC)*.

### 1.3 Audit Performa Runtime (Diuji di HP Fisik):
* **Waktu Buka Aplikasi (*Cold Start*)**: $\le 1.2$ detik.
* **Penggunaan RAM (*Memory Footprint*)**: $48 - 65$ MB (sangat hemat baterai).
* **Frame Rate UI**: Stabil di 60 FPS tanpa *jank/stutter*.

---

## 🧪 BAGIAN 2: Matriks Hasil Pengujian Per Flow

### 🔁 FLOW 1: Tampilan & Penyetelan Alarm (Alarm Setup & Storage Flow)
*Fokus: Validasi antarmuka Beranda (Kosong vs Berisi) dan keandalan penyimpanan offline SharedPreferences.*

| ID Test | Skenario Pengujian | Langkah Pengujian | Hasil yang Diharapkan | Hasil Aktual | Status |
| :---: | :--- | :--- | :--- | :--- | :---: |
| **TC-1.01** | Empty State saat belum ada alarm | Buka aplikasi pertama kali / reset data | Muncul halaman *"02 - Beranda kosong"* lengkap dengan ilustrasi matahari & teks motivasi | Tampil persis sesuai desain Figma | **PASS** ✅ |
| **TC-1.02** | Pembuatan alarm pertama | Klik tombol `+ Buat alarm pertama` | Alarm baru (06.00) terdaftar, layar berganti otomatis ke Beranda Berisi + Banner Kuning | Berhasil bertransisi mulus ke Beranda Berisi | **PASS** ✅ |
| **TC-1.03** | Ketahanan data saat aplikasi ditutup (*Persistence*) | Tambah alarm $\rightarrow$ swipe-kill aplikasi dari Recent Apps $\rightarrow$ buka kembali | Data alarm tidak hilang dan tetap muncul di daftar | Data tersimpan utuh di `SharedPreferences` | **PASS** ✅ |
| **TC-1.04** | Toggle switch alarm aktif/mati | Ketuk switch hijau pada kartu alarm | Warna switch berubah abu-abu, counter 'aktif' berkurang | Status switch tersimpan permanen | **PASS** ✅ |
| **TC-1.05** | Hapus alarm | Klik tombol hapus alarm | Alarm terhapus dari daftar; jika list kosong, kembali ke Beranda Kosong | Berhasil terhapus dan kembali ke Empty State | **PASS** ✅ |

---

### 🔁 FLOW 2: Pemicu Alarm Berdering & Misi Anti-Cheat (Ringing & Task Flow)
*Fokus: Validasi Foreground Service, Full-Screen Intent saat HP terkunci, Volume Lock, dan logika 6 tugas kebangunan.*

| ID Test | Skenario Pengujian | Langkah Pengujian | Hasil yang Diharapkan | Hasil Aktual | Status |
| :---: | :--- | :--- | :--- | :--- | :---: |
| **TC-2.01** | Layar menyala dari kondisi HP terkunci | Set alarm 1 menit ke depan $\rightarrow$ kunci layar HP $\rightarrow$ tunggu jam alarm | Layar HP otomatis menyala penuh (*Full-Screen Intent*) menampilkan Layar Tugas | Layar terkunci berhasil ditembus dan menyala | **PASS** ✅ |
| **TC-2.02** | Alarm tetap berbunyi saat app di-kill | Set alarm $\rightarrow$ hapus app dari daftar Recent Apps $\rightarrow$ tunggu | Suara alarm tetap meraung kencang via Foreground Service `mediaPlayback` | Audio berbunyi tanpa terputus | **PASS** ✅ |
| **TC-2.03** | Proteksi Volume Lock (*Anti-Cheat*) | Saat alarm berdering, tekan tombol fisik volume bawah berkali-kali | Suara tidak bisa mengecil, volume otomatis kembali 100% | Volume langsung kembali penuh seketika | **PASS** ✅ |
| **TC-2.04** | Misi Matematika (Kognitif) | Jawab 1 soal salah $\rightarrow$ jawab 3 berturut-turut benar | Jawaban salah me-reset hitungan; 3 jawaban benar mematikan alarm | Logika aritmatika memvalidasi jawaban ketat | **PASS** ✅ |
| **TC-2.05** | Misi Goyang HP (Fisik) | Goyang HP pelan vs goyang bertenaga 20x | Goyangan santai tidak terhitung; goyangan kuat mengisi progress bar 20/20 | Threshold akselerometer responsif | **PASS** ✅ |
| **TC-2.06** | Misi Lompat (Fisik) | Goyangkan tangan vs melompat di tempat 15x | Sistem hanya mendeteksi lonjakan percepatan *free-fall + impact* | Berhasil membedakan getaran palsu | **PASS** ✅ |
| **TC-2.07** | Misi Kamera / Selfie | Ambil foto objek / wajah di pagi hari | Viewfinder kamera terbuka cepat dan memverifikasi tersimpannya foto | Kamera terbuka tanpa lag memori | **PASS** ✅ |

---

### 🔁 FLOW 3: Statistik, Gamifikasi & Navigasi Layar (Stats & Profile Flow)
*Fokus: Validasi perpindahan 3 tab navigasi bawah, penambahan streak harian, dan profil.*

| ID Test | Skenario Pengujian | Langkah Pengujian | Hasil yang Diharapkan | Hasil Aktual | Status |
| :---: | :--- | :--- | :--- | :--- | :---: |
| **TC-3.01** | Navigasi Bottom Bar | Klik tab *Beranda*, *Statistik*, dan *Profil* | Berpindah layar secara instan dengan indikator pill warna peach | Navigasi 3 tab berjalan mulus | **PASS** ✅ |
| **TC-3.02** | Penghitungan Streak | Selesaikan tugas alarm pagi tepat waktu | Angka streak bertambah $+1$ hari (ikon api 🔥) di tab Statistik | Streak tercatat di riwayat | **PASS** ✅ |
| **TC-3.03** | Grafik Jam Bangun 7 Hari | Buka tab Statistik setelah beberapa hari pakai | Grafik batang mingguan menampilkan jam bangun | Bar chart terender rapi | **PASS** ✅ |

---

## 📱 BAGIAN 3: Matriks Uji Kompatibilitas Perangkat (Device Lab)

Pengujian dilakukan langsung pada perangkat fisik Android asli dari berbagai merek dengan sistem pembunuh background agresif:

| Merek & Model HP | Versi Android / OS | Respon Layar Kunci | Respon Volume Lock | Alarm Tembus Doze Mode? | Kesimpulan |
| :--- | :--- | :---: | :---: | :---: | :--- |
| **Xiaomi Redmi Note 11** | Android 13 / MIUI 14 | ✅ Berhasil | ✅ Terkunci 100% | ✅ Tembus *(Perlu set Autostart)* | Siap Pakai |
| **Samsung Galaxy A53** | Android 14 / One UI 6.0 | ✅ Berhasil | ✅ Terkunci 100% | ✅ Tembus | Siap Pakai |
| **Oppo Reno 8** | Android 13 / ColorOS 13 | ✅ Berhasil | ✅ Terkunci 100% | ✅ Tembus *(Perlu izinkan background)* | Siap Pakai |
| **Google Pixel 6a** | Android 14 (Stock Android)| ✅ Berhasil | ✅ Terkunci 100% | ✅ Tembus instan | Siap Pakai |

---

## 🐛 BAGIAN 4: Lembar Pelaporan & Verifikasi Bug (Bug Tracker)

| Bug ID | Deskripsi Masalah | Tingkat (*Severity*) | PIC Perbaikan | Status Perbaikan | Verifikasi QA |
| :---: | :--- | :---: | :---: | :---: | :---: |
| `BUG-01` | APK membengkak hingga 179 MB karena fat-build universal | **High** | Anggota 5 (QA) | Fixed via `--split-per-abi` + R8 | **RESOLVED** (Turun ke 9.19 MB) ✅ |
| `BUG-02` | Layar web server blank putih karena tag base-href | **Medium** | Anggota 2 (Frontend) | Fixed `<base href="/">` di index.html | **RESOLVED** (Tampil normal di HP) ✅ |
| `BUG-03` | Error `withValues` dan `activeThumbColor` di Flutter 3.24 | **Medium** | Anggota 3 (System) | Diganti ke `.withOpacity()` dan `activeColor` | **RESOLVED** (Compile sukses) ✅ |

---

## ✍️ BAGIAN 5: Lembar Pengesahan Rilis (QA Sign-Off)

Berdasarkan seluruh rangkaian uji coba fungsional, performa ukuran APK, dan keandalan sistem alarm di atas:

* **Tingkat Keberhasilan Uji (*Test Pass Rate*)**: **100%** (15 dari 15 Test Cases lolos).
* **Ukuran APK Final**: **9.19 MB** (Lolos standar ringan).
* **Rekomendasi QA**: **APPROVED FOR PRODUCTION / DEMO PRESENTATION** 🚀

```
Disetujui oleh:
[ Anggota 5 ]
QA, Performance & Release Specialist
Proyek BangunYuk
```
