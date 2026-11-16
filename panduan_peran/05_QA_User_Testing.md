# Panduan Kerja: QA & User Testing (Anggota 5)
## Proyek: BangunYuk — Smart Habit-Breaking Alarm

Sebagai **Quality Assurance (QA) & User Testing**, Anda adalah "penjaga gerbang kualitas" dari BangunYuk. Bagi aplikasi alarm, sebuah kegagalan (misalnya alarm tidak berbunyi karena HP mati layar) bisa berakibat fatal bagi pengguna (terlambat kerja, ketinggalan ujian). Tugas Anda adalah mencari kelemahan dan celah aplikasi sebelum dirilis ke pengguna.

---

## 🎯 Target Utama Anda pada Fase Perancangan Awal
1. Dokumen Test Plan & Matriks Pengujian skenario kritis (Edge Cases).
2. Lembar pencatatan bug (*Bug Tracker & Reproduction Steps*).
3. Pengujian langsung pada perangkat fisik Android (bukan sekadar emulator).
4. Verifikasi ketahanan mekanisme *anti-cheat* dan *volume lock*.

---

## 🛠️ Tools yang Digunakan
- **Dokumen Uji**: Spreadsheet (Google Sheets) atau Markdown Checklist.
- **Device Lab**: Perangkat fisik Android (utamakan mencoba di merek dengan sistem manajemen baterai agresif seperti Xiaomi/MIUI, Oppo/ColorOS, Samsung/OneUI).
- **Log Viewer**: Android Studio Logcat / `adb logcat` (untuk melihat pesan error saat crash).

---

## 🪜 Langkah-Langkah Kerja Tahap Demi Tahap

### Langkah 1: Penyusunan Test Plan & Test Cases (Hari 1–3)
Susun tabel skenario uji dengan kolom: `ID Test`, `Deskripsi Skenario`, `Langkah Pengujian`, `Hasil yang Diharapkan`, `Hasil Aktual`, dan `Status (Pass/Fail)`.

Kategori skenario utama:
1. **Skenario Pemicu Alarm**:
   - `TC-01`: Alarm disetel 2 menit ke depan, aplikasi tetap di layar depan $\rightarrow$ Alarm wajib berbunyi.
   - `TC-02`: Alarm disetel 5 menit ke depan, pengguna menekan tombol Home $\rightarrow$ Alarm wajib berbunyi.
   - `TC-03`: Alarm disetel, layar HP dimatikan dan dikunci $\rightarrow$ Layar wajib menyala otomatis dan menampilkan layar tugas.
   - `TC-04`: Aplikasi di-swipe dari daftar *Recent Apps* $\rightarrow$ Alarm tetap berbunyi tepat waktu via Foreground Service.
   - `TC-05`: HP di-restart 15 menit sebelum jam alarm $\rightarrow$ Alarm tetap berbunyi setelah reboot.
   - `TC-06`: HP dalam mode "Jangan Ganggu" (*Do Not Disturb*) $\rightarrow$ Alarm tetap menghasilkan bunyi.

2. **Skenario Anti-Cheat & Tombol Fisik**:
   - `TC-07`: Alarm meraung, pengguna menekan tombol fisik volume down berulang kali $\rightarrow$ Suara tidak boleh mengecil (otomatis kembali 100%).
   - `TC-08`: Pengguna menekan tombol "Back" berulang kali di layar tugas $\rightarrow$ Navigasi tertahan, layar tugas tidak boleh tertutup.

3. **Skenario Validasi 6 Tugas Kebangunan**:
   - `TC-09 (Matematika)`: Memasukkan jawaban salah $\rightarrow$ Hitungan jawaban benar direset, tingkat kesulitan bertambah.
   - `TC-10 (Matematika)`: Memasukkan 3 jawaban benar berturut-turut $\rightarrow$ Tugas dinyatakan selesai.
   - `TC-11 (Ketik Frasa)`: Typo 1 huruf $\rightarrow$ Sistem menolak tombol selesai.
   - `TC-12 (Goyang HP)`: Menggoyang ponsel pelan-pelan $\rightarrow$ Threshold sensor tidak boleh tertipu.
   - `TC-13 (Lompat)`: Menggoyangkan tangan menyerupai lompatan $\rightarrow$ Sistem hanya menghitung saat terjadi kombinasi *free-fall* dan *impact*.
   - `TC-14 (Kamera/Foto)`: Mengambil foto $\rightarrow$ Kamera merespons cepat tanpa error out-of-memory.

4. **Skenario Multi-Task & Streak**:
   - `TC-15`: Memilih 2 tugas (Matematika + Goyang) $\rightarrow$ Alarm baru boleh mati setelah KEDUA tugas selesai berurutan.
   - `TC-16`: Setelah selesai tepat waktu $\rightarrow$ Angka streak hari di halaman statistik bertambah 1.

### Langkah 2: Eksekusi Pengujian Sesi 1 (Hari 4–5)
- [ ] Dapatkan file build APK dari developer.
- [ ] Install pada perangkat fisik Android.
- [ ] Lakukan *Smoke Test* menggunakan tombol "Coba alarm sekarang (5 detik)".
- [ ] Uji skenario `TC-01` sampai `TC-08`.

### Langkah 3: Pelaporan Bug & Siklus Retest (Hari 5–6)
Format pelaporan bug:
```markdown
### [BUG-01] [High/Critical] Layar tugas tidak muncul saat HP terkunci di Xiaomi MIUI 14
- **Perangkat**: Redmi Note 11 (Android 13, MIUI 14)
- **Langkah Reproduksi**:
  1. Setel alarm 2 menit ke depan.
  2. Kunci layar HP.
  3. Tunggu hingga menit alarm tiba.
- **Hasil yang Diharapkan**: Layar tugas terbuka penuh di atas lockscreen.
- **Hasil Aktual**: Hanya suara yang berbunyi, layar tetap hitam dan harus ditekan power secara manual.
- **Dugaan Penyebab**: Izin "Tampilkan di layar kunci" belum aktif di setelan sistem OEM.
```
- [ ] Kirimkan laporan bug kepada Anggota 2 (Frontend) atau Anggota 3 (System & Logic).
- [ ] Lakukan verifikasi ulang (*Retest*) setelah developer memperbaiki kode.

### Langkah 4: Uji Coba Pengguna Nyata (User Acceptance Testing) (Hari 6–7)
- [ ] Minta orang di luar tim (teman/keluarga) mencoba menyetel alarm dan bangun di pagi hari.
- [ ] Catat masukan: Apakah ada tugas yang terlalu sulit? Apakah instruksinya jelas?
- [ ] Serahkan laporan evaluasi akhir kepada Anggota 1 (Project Manager).

---

## 📋 Checklist Kriteria Sukses (Definition of Done QA)
- [ ] Seluruh skenario pemicu alarm (layar mati, kill recent apps, reboot) berstatus **PASS**.
- [ ] Tidak ada bug dengan tingkat keparahan *Blocker* atau *Critical* yang tersisa.
- [ ] Pengujian telah diverifikasi pada minimal 2 perangkat Android dari merk yang berbeda.

