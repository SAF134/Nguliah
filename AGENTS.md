# AGENTS.md: Nguliah

Aplikasi Android (Flutter) manajemen akademik mahasiswa: Nilai, Jadwal, Tugas, Acara. Offline-first, tanpa backend/akun. Repo GitHub publik, lisensi MIT.

## Sumber Kebenaran
- `prd.md`: fitur, aturan, kriteria penerimaan. Jika kode dan PRD berbeda, PRD menang; tanyakan sebelum menyimpang.
- `DESIGN.md`: token, komponen, layout, state, aksesibilitas. Jangan hardcode warna/ukuran di luar token.
- Bahasa: komunikasi dan komentar dokumen dalam Indonesia; identifier kode dalam Inggris.

## Stack
Flutter (Dart), Material 3, Riverpod, Isar (lokal), go_router, fl_chart, table_calendar, flutter_local_notifications, pdf + printing, share_plus, image_picker, file_picker, intl/gen-l10n (ID default, EN). Min SDK Android 7.0 (API 24).
Jangan menambah dependensi baru tanpa alasan tertulis di PR.

## Struktur (feature-first)
```
lib/
  core/      # theme (token), router, utils, widgets reusable, services (notifikasi, export, backup)
  data/      # model Isar, repository
  features/  # onboarding, auth(masuk), home, grades, schedule, tasks, events, settings
  l10n/      # app_id.arb (utama), app_en.arb
test/        # unit (logika nilai), widget
```
Tiap fitur: `presentation/` (UI), `application/` (provider/logika), `domain/` bila perlu. UI tidak mengakses Isar langsung; lewat repository.

## Perintah
```
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # Isar codegen
flutter gen-l10n
flutter analyze        # harus bersih
flutter test           # harus lulus
flutter run
flutter build apk --release
```

## Aturan Wajib
1. **Logika nilai** ikut bagian "Logika Perhitungan Nilai" di `prd.md` (IPS historis, IPK memakai entri terpakai per kelompok MK, E wajib mengulang, lulus minimum D). Letakkan di satu tempat (`grades/application`), murni (tanpa UI), dan **wajib ada unit test** untuk: E, perbaikan lebih tinggi/rendah, hapus entri ulang, bobot kustom.
2. **Semua teks UI** lewat l10n (ID + EN); tidak ada string hardcode.
3. **Data lokal saja.** Tidak ada permintaan jaringan, analitik, atau pelacakan. Izin hanya yang perlu (notifikasi, galeri/kamera/penyimpanan saat dipakai).
4. **Backup** berformat JSON dengan nomor versi skema; restore harus memvalidasi sebelum menimpa, dan konfirmasi dulu.
5. **Notifikasi** harus terjadwal ulang setelah reboot dan saat data diubah/dihapus.
6. **Aksesibilitas** sesuai `DESIGN.md` bagian 10: `Semantics` pada ikon-tombol, target ≥ 48 dp, status tidak hanya lewat warna, `SlideToConfirm` punya aksi alternatif.
7. **State** wajib lengkap per layar kunci: kosong, memuat, error, sukses, izin ditolak (lihat `DESIGN.md` bagian 8).
8. Perubahan skema Isar harus disertai migrasi dan dicatat di versi backup.

## Gaya Kode
- Ikuti `flutter_lints`; `dart format` sebelum commit.
- Widget kecil dan `const` bila bisa; hindari file > 300 baris.
- Nama: `snake_case` file, `PascalCase` kelas, `camelCase` anggota.
- Tanpa `print`; gunakan logger yang dinonaktifkan di release.
- Jangan menyalin gaya/kode yang tidak diminta; ubah seperlunya (diff kecil).

## Git
- Branch: `main` (stabil), `dev`, `feat/<nama>`, `fix/<nama>`.
- Commit: Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`).
- Satu PR = satu tujuan; sertakan tangkapan layar untuk perubahan UI.
- Jangan commit: keystore, `key.properties`, `.env`, file build, data pribadi. Aset QRIS pengembang boleh sebagai aset statis.

## Definisi Selesai
`flutter analyze` bersih, `flutter test` lulus, kriteria penerimaan di `prd.md` terpenuhi, UI sesuai token `DESIGN.md`, teks ID + EN ada, diuji di terang dan gelap.

## Batas Agent
- Kerjakan hanya yang diminta; ambigu → tanya, jangan menebak.
- Jangan ubah `prd.md`/`DESIGN.md` tanpa diminta; usulkan perubahan di jawaban.
- Jangan buat dokumen markdown baru yang tidak dibutuhkan proyek.
- Jangan jalankan aksi destruktif (hapus berkas, force push, ubah riwayat git) tanpa persetujuan.
