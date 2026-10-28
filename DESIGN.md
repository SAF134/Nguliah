# DESIGN.md: Nguliah

Android (Flutter), Material 3 sebagai basis, tampilan kustom bergaya *soft glass* biru. Mengacu ke `prd.md`.

## 1. Prinsip Desain

1. **Jelas dulu, cantik kemudian.** Angka akademik (IPK, tenggat, jam kuliah) adalah tokoh utama: besar, kontras tinggi, satu aksi utama per layar.
2. **Ringan tapi tenang.** Kartu kaca lembut, sudut membulat, bayangan halus. Maksimal satu elemen gradien menonjol per layar.
3. **Cepat dan aman.** Input ≤ 4 ketukan, aksi destruktif/restore selalu dikonfirmasi, status (lulus, mengulang, terlambat) tidak pernah hanya dibedakan lewat warna.

## 2. Arah Visual

- **Mood:** bersih, optimis, fokus, seperti aplikasi mobilitas modern yang tertata.
- **Diambil dari gambar referensi:** latar abu-biru muda; kartu kaca (*frosted*) berlapis; gradien biru untuk aksi utama; navigasi bawah berbentuk pil melayang; tombol *slide to confirm*; bilah progres bergradien (dipakai untuk sisa waktu tenggat); ikon garis tipis dalam lingkaran lembut; titik aksen magenta sebagai penanda kecil.
- **Diganti dari referensi:** peta/mobil → kalender, grafik, dan kartu mata kuliah; foto produk → ilustrasi/ikon sederhana.
- **Dihindari:** teks 9–11 px dan teks biru-muda di atas biru-muda (kontras referensi terlalu rendah); gradien di mana-mana; blur berat di perangkat low-end; bayangan pekat; dekorasi yang menutupi data; pop-up beruntun.

## 3. Design Tokens

### Warna (terang)
| Token | Hex | Pakai untuk |
|---|---|---|
| `bg` | `#F1F5FB` | Latar layar |
| `surface` | `#FFFFFF` | Kartu solid, sheet |
| `glass` | `#FFFFFF` @ 70% + border `#FFFFFF` @ 60% | Kartu kaca |
| `primary-600` | `#2563EB` | Tombol utama, ikon aktif, tautan |
| `primary-500` | `#3B82F6` | Ujung gradien |
| `primary-100` | `#DBEAFE` | Latar chip/ikon, progres kosong |
| `gradient-primary` | `#2563EB → #5B8DEF` (kiri ke kanan) | Tombol utama, nav pil, progres |
| `text-900` | `#0F172A` | Judul, angka |
| `text-700` | `#334155` | Isi |
| `text-600` | `#475569` | Teks sekunder |
| `text-500` | `#64748B` | Placeholder, caption (minimal di atas putih) |
| `border` | `#CBD5E1` | Garis input, pemisah |
| `success` | `#15803D` | Hadir, lulus, tugas selesai |
| `warning` | `#B45309` | Mendekati tenggat, izin/sakit |
| `error` | `#DC2626` | Nilai E, alpa, terlambat, hapus |
| `accent` | `#EC4899` | Penanda kecil/dekoratif saja |

### Warna (gelap, mengikuti sistem)
`bg #0B1220`, `surface #111B2E`, `glass #1E293B @ 70%`, `primary #60A5FA` (teks di atasnya `#0B1220`), `text-900 #F1F5F9`, `text-600 #CBD5E1`, `text-500 #94A3B8`, `border #334155`, `success #4ADE80`, `warning #FBBF24`, `error #F87171`.

### Warna nilai (grafik, selalu disertai label huruf)
A `#2563EB` · AB `#0EA5E9` · B `#14B8A6` · BC `#84CC16` · C `#F59E0B` · D `#F97316` · E `#DC2626`

### Tipografi: Plus Jakarta Sans (cadangan: Roboto)
| Token | Ukuran/Line | Berat | Pakai |
|---|---|---|---|
| `display` | 32/40 | 700 | Judul splash/onboarding |
| `number-xl` | 40/44 | 700, angka tabular | IPK |
| `h1` | 24/32 | 700 | Judul layar |
| `h2` | 20/28 | 600 | Judul section |
| `title` | 16/24 | 600 | Judul kartu |
| `body` | 14/20 | 400 | Isi |
| `caption` | 12/16 | 500 | Label, meta (minimum) |

Semua teks mengikuti skala font sistem (hingga 200%); tata letak harus tetap utuh.

### Spacing (kelipatan 4)
`4, 8, 12, 16, 20, 24, 32, 40, 48`. Margin layar 16, jarak antar-kartu 12, padding kartu 16.

### Radius
`sm 8` (chip kecil) · `md 12` (input) · `lg 16` (tombol) · `xl 24` (kartu) · `2xl 28` (sheet atas) · `full 999` (pil, nav, avatar).

### Shadow
| Token | Nilai |
|---|---|
| `sm` | `0 2 8 rgba(37,99,235,0.06)` |
| `md` | `0 8 24 rgba(30,64,175,0.10)` |
| `lg` | `0 16 40 rgba(30,64,175,0.16)` (nav pil, sheet) |

### Efek kaca
Blur 20 + isi `glass`. Jika perangkat low-end atau animasi tersendat, otomatis turun ke `surface` solid dengan `border`.

### Gerak
Durasi 150 ms (mikro), 250 ms (transisi), 400 ms (splash). Kurva `easeOutCubic`. Hormati "hapus animasi" sistem.

## 4. Inventaris Layar

| Layar | Tujuan |
|---|---|
| Splash | Menampilkan identitas, memuat database, memutuskan rute (baru → Onboarding, lama → Beranda) |
| Onboarding (4 slide) | Mengenalkan Nilai, Jadwal, Tugas, Acara |
| Masuk | Mengisi biodata lokal (nama, universitas, fakultas, prodi, tahun masuk) |
| Beranda | Ringkasan: IPK, SKS/MK selesai, jadwal hari ini, tugas minggu ini, grafik IPK, sebaran nilai, export |
| Nilai | Daftar nilai per semester, IPS/IPK, CRUD, mengulang MK, export |
| Form Nilai (sheet) | Tambah/ubah nilai |
| Jadwal | Jadwal mingguan, CRUD, akses presensi, export |
| Presensi (sheet) + Rekap | Isi hadir/sakit/izin/alpa + keterangan; lihat rekap per MK |
| Tugas | Kalender penanda + daftar, CRUD, tandai selesai, rekap selesai |
| Acara | Kalender bulanan + daftar, CRUD |
| Form Jadwal/Tugas/Acara (sheet) | Tambah/ubah data |
| Export (sheet) | Pilih cakupan dan format PDF/JPG/PNG |
| Pengaturan | Menu: Profil, Bahasa, Konversi Nilai, Panduan Rumus, Notifikasi, Backup, Tentang Aplikasi, Tentang Pengembang |
| Sub-layar Pengaturan | Satu layar per menu di atas; Tentang Pengembang memuat QRIS |

**Navigasi:** nav pil melayang 5 tab (Beranda, Nilai, Jadwal, Tugas, Acara). Pengaturan dibuka dari avatar di header Beranda (agar nav tidak penuh).

## 5. Alur Pengguna

1. **Pertama kali:** Splash → Onboarding (geser; tombol Lewati) → di slide 4 *Slide to Start* → Masuk (isi 5 kolom, Simpan) → Beranda.
2. **Input nilai:** Nilai → tombol + → sheet (MK, semester 1–14, SKS, index) → Simpan → daftar, IPS/IPK, dan Beranda ikut berubah.
3. **Mengulang MK:** pada kartu nilai E (label "Perlu mengulang") ketuk **Ulang** → sheet terisi MK, "Mengulang dari" terpilih → pilih semester baru + index → Simpan → IPK memakai nilai baru, riwayat tetap terlihat.
4. **Jadwal & presensi:** Jadwal → + → isi form → Simpan. Saat kuliah: ketuk kartu → sheet Presensi → pilih Hadir/Sakit/Izin/Alpa + keterangan → Simpan (waktu terisi otomatis) → Rekap.
5. **Tugas:** Tugas → + → isi form (tenggat) → Simpan → muncul penanda di kalender → pengingat → ketuk centang → tersimpan waktu selesai → masuk Rekap.
6. **Acara:** Acara → + → isi form → Simpan → penanda di kalender bulanan.
7. **Export:** ikon Export di Beranda/Nilai/Jadwal → sheet → pilih cakupan + format → Buat → pratinjau → Bagikan/Simpan.
8. **Backup:** Pengaturan → Backup → Buat backup → pilih lokasi → sukses. **Restore:** pilih file → validasi → *Geser untuk Restore* → data diganti.
9. **Ubah konversi nilai:** Pengaturan → Konversi → ubah bobot/lulus minimum/aturan mengulang → Simpan → IPS/IPK dihitung ulang (tampil toast).

Kondisi error tiap alur mengikuti `prd.md` (bagian Alur Pengguna).

## 6. Layout per Layar

Pola umum: header (judul `h1` + aksi) → konten bergulir → nav pil mengambang; konten diberi padding bawah 96 agar tidak tertutup nav.

| Layar | Susunan (atas ke bawah) | Aksi utama | Komponen |
|---|---|---|---|
| Splash | Logo, nama, indikator loading | - | Logo, ProgressRing |
| Onboarding | Ilustrasi, judul, deskripsi, indikator titik, Lewati | Lanjut / *Slide to Start* (slide 4) | PageView, DotIndicator, SlideToConfirm |
| Masuk | Judul, 5 kolom, tombol | Simpan & Mulai | TextField, Dropdown (tahun), PrimaryButton |
| Beranda | Header (sapaan, avatar) → kartu IPK (angka besar) + 2 kartu mini (SKS, MK selesai) → Jadwal Hari Ini → Tugas Minggu Ini → Grafik IPK → Sebaran Nilai | Tidak ada tombol tunggal; ketuk kartu menuju layar terkait | StatCard, GlassCard, LineChartCard, BarChartCard, ExportButton |
| Nilai | Header + export → ringkasan IPK/IPS terpilih → SegmentedControl/Chip semester → daftar kartu nilai (MK, SKS, GradeBadge) | + Tambah Nilai (FAB) | SemesterChips, CourseGradeCard, FAB, ExportSheet |
| Jadwal | Header → pemilih hari (chip Sen–Min) → daftar kartu jadwal (jam, MK, ruangan, status presensi) → tombol Rekap | + Tambah Jadwal (FAB) | DayChips, ScheduleCard, AttendanceSheet |
| Tugas | Header → kartu kalender (penanda) → daftar tugas (urut tenggat; progres sisa waktu) → tab Aktif/Selesai | + Tambah Tugas (FAB) | CalendarCard, TaskCard + ProgressBar, Tabs |
| Acara | Header → kalender bulanan (panah bulan) → daftar acara tanggal terpilih | + Tambah Acara (FAB) | CalendarCard, EventCard |
| Pengaturan | Kartu profil (foto, nama, Edit) → grup "Akun" → grup "Preferensi" → grup "Data" → grup "Tentang" | Edit Profil | ProfileHeader, SettingsRow |
| Backup | Penjelasan singkat, tombol Buat Backup, tombol Restore, panduan | Buat Backup | InfoCard, PrimaryButton, SlideToConfirm |
| Tentang Pengembang | Profil, ajakan dukung, gambar QRIS (ketuk untuk memperbesar) | Simpan QRIS | QrCard, SecondaryButton |

## 7. Pustaka Komponen

| Komponen | Varian | State |
|---|---|---|
| **GlassCard** | default, tappable, highlight | default, pressed, disabled |
| **StatCard** | angka besar, angka mini | loading (skeleton), kosong ("–") |
| **PrimaryButton** | gradien penuh, ukuran 48 | default, pressed, loading, disabled |
| **SecondaryButton / TextButton** | outline, teks | default, pressed, disabled |
| **DestructiveButton** | merah | default, pressed, disabled |
| **SlideToConfirm** | restore, mulai | idle, dragging, completed, disabled; alternatif tombol "Konfirmasi" bagi pengguna aksesibilitas |
| **TextField** | teks, angka, dropdown, waktu, tanggal | default, focus, filled, error (pesan di bawah), disabled |
| **GradeSelector** | 7 chip index (A–E) | unselected, selected, disabled |
| **GradeBadge** | per index, "Perlu mengulang", "Perbaikan" | statis |
| **AttendanceSelector** | 4 opsi (ikon + label) | unselected, selected |
| **Chip / SegmentedControl** | filter semester, hari, format export | unselected, selected |
| **CourseGradeCard** | normal, E (aksen error + label), riwayat ulang (tersusun) | default, pressed, swipe-aksi |
| **ScheduleCard / TaskCard / EventCard** | biasa, berlangsung, selesai, terlambat | default, pressed |
| **ProgressBar** | sisa waktu tenggat | normal, mendesak (warning), lewat (error) |
| **CalendarCard** | minggu/bulan, penanda titik | hari ini, terpilih, ada penanda |
| **ChartCard** | garis (IPK/IPS), batang (sebaran) | loading, kosong, data; ada tabel alternatif |
| **BottomNavPill** | 5 tab, ikon + label | aktif, tidak aktif |
| **BottomSheet** | form, export, presensi | terbuka, ditutup, error validasi |
| **ConfirmDialog** | hapus, timpa data | default |
| **Snackbar/Toast** | sukses, error, info (aksi Urungkan) | muncul 4 detik |
| **EmptyState** | ilustrasi + teks + tombol | statis |
| **Skeleton** | kartu, daftar | animasi shimmer |
| **SettingsRow** | navigasi, switch, nilai | default, pressed, disabled |
| **Avatar** | foto, inisial | default |

Area sentuh minimal 48×48 dp.

## 8. State per Layar Kunci

Aplikasi *offline-first*: tidak ada koneksi jaringan yang dibutuhkan, sehingga state "offline" tidak berlaku. Penggantinya adalah state **izin** (notifikasi, penyimpanan/galeri/kamera).

| Layar | Kosong | Memuat | Error | Sukses | Izin ditolak |
|---|---|---|---|---|---|
| Beranda | Kartu "Belum ada data" + tombol ke Nilai/Jadwal | Skeleton kartu | "Gagal memuat data" + Coba lagi | - | - |
| Nilai | Ilustrasi + "Tambah nilai pertama" | Skeleton daftar | Validasi di kolom (SKS > 0, semester 1–14) | Toast "Nilai tersimpan" (+ Urungkan hapus) | - |
| Jadwal | "Belum ada jadwal" | Skeleton | Peringatan bentrok (boleh lanjut) | Toast "Presensi tersimpan" | - |
| Tugas | "Tidak ada tugas" (tab Aktif); "Belum ada yang selesai" (tab Selesai) | Skeleton | Tenggat sudah lewat → label Terlambat | Toast "Tugas selesai" | Banner "Izin notifikasi ditolak" → tombol buka pengaturan |
| Acara | "Tidak ada acara" di tanggal terpilih | Skeleton | Jam selesai ≤ mulai → pesan di kolom | Toast "Acara tersimpan" | Sama seperti Tugas |
| Export | - | Dialog progres "Membuat file…" | "Gagal membuat file" + Coba lagi | Pratinjau + Bagikan/Simpan | Meminta izin penyimpanan jika perlu |
| Backup/Restore | "Belum pernah backup" | Progres | "File tidak valid/versi tidak cocok", data lama aman | "Backup berhasil" / "Restore berhasil" | Izin penyimpanan/pemilih file ditolak → arahkan ke pengaturan |
| Profil | Inisial jika tanpa foto | - | Foto gagal dimuat → inisial | Toast "Profil diperbarui" | Izin kamera/galeri ditolak → pesan + alternatif |

## 9. Perilaku Responsif

| Kelas | Lebar | Perilaku |
|---|---|---|
| **Ponsel (utama)** | 360–480 dp | 1 kolom, nav pil bawah, margin 16, kartu penuh lebar |
| **Ponsel kecil** | < 360 dp | Margin 12; kartu mini bertumpuk; teks tidak dipotong |
| **Tablet / lipat** | 600–840 dp | Konten maks. 640 dp di tengah; Beranda 2 kolom (statistik kiri, jadwal/tugas kanan); Nilai & Jadwal master–detail bila ≥ 840 dp |
| **Desktop** | - | Di luar cakupan (aplikasi hanya Android) |

Mode lanskap diizinkan; bila tidak optimal, layar tetap bisa digulir tanpa elemen terpotong. Hormati *safe area*, *gesture navigation*, dan keyboard (sheet naik bersama keyboard).

## 10. Aksesibilitas

**Kontras (WCAG 2.1 AA):** teks biasa ≥ 4.5:1, teks besar dan komponen UI ≥ 3:1. Pasangan yang dipakai:

| Pasangan | Rasio (perkiraan) |
|---|---|
| `text-900` di `bg` | ≈ 16:1 |
| `text-600` di putih | ≈ 7.6:1 |
| `text-500` di putih | ≈ 4.8:1 |
| Putih di `primary-600` | ≈ 5.2:1 |
| `error` / `warning` / `success` di putih | ≈ 4.8 / 5.0 / 5.0 |

Verifikasi ulang saat kontras latar kaca berubah (uji di atas gradien dan di mode gelap). `accent` hanya dekoratif.

**Aturan lain**
- Status tidak hanya lewat warna: selalu ikon + teks (mis. E = badge "E · Perlu mengulang"; alpa = ikon + label).
- Grafik punya tabel/ringkasan teks alternatif; warna nilai selalu disertai label huruf.
- Target sentuh ≥ 48 dp; jarak antar-target ≥ 8 dp.
- Fokus terlihat: cincin 2 dp `primary-600` (gelap: `#60A5FA`).

**Urutan fokus:** header (kembali → judul → aksi) → konten atas ke bawah, kiri ke kanan → FAB → nav pil. Di sheet/dialog fokus terkunci di dalamnya dan kembali ke pemicu saat ditutup. Kolom form berurutan sesuai tampilan; Enter pada kolom terakhir mengirim form.

**Navigasi keyboard/eksternal & switch access:** Tab/Shift+Tab berpindah fokus, Enter/Spasi mengaktifkan, panah memilih chip/hari/tanggal di kalender, Esc menutup sheet/dialog.

**Setara ARIA di Flutter (`Semantics`):** setiap ikon-tombol punya `label`; kartu nilai dibaca "Statistika, 3 SKS, nilai B, semester 2"; `button`, `header`, `liveRegion` untuk toast/error; `selected`/`toggled` pada chip dan switch; `SlideToConfirm` wajib punya aksi semantik "Konfirmasi" (tanpa geser); kalender dibaca per tanggal beserta jumlah penanda; gambar QRIS memiliki deskripsi alt. Uji dengan TalkBack.

**Lainnya:** dukung ukuran font sistem dan "hapus animasi"; tidak ada konten berkedip; pesan error menyebut kolom dan cara memperbaiki.
