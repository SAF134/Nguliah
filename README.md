# Nguliah

Aplikasi Android (*offline-first*) manajemen akademik mahasiswa untuk mengelola **Nilai (IPS/IPK)**, **Jadwal & Presensi**, **Tugas**, dan **Acara** dalam satu tempat tanpa akun/backend.

## Stack Utama
- **Flutter (Dart)** & **Material 3** (tema *soft glass* terang & gelap, Plus Jakarta Sans)
- **Riverpod** (state management) & **go_router** (navigasi)
- **Isar** (basis data lokal)
- **l10n** (`id` default, `en`)

## Fitur Utama (v1.0.0)
- **Nilai Akademik (IPS & IPK):** Perhitungan IPS historis dan IPK kumulatif per kelompok MK, penanda wajib mengulang (`E`), aturan perbaikan nilai (tertinggi/terbaru), dan bobot kustom.
- **Jadwal & Presensi Kuliah:** Jadwal mingguan dengan deteksi bentrok jam kuliah, pencatatan presensi per pertemuan (`Hadir`, `Sakit`, `Izin`, `Alpa`), dan rekap persentase kehadiran per mata kuliah.
- **Tugas & Acara Kampus:** Kalender penanda tenggat tugas dan acara bulanan, indikator progres sisa waktu, rekap riwayat tugas selesai, serta pengingat lokal otomatis.
- **Ekspor & Cadangan Lokal:** Ekspor statistik/transkrip/jadwal ke **PDF, PNG, dan JPG**, serta **Backup & Restore JSON** berstempel waktu dengan validasi versi skema.

## Perintah Pengembangan & Rilis
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter analyze
flutter test
flutter run
flutter build apk --release
```

## Lisensi
Didistribusikan di bawah lisensi [MIT](LICENSE).
