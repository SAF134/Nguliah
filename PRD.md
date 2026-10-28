# Dokumen Kebutuhan Produk: Nguliah

## Gambaran Umum Produk

**Visi Produk:** Aplikasi Android offline untuk membantu mahasiswa mengelola nilai, jadwal, tugas, dan acara akademik dalam satu tempat.

**Target Pengguna:** Utama: mahasiswa S1/D3/D4 di Indonesia. Sekunder: mahasiswa pascasarjana dan calon mahasiswa yang ingin belajar mengatur akademik.

**Tujuan Bisnis:** Menyediakan aplikasi gratis, open source, dan ringan; membangun basis pengguna mahasiswa; menerima dukungan sukarela lewat Buy Me a Coffee (QRIS).

**Metrik Keberhasilan:** Jumlah unduhan, pengguna aktif mingguan (WAU), retensi D7/D30, jumlah data (nilai/tugas) per pengguna, crash-free rate ≥ 99%, GitHub stars.

## Persona Pengguna

### Persona 1: Rani (Mahasiswa Aktif)

- **Demografi:** 20 tahun, mahasiswa semester 4, mahir menggunakan smartphone
- **Tujuan:** Memantau IPK/IPS, tidak lupa jadwal dan tenggat tugas
- **Kendala/Masalah:** Catatan tersebar (chat, kertas, spreadsheet), sering lupa tenggat, hitung IPK manual
- **Perjalanan Pengguna:** Onboarding → isi biodata → input nilai & jadwal → terima pengingat → cek Beranda → export rekap untuk laporan/beasiswa

### Persona 2: Dimas (Mahasiswa Tingkat Akhir)

- **Demografi:** 22 tahun, semester 8, aktif organisasi
- **Tujuan:** Memantau sebaran nilai, mengatur acara kampus dan kehadiran kuliah
- **Kendala/Masalah:** Jadwal kuliah bentrok dengan acara, perlu bukti rekap kehadiran, khawatir kehilangan data saat ganti HP
- **Perjalanan Pengguna:** Catat acara → isi presensi tiap kuliah → export rekap → backup data berkala

## Kebutuhan Fitur

| Fitur                                         | Deskripsi                                                                                                                                                                          | User Story                                                                                                     | Prioritas | Kriteria Penerimaan                                                                                                                                                                        | Dependensi              |
| --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------------- |
| **Splash Screen**                             | Logo, nama aplikasi, animasi loading                                                                                                                                               | Sebagai pengguna, saya ingin melihat tampilan pembuka saat aplikasi dibuka                                     | Must      | Tampil ≤ 3 detik; lanjut ke Onboarding (pengguna baru) atau Beranda                                                                                                                        | -                       |
| **Onboarding**                                | 4 slide: Nilai, Jadwal, Tugas, Acara                                                                                                                                               | Sebagai pengguna baru, saya ingin memahami fitur utama                                                         | Must      | 4 slide dapat digeser; tombol Lewati/Lanjut; hanya tampil sekali                                                                                                                           | Splash                  |
| **Masuk (Biodata)**                           | Form nama, universitas, fakultas, prodi, tahun masuk (tanpa akun/server)                                                                                                           | Sebagai pengguna, saya ingin mengisi profil agar aplikasi personal                                             | Must      | Semua kolom wajib valid; data tersimpan lokal; tidak bisa lanjut jika kosong                                                                                                               | Onboarding              |
| **Beranda**                                   | Kartu IPK, SKS selesai, MK selesai; jadwal hari ini; tugas minggu ini; grafik tren IPK/IPS; chart sebaran nilai                                                                    | Sebagai pengguna, saya ingin ringkasan akademik sekilas                                                        | Must      | Data real-time dari database; empty state jika belum ada data                                                                                                                              | Nilai, Jadwal, Tugas    |
| **Export Statistik Beranda**                  | Export grafik IPK dan sebaran nilai ke PDF/JPG/PNG                                                                                                                                 | Sebagai pengguna, saya ingin menyimpan statistik sebagai dokumen/gambar                                        | Should    | Pilih format; file tersimpan di perangkat dan bisa dibagikan                                                                                                                               | Beranda                 |
| **CRUD Nilai**                                | Nama MK, semester, SKS, index (A, AB, B, BC, C, D, E); opsi "Mengulang/Perbaikan dari" (pilih entri sebelumnya); IPS & IPK otomatis                                                | Sebagai pengguna, saya ingin mencatat nilai per semester, termasuk mengulang MK (nilai E atau perbaikan nilai) | Must      | Tambah/ubah/hapus (dengan konfirmasi); semester 1–14; SKS > 0; nilai E diberi label "Perlu mengulang"; saran tautan mengulang jika nama MK sama; IPS/IPK sesuai "Logika Perhitungan Nilai" | Pengaturan (konversi)   |
| **Export Nilai**                              | Export per IPS, semua semester, atau IPK; PDF/JPG/PNG                                                                                                                              | Sebagai pengguna, saya ingin mengekspor transkrip sederhana                                                    | Should    | Pilihan cakupan + format; hasil rapi dan terbaca                                                                                                                                           | CRUD Nilai              |
| **CRUD Jadwal**                               | Nama MK, hari, mulai, selesai, ruangan                                                                                                                                             | Sebagai pengguna, saya ingin mengatur jadwal kuliah mingguan                                                   | Must      | Waktu selesai > mulai; peringatan jika bentrok; urut per hari                                                                                                                              | -                       |
| **Presensi**                                  | Isi hadir/sakit/izin/alpa + keterangan; waktu pengisian dicatat otomatis; rekap per MK                                                                                             | Sebagai pengguna, saya ingin mencatat kehadiran dan catatan tiap pertemuan                                     | Must      | Satu presensi per sesi per tanggal; bisa diubah; rekap persentase kehadiran                                                                                                                | CRUD Jadwal             |
| **Export Jadwal & Presensi**                  | Export rekap presensi + catatan dan pratinjau jadwal seminggu; PDF/JPG/PNG                                                                                                         | Sebagai pengguna, saya ingin bukti rekap dan jadwal untuk dibagikan                                            | Should    | Pilih jenis rekap + format; tampilan tabel mingguan jelas                                                                                                                                  | Presensi                |
| **CRUD Tugas**                                | Nama MK, deskripsi, tenggat hari & jam; kalender penanda tugas                                                                                                                     | Sebagai pengguna, saya ingin melacak tugas dan tenggatnya                                                      | Must      | Tanggal pada kalender bertanda; tugas lewat tenggat ditandai                                                                                                                               | -                       |
| **Selesaikan Tugas & Rekap**                  | Tandai selesai, catat waktu penyelesaian, riwayat rekap                                                                                                                            | Sebagai pengguna, saya ingin tahu kapan tugas selesai                                                          | Must      | Waktu selesai tersimpan; bisa batal tandai; daftar rekap selesai                                                                                                                           | CRUD Tugas              |
| **CRUD Acara**                                | Nama, deskripsi, tanggal, jam mulai, jam selesai; kalender bulanan dengan penanda                                                                                                  | Sebagai pengguna, saya ingin mengatur acara non-kuliah                                                         | Must      | Jam selesai > mulai; penanda di kalender; navigasi antarbulan                                                                                                                              | -                       |
| **Pengaturan: Bahasa**                        | Indonesia (default) dan Inggris                                                                                                                                                    | Sebagai pengguna, saya ingin memilih bahasa                                                                    | Must      | Berubah langsung tanpa restart; tersimpan                                                                                                                                                  | -                       |
| **Pengaturan: Profil**                        | Ubah biodata dan foto profil (galeri/kamera)                                                                                                                                       | Sebagai pengguna, saya ingin memperbarui profil                                                                | Should    | Foto dikompres dan tersimpan lokal                                                                                                                                                         | Masuk                   |
| **Pengaturan: Konversi Nilai**                | Ubah bobot tiap index (default A=4, AB=3.5, B=3, BC=2.5, C=2, D=1, E=0); nilai lulus minimum (default D); aturan nilai mengulang (default: tertinggi, opsi: terbaru); tombol reset | Sebagai pengguna, saya ingin menyesuaikan aturan kampus saya                                                   | Must      | IPS/IPK/SKS selesai dihitung ulang otomatis; reset ke default                                                                                                                              | CRUD Nilai              |
| **Pengaturan: Panduan Rumus**                 | Penjelasan rumus IPS/IPK dengan contoh                                                                                                                                             | Sebagai pengguna, saya ingin paham cara hitung nilai                                                           | Could     | Teks statis dua bahasa                                                                                                                                                                     | -                       |
| **Pengaturan: Notifikasi**                    | Pengingat Jadwal, Tugas, Acara; waktu pengingat diatur terpisah                                                                                                                    | Sebagai pengguna, saya ingin pengingat tepat waktu                                                             | Must      | Aktif/nonaktif tiap jenis; pilihan offset (mis. 10 mnt/1 jam/1 hari); tetap jalan setelah reboot; izin notifikasi Android 13+                                                              | CRUD Jadwal/Tugas/Acara |
| **Pengaturan: Backup & Restore**              | Ekspor/impor seluruh data ke file statis (JSON) di perangkat + panduan                                                                                                             | Sebagai pengguna, saya ingin mengamankan data dari kehilangan                                                  | Must      | File backup bernama berstempel waktu; restore memvalidasi format/versi; konfirmasi sebelum menimpa data                                                                                    | Semua data              |
| **Pengaturan: Tentang Aplikasi**              | Versi, deskripsi, lisensi, tautan GitHub                                                                                                                                           | Sebagai pengguna, saya ingin tahu info aplikasi                                                                | Should    | Versi otomatis dari build                                                                                                                                                                  | -                       |
| **Pengaturan: Tentang Pengembang & Dukungan** | Profil pengembang, Buy Me a Coffee dengan gambar QRIS statis                                                                                                                       | Sebagai pengguna, saya ingin mendukung pengembang                                                              | Could     | Gambar QRIS tampil jelas, bisa diperbesar/disimpan; tanpa transaksi dalam aplikasi                                                                                                         | -                       |

## Alur Pengguna (User Flows)

### Alur 1: Pertama Kali Membuka Aplikasi

1. Splash Screen
2. Onboarding 4 slide
3. Isi biodata di halaman Masuk
4. Masuk ke Beranda

- Jalur alternatif: Lewati onboarding
- Kondisi error: Kolom biodata kosong/tidak valid → pesan di bawah kolom

### Alur 2: Input Nilai dan Lihat IPK

1. Buka halaman Nilai → Tambah
2. Isi MK, semester, SKS, index → Simpan
3. IPS/IPK diperbarui; Beranda menampilkan statistik

- Jalur alternatif: Edit/hapus nilai; export
- Kondisi error: SKS tidak valid → simpan ditolak

### Alur 3: Jadwal dan Presensi

1. Tambah jadwal kuliah
2. Saat sesi berlangsung, buka jadwal → isi presensi + keterangan
3. Lihat rekap kehadiran → export

- Jalur alternatif: Ubah presensi yang sudah diisi
- Kondisi error: Jadwal bentrok → peringatan, boleh tetap simpan

### Alur 4: Tugas

1. Tambah tugas dengan tenggat
2. Terima pengingat
3. Tandai selesai → waktu selesai tercatat di rekap

- Jalur alternatif: Batalkan tanda selesai
- Kondisi error: Izin notifikasi ditolak → arahkan ke pengaturan sistem

### Alur 5: Backup dan Restore

1. Pengaturan → Backup → pilih lokasi simpan
2. File backup dibuat
3. Di perangkat baru: Restore → pilih file → konfirmasi

- Kondisi error: File rusak/versi tidak cocok → restore dibatalkan, data lama aman

## Logika Perhitungan Nilai

Mengikuti praktik umum universitas di Indonesia. Bobot, nilai lulus minimum, dan aturan mengulang dapat diubah di Pengaturan.

**Definisi**

- **Entri:** satu baris nilai (MK, semester, SKS, index). MK yang diulang menghasilkan beberapa entri; semua entri tetap tersimpan sebagai riwayat.
- **Kelompok MK:** entri-entri yang dihubungkan lewat "Mengulang dari" (satu MK yang sama).
- **Entri terpakai:** entri yang dipakai dalam IPK per kelompok = nilai tertinggi (default) atau terbaru (opsi). Jika nilai sama, pakai yang terbaru.
- **Lulus:** index ≥ nilai lulus minimum (default D). Nilai E selalu tidak lulus (wajib mengulang).

**Rumus**

- **IPS semester s** = Σ(bobot × SKS) / Σ SKS, dari semua entri di semester s (termasuk E bernilai 0 dan entri perbaikan di semester tersebut). IPS bersifat historis: nilai E tetap menurunkan IPS semester asalnya walau sudah diulang.
- **IPK** = Σ(bobot × SKS) / Σ SKS, dari entri terpakai tiap kelompok MK. MK dengan nilai E yang belum diulang tetap dihitung (bobot 0, SKS masuk pembagi). Setelah diulang, E tidak lagi dihitung di IPK.
- **SKS Selesai** = Σ SKS entri terpakai yang lulus (tiap kelompok MK dihitung sekali).
- **MK Selesai** = jumlah kelompok MK yang entri terpakainya lulus.
- **Sebaran nilai (chart)** = jumlah entri terpakai per index (tidak ada duplikat MK yang diulang).
- Pembulatan: 2 desimal untuk tampilan; perhitungan memakai nilai penuh.

**Kasus mengulang**

1. **Nilai E:** MK ditandai "Perlu mengulang"; pengguna menambah entri baru di semester berikutnya dengan "Mengulang dari" entri E. IPK memakai entri baru; IPS semester lama tidak berubah.
2. **Perbaikan nilai (mis. C → B):** sama dengan di atas; dengan aturan "tertinggi", nilai B dipakai. Jika nilai baru lebih rendah (mis. C → D), nilai C tetap dipakai (aturan "terbaru": D dipakai).
3. **Hapus entri ulang:** kelompok kembali memakai entri yang tersisa; IPK dihitung ulang.
4. **SKS berbeda antar-entri** (mis. kurikulum berubah): SKS diambil dari entri terpakai.
5. **Contoh:** Statistika 3 SKS, semester 2 nilai E; semester 3 diulang dapat B. IPS sem-2 memuat E (0 × 3). IPK memuat B (3 × 3); SKS Selesai +3; MK Selesai +1.

## Kebutuhan Non-Fungsional

### Performa

- **Waktu Muat (Load Time):** Cold start ≤ 3 detik
- **Pengguna Bersamaan:** Tidak berlaku (aplikasi offline, satu pengguna)
- **Waktu Respons:** Interaksi UI ≤ 100 ms; hitung IPK untuk 500 data ≤ 200 ms

### Keamanan

- **Autentikasi:** Tidak ada akun/login server (halaman "Masuk" hanya biodata lokal)
- **Otorisasi:** Satu pengguna per perangkat
- **Perlindungan Data:** Semua data disimpan lokal; tidak ada pengiriman data ke server; tanpa izin internet kecuali dibutuhkan; izin hanya notifikasi, penyimpanan/galeri/kamera saat dipakai

### Kompatibilitas

- **Perangkat:** Android smartphone (iOS di luar cakupan)
- **Browser:** Tidak berlaku
- **Ukuran Layar:** Ponsel 5"–7"; mode potret; tablet bersifat opsional

### Aksesibilitas

- **Tingkat Kepatuhan:** Mengacu WCAG 2.1 AA (kontras warna, target sentuh ≥ 48dp)
- **Persyaratan Khusus:** Dukungan ukuran font sistem, label semantik, mode gelap/terang mengikuti sistem

## Spesifikasi Teknis

### Frontend

- **Stack Teknologi:** Flutter (Dart), state management Riverpod, fl_chart (grafik), table_calendar (kalender), flutter_local_notifications, pdf + printing (PDF), RepaintBoundary (JPG/PNG), share_plus, image_picker, file_picker, intl/flutter_localizations (ID/EN)
- **Sistem Desain:** Material 3, tema terang/gelap
- **Desain Responsif:** Layout adaptif untuk berbagai ukuran ponsel

### Backend

- **Stack Teknologi:** Tidak ada backend (offline-first)
- **Persyaratan API:** Tidak ada
- **Basis Data:** Isar (lokal). Koleksi: Profil, Nilai, Jadwal, Presensi, Tugas, Acara, Pengaturan (termasuk bobot konversi)

### Infrastruktur

- **Hosting:** Repositori GitHub publik (lisensi MIT); distribusi APK via GitHub Releases (Play Store opsional di masa depan)
- **Skalabilitas:** Tidak berlaku; cukup menangani ribuan record lokal
- **CI/CD:** GitHub Actions: analyze, test, build APK/AAB pada tag rilis; branch `main` + `dev`

## Analitik & Pemantauan

- **Metrik Utama:** Tidak ada pelacakan pihak ketiga pada v1.0 (privasi); metrik dari unduhan GitHub/Play
- **Event:** Tidak ada
- **Dashboard:** Tidak ada
- **Notifikasi/Alert:** Pelaporan bug lewat GitHub Issues

## Perencanaan Rilis

### MVP (v1.0)

- **Fitur:** Semua fitur di tabel di atas (prioritas Must dan Should); Could (Panduan Rumus, Tentang Pengembang/QRIS) disertakan karena ringan
- **Linimasa:** Ditentukan pengembang (perkiraan 6–8 minggu: desain 1, inti CRUD 3, export/notifikasi 2, uji & rilis 1–2)
- **Kriteria Keberhasilan:** Semua alur utama berjalan offline tanpa crash; IPS/IPK akurat; backup–restore berhasil

### Rilis Mendatang

- **v1.1:** Widget layar utama, mode gelap manual, penyempurnaan UI (usulan)
- **v1.2:** Target IPK, pengingat presensi, pencarian (usulan)
- **v2.0:** Opsi sinkronisasi cloud, dukungan iOS (usulan)

## Pertanyaan Terbuka & Asumsi

- **Keputusan:** Semester dibatasi 1–14 (pilihan semester pada form nilai); tidak ada pertanyaan terbuka tersisa
- **Asumsi 1:** Aplikasi berjalan sepenuhnya offline; bahasa default Indonesia
- **Asumsi 2:** Perhitungan IPS/IPK mengikuti "Logika Perhitungan Nilai" (E wajib mengulang; mengulang memakai nilai tertinggi; lulus minimum D; semua dapat diubah di Pengaturan)
- **Asumsi 3:** Gambar QRIS disediakan pengembang sebagai aset statis
- **Asumsi 4:** Min SDK Android 7.0 (API 24)

## Lampiran

### Analisis Kompetitor

- **Kompetitor 1 (aplikasi kalender/to-do umum):** Fleksibel, tetapi tidak ada IPK, presensi, atau sebaran nilai
- **Kompetitor 2 (aplikasi jadwal kuliah):** Fokus jadwal; fitur nilai/export terbatas dan sering berisi iklan

### Temuan Riset Pengguna

- **Temuan 1:** Mahasiswa butuh pemantauan IPK dan tenggat dalam satu aplikasi tanpa harus membuat akun

### Wawasan Percakapan AI

- **Percakapan 1:** 2026-10-27, Claude, penyusunan PRD berdasarkan deskripsi pengguna dan template
- **Kasus Khusus (Edge Cases) yang Dihasilkan AI:** Jadwal bentrok; presensi ganda; mata kuliah mengulang (E/perbaikan, termasuk nilai ulang lebih rendah); perubahan bobot setelah ada data; restore file versi lama; izin notifikasi ditolak; perangkat dengan penghemat baterai agresif
- **Peningkatan yang Disarankan AI:** Pengingat tetap jalan setelah reboot; versi skema pada file backup; validasi sebelum restore

### Glosarium

- **IPK:** IPK
- **IPS:** IPS
- **SKS:** Satuan Kredit Semester
- **QRIS:** Standar kode QR pembayaran Indonesia
- **Presensi:** Pencatatan kehadiran kuliah
