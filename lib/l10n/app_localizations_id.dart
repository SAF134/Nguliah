// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Nguliah';

  @override
  String get appTagline =>
      'Kelola nilai, jadwal, tugas, dan acara akademik dalam satu tempat.';

  @override
  String get splashLoading => 'Memuat data akademik...';

  @override
  String get navHome => 'Beranda';

  @override
  String get navGrades => 'Nilai';

  @override
  String get navSchedule => 'Jadwal';

  @override
  String get navTasks => 'Tugas';

  @override
  String get navEvents => 'Acara';

  @override
  String get screenOnboardingTitle => 'Kenali Nguliah';

  @override
  String get screenOnboardingSubtitle =>
      '4 langkah mudah mengatur kuliahmu secara offline.';

  @override
  String get onboardingSlide1Title => 'Pantau Nilai & IPK';

  @override
  String get onboardingSlide1Desc =>
      'Catat nilai tiap semester, kelola mata kuliah mengulang, dan lihat perhitungan IPS serta IPK secara akurat.';

  @override
  String get onboardingSlide2Title => 'Jadwal & Presensi Kuliah';

  @override
  String get onboardingSlide2Desc =>
      'Atur jadwal mingguan, deteksi bentrok jam kuliah, dan rekap kehadiran setiap pertemuan.';

  @override
  String get onboardingSlide3Title => 'Lacak Tugas & Tenggat';

  @override
  String get onboardingSlide3Desc =>
      'Pantau sisa waktu pengumpulan tugas lewat kalender penanda dan pengingat tepat waktu.';

  @override
  String get onboardingSlide4Title => 'Kelola Acara Kampus';

  @override
  String get onboardingSlide4Desc =>
      'Susun agenda organisasi dan kegiatan non-kuliah dalam kalender bulanan yang rapi.';

  @override
  String onboardingSlideIndicator(int current, int total) {
    return 'Slide $current dari $total';
  }

  @override
  String get slideToStartLabel => 'Geser untuk Mulai';

  @override
  String get slideToConfirmAction => 'Konfirmasi tanpa geser';

  @override
  String get screenAuthTitle => 'Profil Mahasiswa';

  @override
  String get screenAuthSubtitle =>
      'Isi biodata singkat untuk mempersonalisasi aplikasimu. Semua data tersimpan di perangkat ini.';

  @override
  String get fieldFullNameLabel => 'Nama Lengkap';

  @override
  String get fieldFullNameHint => 'Contoh: Rani Putri';

  @override
  String get fieldFullNameError =>
      'Nama lengkap wajib diisi. Masukkan minimal 2 karakter.';

  @override
  String get fieldUniversityLabel => 'Universitas / Perguruan Tinggi';

  @override
  String get fieldUniversityHint => 'Contoh: Universitas Indonesia';

  @override
  String get fieldUniversityError =>
      'Universitas wajib diisi. Masukkan nama kampusmu.';

  @override
  String get fieldFacultyLabel => 'Fakultas / Jurusan';

  @override
  String get fieldFacultyHint => 'Contoh: Fakultas Ilmu Komputer';

  @override
  String get fieldFacultyError =>
      'Fakultas wajib diisi. Masukkan nama fakultas atau jurusanmu.';

  @override
  String get fieldMajorLabel => 'Program Studi';

  @override
  String get fieldMajorHint => 'Contoh: Sistem Informasi';

  @override
  String get fieldMajorError =>
      'Program studi wajib diisi. Masukkan nama program studimu.';

  @override
  String get fieldEntryYearLabel => 'Tahun Masuk';

  @override
  String get fieldEntryYearHint => 'Pilih tahun angkatan';

  @override
  String get fieldEntryYearError =>
      'Tahun masuk wajib dipilih. Pilih tahun angkatan yang valid.';

  @override
  String get screenHomeTitle => 'Beranda';

  @override
  String get screenGradesTitle => 'Nilai Akademik';

  @override
  String get screenScheduleTitle => 'Jadwal Kuliah';

  @override
  String get screenTasksTitle => 'Tugas Kuliah';

  @override
  String get screenEventsTitle => 'Acara Kampus';

  @override
  String get screenSettingsTitle => 'Pengaturan';

  @override
  String get actionContinue => 'Lanjut';

  @override
  String get actionSkip => 'Lewati';

  @override
  String get actionStart => 'Mulai Sekarang';

  @override
  String get actionSaveAndStart => 'Simpan & Mulai';

  @override
  String get actionYes => 'Iya';

  @override
  String get actionNo => 'Tidak';

  @override
  String get actionReset => 'Reset';

  @override
  String get actionConfirm => 'Konfirmasi';

  @override
  String get actionSave => 'Simpan';

  @override
  String get actionCancel => 'Batal';

  @override
  String get actionDelete => 'Hapus';

  @override
  String get actionEdit => 'Ubah';

  @override
  String get actionUndo => 'Urungkan';

  @override
  String get actionRetake => 'Ulang';

  @override
  String get actionClose => 'Tutup';

  @override
  String get actionOpenSettings => 'Buka Pengaturan';

  @override
  String get actionRetry => 'Coba Lagi';

  @override
  String get actionAddFirstGrade => 'Tambah Nilai Pertama';

  @override
  String get actionAddGrade => 'Tambah Nilai';

  @override
  String get actionAddSchedule => 'Tambah Jadwal';

  @override
  String get actionAddTask => 'Tambah Tugas';

  @override
  String get actionAddEvent => 'Tambah Acara';

  @override
  String get actionRecordAttendance => 'Isi Presensi';

  @override
  String get actionAttendanceRecap => 'Rekap Presensi';

  @override
  String get emptyHomeTitle => 'Belum ada data akademik';

  @override
  String get emptyHomeDescription =>
      'Mulai catat nilai atau jadwal kuliahmu agar ringkasan tampil di sini.';

  @override
  String get emptyGradesTitle => 'Belum ada catatan nilai';

  @override
  String get emptyGradesDescription =>
      'Tambahkan mata kuliah dan nilai semestermu untuk menghitung IPS dan IPK otomatis.';

  @override
  String get emptyScheduleTitle => 'Belum ada jadwal';

  @override
  String get emptyScheduleDescription =>
      'Susun jadwal mingguanmu agar tidak terlewat sesi perkuliahan.';

  @override
  String get emptyTasksTitle => 'Tidak ada tugas';

  @override
  String get emptyTasksDescription =>
      'Semua tugas sudah terkendali. Tambahkan tugas baru jika ada tenggat mendatang.';

  @override
  String get emptyCompletedTasksTitle => 'Belum ada yang selesai';

  @override
  String get emptyCompletedTasksDescription =>
      'Tandai tugas aktif sebagai selesai untuk melihat riwayat rekap penyelesaian di sini.';

  @override
  String get emptyEventsTitle => 'Tidak ada acara';

  @override
  String get emptyEventsDescription =>
      'Belum ada kegiatan organisasi atau acara kampus pada tanggal terpilih.';

  @override
  String get emptySettingsDescription =>
      'Kelola profil, bahasa, konversi nilai, notifikasi, dan cadangan data.';

  @override
  String get errorLoadData => 'Gagal memuat data';

  @override
  String get permissionNotificationDeniedBanner =>
      'Izin notifikasi ditolak. Aktifkan di pengaturan agar pengingat tampil tepat waktu.';

  @override
  String get statIpkLabel => 'IPK Kumulatif';

  @override
  String statIpsSemesterLabel(int semester) {
    return 'IPS $semester';
  }

  @override
  String get statCompletedSksLabel => 'SKS Selesai';

  @override
  String get statCompletedCoursesLabel => 'MK Selesai';

  @override
  String get filterAllSemesters => 'Semua';

  @override
  String semesterLabel(int semester) {
    return 'Semester $semester';
  }

  @override
  String semesterShortLabel(int semester) {
    return 'Sem $semester';
  }

  @override
  String sksUnit(int sks) {
    return '$sks SKS';
  }

  @override
  String get gradeNeedsRetake => 'Perlu mengulang';

  @override
  String get gradeRetakeBadge => 'Perbaikan';

  @override
  String get gradeUsedInIpk => 'Dipakai di IPK';

  @override
  String get gradeNotUsedInIpk => 'Riwayat (tidak dipakai di IPK)';

  @override
  String gradeRetakeOfInfo(int semester, String gradeIndex) {
    return 'Mengulang dari Sem $semester ($gradeIndex)';
  }

  @override
  String get gradeFormAddTitle => 'Tambah Nilai';

  @override
  String get gradeFormEditTitle => 'Ubah Nilai';

  @override
  String get gradeFieldCourseNameLabel => 'Nama Mata Kuliah';

  @override
  String get gradeFieldCourseNameHint => 'Contoh: Statistika Dasar';

  @override
  String get gradeFieldCourseNameError =>
      'Nama mata kuliah wajib diisi. Masukkan nama mata kuliah.';

  @override
  String get gradeFieldSemesterLabel => 'Semester (1–14)';

  @override
  String get gradeFieldSemesterError =>
      'Semester tidak valid. Pilih semester antara 1 hingga 14.';

  @override
  String get gradeFieldSksLabel => 'Jumlah SKS';

  @override
  String get gradeFieldSksHint => 'Contoh: 3';

  @override
  String get gradeFieldSksError =>
      'SKS tidak valid. Masukkan angka SKS lebih dari 0.';

  @override
  String get gradeFieldIndexLabel => 'Indeks Nilai';

  @override
  String get gradeFieldRetakeLabel => 'Mengulang / Perbaikan dari (Opsional)';

  @override
  String get gradeRetakeNoneOption => 'Bukan mengulang (MK baru)';

  @override
  String gradeRetakeSuggestionBanner(
    String courseName,
    int semester,
    String gradeIndex,
  ) {
    return 'Ditemukan MK \"$courseName\" di Semester $semester (nilai $gradeIndex). Tautkan sebagai mengulang?';
  }

  @override
  String get gradeRetakeLinkAction => 'Tautkan';

  @override
  String get gradeDeleteDialogTitle => 'Hapus Nilai Mata Kuliah?';

  @override
  String gradeDeleteDialogMessage(String courseName, int semester) {
    return 'Entri \"$courseName\" (Semester $semester) akan dihapus dan IPK akan dihitung ulang.';
  }

  @override
  String get toastGradeSaved => 'Nilai tersimpan';

  @override
  String get toastGradeDeleted => 'Nilai dihapus';

  @override
  String semanticsCourseGradeCard(
    String courseName,
    int sks,
    String gradeIndex,
    int semester,
  ) {
    return '$courseName, $sks SKS, nilai $gradeIndex, semester $semester';
  }

  @override
  String semanticsGradeIndexOption(String gradeIndex) {
    return 'Indeks nilai $gradeIndex';
  }

  @override
  String get dayAll => 'Semua';

  @override
  String get dayMonday => 'Senin';

  @override
  String get dayTuesday => 'Selasa';

  @override
  String get dayWednesday => 'Rabu';

  @override
  String get dayThursday => 'Kamis';

  @override
  String get dayFriday => 'Jumat';

  @override
  String get daySaturday => 'Sabtu';

  @override
  String get daySunday => 'Minggu';

  @override
  String get dayShortMon => 'Sen';

  @override
  String get dayShortTue => 'Sel';

  @override
  String get dayShortWed => 'Rab';

  @override
  String get dayShortThu => 'Kam';

  @override
  String get dayShortFri => 'Jum';

  @override
  String get dayShortSat => 'Sab';

  @override
  String get dayShortSun => 'Min';

  @override
  String get scheduleFormAddTitle => 'Tambah Jadwal Kuliah';

  @override
  String get scheduleFormEditTitle => 'Ubah Jadwal Kuliah';

  @override
  String get scheduleFieldDayLabel => 'Hari Kuliah';

  @override
  String get scheduleFieldStartTimeLabel => 'Jam Mulai';

  @override
  String get scheduleFieldStartTimeHint => '08:00';

  @override
  String get scheduleFieldEndTimeLabel => 'Jam Selesai';

  @override
  String get scheduleFieldEndTimeHint => '10:00';

  @override
  String get scheduleFieldTimeFormatError =>
      'Format jam tidak valid. Gunakan format JJ:MM (contoh 08:30).';

  @override
  String get scheduleFieldEndTimeError =>
      'Jam selesai harus lebih besar dari jam mulai.';

  @override
  String get scheduleFieldRoomLabel => 'Ruangan';

  @override
  String get scheduleFieldRoomHint => 'Contoh: Gedung A R.302';

  @override
  String get scheduleFieldRoomError =>
      'Ruangan wajib diisi. Masukkan nama atau kode ruangan.';

  @override
  String scheduleConflictWarning(String courseName, String timeRange) {
    return 'Jadwal bentrok dengan \"$courseName\" ($timeRange). Kamu tetap bisa menyimpan jadwal ini.';
  }

  @override
  String get scheduleDeleteDialogTitle => 'Hapus Jadwal Kuliah?';

  @override
  String scheduleDeleteDialogMessage(String courseName, String dayName) {
    return 'Jadwal \"$courseName\" ($dayName) akan dihapus.';
  }

  @override
  String get toastScheduleSaved => 'Jadwal tersimpan';

  @override
  String get toastScheduleDeleted => 'Jadwal dihapus';

  @override
  String get attendanceSheetTitle => 'Presensi Kuliah';

  @override
  String get attendanceDateLabel => 'Tanggal Pertemuan';

  @override
  String get attendanceStatusLabel => 'Status Kehadiran';

  @override
  String get attendanceStatusPresent => 'Hadir';

  @override
  String get attendanceStatusSick => 'Sakit';

  @override
  String get attendanceStatusPermission => 'Izin';

  @override
  String get attendanceStatusAbsent => 'Alfa';

  @override
  String get attendanceNotesLabel => 'Keterangan / Catatan Pertemuan';

  @override
  String get attendanceNotesHint => 'Contoh: Membahas materi Bab 3';

  @override
  String get attendanceRecordedAtInfo => 'Dicatat otomatis saat disimpan';

  @override
  String get toastAttendanceSaved => 'Presensi tersimpan';

  @override
  String get attendanceRecapTitle => 'Rekap Kehadiran per MK';

  @override
  String get attendanceRecapEmpty => 'Belum ada catatan presensi kuliah.';

  @override
  String attendanceRecapSummary(
    int presentCount,
    int totalCount,
    String percentage,
  ) {
    return '$presentCount Hadir dari $totalCount sesi ($percentage%)';
  }

  @override
  String attendanceRecapBreakdown(
    int present,
    int sick,
    int permission,
    int absent,
  ) {
    return 'Hadir: $present · Sakit: $sick · Izin: $permission · Alfa: $absent';
  }

  @override
  String semanticsScheduleCard(
    String courseName,
    String dayName,
    String timeRange,
    String room,
  ) {
    return '$courseName, $dayName pukul $timeRange, ruangan $room';
  }

  @override
  String get calendarPrevMonth => 'Bulan sebelumnya';

  @override
  String get calendarNextMonth => 'Bulan berikutnya';

  @override
  String get calendarClearDateFilter => 'Tampilkan semua tanggal';

  @override
  String semanticsCalendarDayMarkers(int day, int month, int year, int count) {
    return 'Tanggal $day/$month/$year, $count penanda';
  }

  @override
  String get taskTabActive => 'Aktif';

  @override
  String get taskTabCompleted => 'Selesai (Rekap)';

  @override
  String get taskFormAddTitle => 'Tambah Tugas Kuliah';

  @override
  String get taskFormEditTitle => 'Ubah Tugas Kuliah';

  @override
  String get taskFieldDescriptionLabel => 'Deskripsi Tugas';

  @override
  String get taskFieldDescriptionHint => 'Contoh: Laporan Praktikum Modul 2';

  @override
  String get taskFieldDescriptionError =>
      'Deskripsi tugas wajib diisi. Masukkan deskripsi singkat tugas.';

  @override
  String get taskFieldDueDateLabel => 'Tanggal Tenggat';

  @override
  String get taskFieldDueDateHint => '2026-11-05';

  @override
  String get taskFieldDueDateError =>
      'Format tanggal tidak valid. Gunakan format TTTT-BB-HH.';

  @override
  String get taskFieldDueTimeLabel => 'Jam Tenggat';

  @override
  String get taskFieldDueTimeHint => '23:59';

  @override
  String get taskStatusOverdue => 'Terlambat';

  @override
  String taskStatusUrgentHours(int hours) {
    return 'Mendesak · $hours jam lagi';
  }

  @override
  String taskStatusRemainingDays(int days) {
    return '$days hari lagi';
  }

  @override
  String taskCompletedAtLabel(String dateTime) {
    return 'Selesai pada $dateTime';
  }

  @override
  String get taskMarkComplete => 'Tandai tugas selesai';

  @override
  String get taskUnmarkComplete => 'Batalkan tanda selesai';

  @override
  String get taskDeleteDialogTitle => 'Hapus Tugas Kuliah?';

  @override
  String taskDeleteDialogMessage(String courseName) {
    return 'Tugas \"$courseName\" akan dihapus.';
  }

  @override
  String get toastTaskSaved => 'Tugas tersimpan';

  @override
  String get toastTaskCompleted => 'Tugas selesai';

  @override
  String get toastTaskUncompleted => 'Tugas dikembalikan ke daftar aktif';

  @override
  String get toastTaskDeleted => 'Tugas dihapus';

  @override
  String get eventFormAddTitle => 'Tambah Acara Kampus';

  @override
  String get eventFormEditTitle => 'Ubah Acara Kampus';

  @override
  String get eventFieldNameLabel => 'Nama Acara';

  @override
  String get eventFieldNameHint => 'Contoh: Rapat Himpunan Mahasiswa';

  @override
  String get eventFieldNameError =>
      'Nama acara wajib diisi. Masukkan nama acara.';

  @override
  String get eventFieldDescriptionLabel => 'Deskripsi Acara';

  @override
  String get eventFieldDescriptionHint =>
      'Contoh: Pembahasan program kerja semester ini';

  @override
  String get eventFieldDescriptionError =>
      'Deskripsi acara wajib diisi. Masukkan deskripsi acara.';

  @override
  String get eventFieldDateLabel => 'Tanggal Acara';

  @override
  String get eventFieldDateHint => '2026-11-10';

  @override
  String get eventDeleteDialogTitle => 'Hapus Acara?';

  @override
  String eventDeleteDialogMessage(String eventName) {
    return 'Acara \"$eventName\" akan dihapus.';
  }

  @override
  String get toastEventSaved => 'Acara tersimpan';

  @override
  String get toastEventDeleted => 'Acara dihapus';

  @override
  String get semanticsLoading => 'Sedang memuat';

  @override
  String get semanticsOpenSettings => 'Buka Pengaturan Profil dan Aplikasi';

  @override
  String homeGreeting(String name) {
    return 'Halo, $name!';
  }

  @override
  String get homeDefaultStudentName => 'Mahasiswa';

  @override
  String get homeTodayScheduleTitle => 'Jadwal Hari Ini';

  @override
  String get homeTodayScheduleEmpty => 'Tidak ada jadwal kuliah hari ini.';

  @override
  String get homeWeekTasksTitle => 'Tugas 7 Hari ke Depan';

  @override
  String get homeWeekTasksEmpty =>
      'Tidak ada tenggat tugas dalam 7 hari ke depan.';

  @override
  String get homeIpsTrendTitle => 'Tren IPS per Semester';

  @override
  String get homeIpsTrendEmpty =>
      'Tambahkan nilai untuk melihat grafik tren IPS.';

  @override
  String get homeGradeDistributionTitle => 'Sebaran Nilai';

  @override
  String get homeGradeDistributionEmpty =>
      'Belum ada sebaran nilai yang tercatat.';

  @override
  String get homeChartTableSummaryLabel => 'Ringkasan Teks Grafik';

  @override
  String get actionExport => 'Ekspor';

  @override
  String get exportSheetTitle => 'Ekspor Dokumen / Gambar';

  @override
  String get exportScopeLabel => 'Cakupan Data';

  @override
  String get exportScopeHomeStats => 'Statistik Beranda (IPK & Sebaran Nilai)';

  @override
  String get exportScopeAllGrades => 'Transkrip Nilai Semua Semester & IPK';

  @override
  String get exportScopeScheduleAttendance =>
      'Jadwal Mingguan & Rekap Presensi';

  @override
  String get exportFormatLabel => 'Format Berkas';

  @override
  String get exportFormatPdf => 'PDF';

  @override
  String get exportFormatPng => 'PNG (Gambar)';

  @override
  String get exportFormatJpg => 'JPG';

  @override
  String get exportGenerateAndShare => 'Ekspor';

  @override
  String get exportProgressLoading => 'Membuat berkas ekspor...';

  @override
  String get toastExportSuccess => 'Berkas ekspor siap dibagikan';

  @override
  String get errorExportFailed => 'Gagal membuat berkas ekspor';

  @override
  String get settingsGroupAccount => 'Akun & Profil';

  @override
  String get settingsGroupPreferences => 'Preferensi Akademik';

  @override
  String get settingsGroupData => 'Pengingat & Data Lokal';

  @override
  String get settingsGroupAbout => 'Tentang & Dukungan';

  @override
  String get settingsEditProfileTitle => 'Profil Mahasiswa';

  @override
  String get settingsEditProfileSubtitle =>
      'Ubah biodata dan foto profil lokal';

  @override
  String get settingsPickPhotoGallery => 'Pilih dari Galeri';

  @override
  String get settingsPickPhotoCamera => 'Ambil Foto Kamera';

  @override
  String get settingsRemovePhoto => 'Hapus Foto';

  @override
  String get toastProfileUpdated => 'Profil diperbarui';

  @override
  String get settingsLanguageTitle => 'Bahasa Aplikasi';

  @override
  String get settingsLanguageIndonesian => 'Indonesia';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get toastLanguageChanged => 'Bahasa berhasil diubah';

  @override
  String get settingsConversionTitle => 'Konversi Nilai';

  @override
  String get settingsConversionSubtitle =>
      'Bobot indeks nilai dan kustomisasi konversi';

  @override
  String get settingsMinPassingGradeLabel => 'Nilai Lulus Minimum';

  @override
  String get settingsRetakeRuleLabel => 'Aturan Nilai Mengulang (IPK)';

  @override
  String get settingsRetakeRuleHighest => 'Nilai Tertinggi (Default)';

  @override
  String get settingsRetakeRuleLatest => 'Nilai Terbaru';

  @override
  String get settingsResetConversion => 'Reset';

  @override
  String get toastConversionSaved =>
      'Aturan konversi disimpan & IPK dihitung ulang';

  @override
  String get settingsFormulaGuideTitle => 'Panduan Rumus IPS & IPK';

  @override
  String get settingsFormulaGuideSubtitle =>
      'Penjelasan perhitungan nilai dan kasus mengulang';

  @override
  String get formulaGuideBody =>
      '1. IPS bersifat historis: Σ(bobot × SKS) / Σ SKS dari semua entri pada semester tersebut (termasuk nilai E dan perbaikan).\n\n2. IPK Kumulatif: Σ(bobot × SKS) / Σ SKS dari satu entri terpakai per kelompok mata kuliah (nilai tertinggi secara default, atau nilai terbaru).\n\n3. Nilai E selalu wajib mengulang (tidak lulus). Sebelum diulang, nilai E tetap masuk pembagi IPK (bobot 0). Setelah diulang, nilai baru menggantikan nilai E di IPK, sementara IPS semester lama tidak berubah.\n\n4. SKS Selesai dan MK Selesai hanya menghitung kelompok MK yang entri terpakainya lulus (≥ nilai lulus minimum).';

  @override
  String get settingsNotificationsTitle => 'Pengingat & Notifikasi';

  @override
  String get settingsNotificationsSubtitle =>
      'Atur pengingat jadwal, tugas, dan acara';

  @override
  String get settingsNotifyScheduleLabel => 'Pengingat Jadwal Kuliah';

  @override
  String get settingsNotifyTaskLabel => 'Pengingat Tenggat Tugas';

  @override
  String get settingsNotifyEventLabel => 'Pengingat Acara Kampus';

  @override
  String settingsReminderOffsetMinutes(int minutes) {
    return '$minutes menit sebelum';
  }

  @override
  String get toastNotificationsSaved => 'Pengaturan notifikasi disimpan';

  @override
  String get settingsBackupTitle => 'Backup & Restore Data';

  @override
  String get settingsBackupSubtitle =>
      'Cadangkan atau pulihkan seluruh data JSON (Offline)';

  @override
  String get backupNeverInfo => 'Belum pernah melakukan backup';

  @override
  String backupLastAtInfo(String dateTime) {
    return 'Backup terakhir: $dateTime';
  }

  @override
  String get backupGuideBody =>
      'Simpan berkas JSON backup di folder aman atau penyimpanan cloud pribadimu. Saat ganti perangkat, pilih berkas tersebut lewat menu Restore.';

  @override
  String get actionCreateBackup => 'Buat Backup JSON';

  @override
  String get actionRestoreBackup => 'Pilih File & Restore';

  @override
  String get restoreConfirmTitle => 'Pulihkan Data dari Backup?';

  @override
  String get restoreConfirmDescription =>
      'Seluruh data lokal saat ini akan diganti dengan isi berkas backup. Geser untuk mengonfirmasi pemulihan.';

  @override
  String get slideToRestoreLabel => 'Geser untuk Restore';

  @override
  String get toastBackupCreated => 'Backup berhasil dibuat';

  @override
  String get toastRestoreSuccess =>
      'Restore berhasil. Seluruh data telah dipulihkan.';

  @override
  String get errorBackupInvalid =>
      'File tidak valid atau versi skema tidak cocok. Data lama tetap aman.';

  @override
  String get settingsAboutAppTitle => 'Tentang Aplikasi';

  @override
  String get settingsAboutAppSubtitle =>
      'Versi 1.0.0 · Lisensi MIT · Open Source';

  @override
  String get aboutAppDescription =>
      'Nguliah adalah aplikasi Android offline-first bebas iklan untuk membantu mahasiswa mengelola nilai, jadwal, presensi, tugas, dan acara kampus secara mandiri.';

  @override
  String get aboutAppLicenseLabel =>
      'Lisensi: MIT License (Repositori GitHub Publik)';

  @override
  String get settingsAboutDevTitle => 'Tentang Pengembang & Dukungan';

  @override
  String get settingsAboutDevSubtitle =>
      'Profil pengembang & dukungan sukarela (QRIS)';

  @override
  String get aboutDevDescription =>
      'Dikembangkan secara terbuka untuk mahasiswa Indonesia. Jika aplikasi ini membantumu, kamu dapat memberikan dukungan sukarela melalui QRIS di bawah ini.';

  @override
  String get qrisCardTitle => 'Dukung lewat QRIS (Buy Me a Coffee)';

  @override
  String get semanticsQrisImage =>
      'Gambar kode pembayaran QRIS statis untuk mendukung pengembang Nguliah';

  @override
  String get permissionMediaDeniedBanner =>
      'Izin kamera/galeri ditolak. Gunakan inisial profil atau aktifkan izin di Pengaturan Sistem.';

  @override
  String get permissionStorageDeniedBanner =>
      'Izin penyimpanan/pemilih berkas ditolak. Aktifkan izin di Pengaturan Sistem untuk melanjutkan.';

  @override
  String get authRestoreOption => 'Sudah punya backup? Pulihkan Data';

  @override
  String get homeUpcomingEventsTitle => 'Acara 7 Hari ke Depan';

  @override
  String get homeUpcomingEventsEmpty =>
      'Tidak ada acara kampus dalam 7 hari ke depan.';

  @override
  String get homeChartToggleBar => 'Diagram Batang';

  @override
  String get homeChartTogglePie => 'Pie Chart (%)';

  @override
  String get attendanceStatusDispensation => 'Dispen';

  @override
  String attendanceRestrictedOutsideClass(String timeRange) {
    return 'Presensi hanya dapat diisi saat jam KBM berlangsung ($timeRange). Di luar jam ini dicatat sebagai Alfa.';
  }

  @override
  String get attendanceCountMeetingsLabel => 'Jumlah Pertemuan';

  @override
  String get attendanceCountPresentLabel => 'Jumlah Kehadiran';

  @override
  String get attendancePercentageLabel => 'Persentase Kehadiran';

  @override
  String get attendanceSlideToConfirmEdit => 'Geser untuk Simpan Perubahan';

  @override
  String get taskConfirmCompleteTitle => 'Tandai Tugas Selesai?';

  @override
  String taskConfirmCompleteMessage(String taskTitle) {
    return 'Tugas \"$taskTitle\" akan dipindahkan ke daftar selesai.';
  }

  @override
  String get taskConfirmUncompleteTitle => 'Kembalikan Status Tugas?';

  @override
  String taskConfirmUncompleteMessage(String taskTitle) {
    return 'Tugas \"$taskTitle\" akan dikembalikan ke daftar aktif.';
  }

  @override
  String get eventTabActive => 'Acara Aktif';

  @override
  String get eventTabCompleted => 'Selesai (Rekap)';

  @override
  String get eventFieldLocationLabel => 'Lokasi Acara';

  @override
  String get eventFieldLocationHint => 'Contoh: Gedung B R.201 / Zoom';

  @override
  String get settingsThemeModeTitle => 'Mode Tema';

  @override
  String get settingsThemeModeLight => 'Terang';

  @override
  String get settingsThemeModeDark => 'Gelap';

  @override
  String get settingsCustomReminderMinutesLabel =>
      'Waktu Pengingat (Menit Sebelum)';

  @override
  String get settingsCustomReminderMinutesHint => 'Contoh: 30';

  @override
  String get toastDeviceNotificationActive => 'Izin notifikasi perangkat aktif';

  @override
  String get toastDeviceNotificationDenied =>
      'Izin notifikasi perangkat ditolak/belum diaktifkan';

  @override
  String get settingsEnableDeviceNotification => 'Notifikasi Perangkat';

  @override
  String get settingsEnableDeviceNotificationSubtitle =>
      'Kelola izin dan setelan notifikasi sistem';

  @override
  String get settingsOpenSystemSettings => 'Buka Setelan Notifikasi Sistem';

  @override
  String get settingsLogoutTitle => 'Keluar Akun';

  @override
  String get settingsLogoutSubtitle =>
      'Hapus sesi profil dan kembali ke layar Masuk';

  @override
  String get settingsLogoutDialogTitle => 'Keluar dari Akun?';

  @override
  String get settingsLogoutDialogMessage =>
      'Data akademik tetap tersimpan di perangkat. Anda akan diarahkan kembali ke layar Masuk.';

  @override
  String get settingsAddGradeConversion => 'Tambah Indeks Nilai';

  @override
  String get settingsGradeIndexLabel => 'Indeks Huruf';

  @override
  String get settingsGradeIndexHint => 'Contoh: A-';

  @override
  String get settingsGradeWeightLabel => 'Bobot';

  @override
  String get settingsGradeWeightHint => 'Contoh: 3.75';

  @override
  String get settingsDeleteGradeIndexTitle => 'Hapus Indeks Nilai?';

  @override
  String settingsDeleteGradeIndexMessage(String index) {
    return 'Indeks \"$index\" akan dihapus dari aturan konversi.';
  }

  @override
  String get settingsDeveloperPhotoGuide =>
      'Letakkan foto profil pengembang di assets/images/developer.png dan foto QRIS di assets/images/qris.png';

  @override
  String get settingsExportSectionTitle => 'Ekspor Dokumen & Data';

  @override
  String get settingsExportStatsTitle => 'Ekspor Statistik & IPK';

  @override
  String get settingsExportGradesTitle =>
      'Ekspor Transkrip Nilai (Semua Semester)';

  @override
  String get settingsExportScheduleTitle => 'Ekspor Jadwal & Rekap Presensi';

  @override
  String get gradeFormSlideDropdownHint => 'Pilih Indeks Nilai';

  @override
  String get gradeFieldSemesterTypedHint => '1 - 14';

  @override
  String get gradesIpkTitle => 'IPK';

  @override
  String get gradesCompletedSksTitle => 'SKS Selesai';

  @override
  String get gradesCompletedCoursesTitle => 'MK Selesai';

  @override
  String get taskCancelConfirmTitle => 'Batalkan Penyelesaian Tugas?';

  @override
  String get taskCompleteConfirmTitle => 'Selesaikan Tugas Kuliah?';

  @override
  String get taskCancelConfirmMessage =>
      'Status tugas ini akan diubah kembali menjadi aktif.';

  @override
  String get taskCompleteConfirmMessage =>
      'Apakah tugas ini sudah selesai Anda kerjakan?';

  @override
  String get fieldRequired => 'Bidang ini wajib diisi';

  @override
  String get attendanceMeetingHistoryTitle => 'Detail Pertemuan Kuliah';

  @override
  String get attendanceOutsideHoursWarning =>
      'Presensi di luar jam perkuliahan otomatis dicatat sebagai Alfa.';

  @override
  String get settingsEditGradeConversion => 'Ubah Indeks Nilai';

  @override
  String get taskActionUncomplete => 'Batalkan Selesai';

  @override
  String get emptyCompletedEventsTitle => 'Belum ada acara selesai';

  @override
  String get emptyCompletedEventsDescription =>
      'Belum ada rekapan acara kampus yang telah selesai.';

  @override
  String get settingsHideScoresTitle => 'Sembunyikan Nilai Akademik';

  @override
  String get settingsHideScoresSubtitle =>
      'Sensor IPK, IPS, SKS, dan MK selesai dengan tanda bintang *';

  @override
  String get settingsConfirmSaveConversionTitle => 'Simpan Konversi Nilai?';

  @override
  String get settingsConfirmSaveConversionMessage =>
      'Perubahan konversi nilai akan mempengaruhi perhitungan IPK dan IPS. Simpan sekarang?';

  @override
  String get settingsConfirmDeleteConversionTitle => 'Hapus Indeks Nilai?';

  @override
  String get settingsConfirmDeleteConversionMessage =>
      'Apakah Anda yakin ingin menghapus indeks nilai ini dari daftar konversi?';

  @override
  String get shortIpsLabel => 'IPS';

  @override
  String get shortIpkLabel => 'IPK';
}
