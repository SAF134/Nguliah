import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In id, this message translates to:
  /// **'Nguliah'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In id, this message translates to:
  /// **'Kelola nilai, jadwal, tugas, dan acara akademik dalam satu tempat.'**
  String get appTagline;

  /// No description provided for @splashLoading.
  ///
  /// In id, this message translates to:
  /// **'Memuat data akademik...'**
  String get splashLoading;

  /// No description provided for @navHome.
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get navHome;

  /// No description provided for @navGrades.
  ///
  /// In id, this message translates to:
  /// **'Nilai'**
  String get navGrades;

  /// No description provided for @navSchedule.
  ///
  /// In id, this message translates to:
  /// **'Jadwal'**
  String get navSchedule;

  /// No description provided for @navTasks.
  ///
  /// In id, this message translates to:
  /// **'Tugas'**
  String get navTasks;

  /// No description provided for @navEvents.
  ///
  /// In id, this message translates to:
  /// **'Acara'**
  String get navEvents;

  /// No description provided for @screenOnboardingTitle.
  ///
  /// In id, this message translates to:
  /// **'Kenali Nguliah'**
  String get screenOnboardingTitle;

  /// No description provided for @screenOnboardingSubtitle.
  ///
  /// In id, this message translates to:
  /// **'4 langkah mudah mengatur kuliahmu secara offline.'**
  String get screenOnboardingSubtitle;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In id, this message translates to:
  /// **'Pantau Nilai & IPK'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Desc.
  ///
  /// In id, this message translates to:
  /// **'Catat nilai tiap semester, kelola mata kuliah mengulang, dan lihat perhitungan IPS serta IPK secara akurat.'**
  String get onboardingSlide1Desc;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In id, this message translates to:
  /// **'Jadwal & Presensi Kuliah'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Desc.
  ///
  /// In id, this message translates to:
  /// **'Atur jadwal mingguan, deteksi bentrok jam kuliah, dan rekap kehadiran setiap pertemuan.'**
  String get onboardingSlide2Desc;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In id, this message translates to:
  /// **'Lacak Tugas & Tenggat'**
  String get onboardingSlide3Title;

  /// No description provided for @onboardingSlide3Desc.
  ///
  /// In id, this message translates to:
  /// **'Pantau sisa waktu pengumpulan tugas lewat kalender penanda dan pengingat tepat waktu.'**
  String get onboardingSlide3Desc;

  /// No description provided for @onboardingSlide4Title.
  ///
  /// In id, this message translates to:
  /// **'Kelola Acara Kampus'**
  String get onboardingSlide4Title;

  /// No description provided for @onboardingSlide4Desc.
  ///
  /// In id, this message translates to:
  /// **'Susun agenda organisasi dan kegiatan non-kuliah dalam kalender bulanan yang rapi.'**
  String get onboardingSlide4Desc;

  /// No description provided for @onboardingSlideIndicator.
  ///
  /// In id, this message translates to:
  /// **'Slide {current} dari {total}'**
  String onboardingSlideIndicator(int current, int total);

  /// No description provided for @slideToStartLabel.
  ///
  /// In id, this message translates to:
  /// **'Geser untuk Mulai'**
  String get slideToStartLabel;

  /// No description provided for @slideToConfirmAction.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi tanpa geser'**
  String get slideToConfirmAction;

  /// No description provided for @screenAuthTitle.
  ///
  /// In id, this message translates to:
  /// **'Profil Mahasiswa'**
  String get screenAuthTitle;

  /// No description provided for @screenAuthSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Isi biodata singkat untuk mempersonalisasi aplikasimu. Semua data tersimpan di perangkat ini.'**
  String get screenAuthSubtitle;

  /// No description provided for @fieldFullNameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama Lengkap'**
  String get fieldFullNameLabel;

  /// No description provided for @fieldFullNameHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Rani Putri'**
  String get fieldFullNameHint;

  /// No description provided for @fieldFullNameError.
  ///
  /// In id, this message translates to:
  /// **'Nama lengkap wajib diisi. Masukkan minimal 2 karakter.'**
  String get fieldFullNameError;

  /// No description provided for @fieldUniversityLabel.
  ///
  /// In id, this message translates to:
  /// **'Universitas / Perguruan Tinggi'**
  String get fieldUniversityLabel;

  /// No description provided for @fieldUniversityHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Universitas Indonesia'**
  String get fieldUniversityHint;

  /// No description provided for @fieldUniversityError.
  ///
  /// In id, this message translates to:
  /// **'Universitas wajib diisi. Masukkan nama kampusmu.'**
  String get fieldUniversityError;

  /// No description provided for @fieldFacultyLabel.
  ///
  /// In id, this message translates to:
  /// **'Fakultas / Jurusan'**
  String get fieldFacultyLabel;

  /// No description provided for @fieldFacultyHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Fakultas Ilmu Komputer'**
  String get fieldFacultyHint;

  /// No description provided for @fieldFacultyError.
  ///
  /// In id, this message translates to:
  /// **'Fakultas wajib diisi. Masukkan nama fakultas atau jurusanmu.'**
  String get fieldFacultyError;

  /// No description provided for @fieldMajorLabel.
  ///
  /// In id, this message translates to:
  /// **'Program Studi'**
  String get fieldMajorLabel;

  /// No description provided for @fieldMajorHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Sistem Informasi'**
  String get fieldMajorHint;

  /// No description provided for @fieldMajorError.
  ///
  /// In id, this message translates to:
  /// **'Program studi wajib diisi. Masukkan nama program studimu.'**
  String get fieldMajorError;

  /// No description provided for @fieldEntryYearLabel.
  ///
  /// In id, this message translates to:
  /// **'Tahun Masuk'**
  String get fieldEntryYearLabel;

  /// No description provided for @fieldEntryYearHint.
  ///
  /// In id, this message translates to:
  /// **'Pilih tahun angkatan'**
  String get fieldEntryYearHint;

  /// No description provided for @fieldEntryYearError.
  ///
  /// In id, this message translates to:
  /// **'Tahun masuk wajib dipilih. Pilih tahun angkatan yang valid.'**
  String get fieldEntryYearError;

  /// No description provided for @screenHomeTitle.
  ///
  /// In id, this message translates to:
  /// **'Beranda'**
  String get screenHomeTitle;

  /// No description provided for @screenGradesTitle.
  ///
  /// In id, this message translates to:
  /// **'Nilai Akademik'**
  String get screenGradesTitle;

  /// No description provided for @screenScheduleTitle.
  ///
  /// In id, this message translates to:
  /// **'Jadwal Kuliah'**
  String get screenScheduleTitle;

  /// No description provided for @screenTasksTitle.
  ///
  /// In id, this message translates to:
  /// **'Tugas Kuliah'**
  String get screenTasksTitle;

  /// No description provided for @screenEventsTitle.
  ///
  /// In id, this message translates to:
  /// **'Acara Kampus'**
  String get screenEventsTitle;

  /// No description provided for @screenSettingsTitle.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get screenSettingsTitle;

  /// No description provided for @actionContinue.
  ///
  /// In id, this message translates to:
  /// **'Lanjut'**
  String get actionContinue;

  /// No description provided for @actionSkip.
  ///
  /// In id, this message translates to:
  /// **'Lewati'**
  String get actionSkip;

  /// No description provided for @actionStart.
  ///
  /// In id, this message translates to:
  /// **'Mulai Sekarang'**
  String get actionStart;

  /// No description provided for @actionSaveAndStart.
  ///
  /// In id, this message translates to:
  /// **'Simpan & Mulai'**
  String get actionSaveAndStart;

  /// No description provided for @actionYes.
  ///
  /// In id, this message translates to:
  /// **'Iya'**
  String get actionYes;

  /// No description provided for @actionNo.
  ///
  /// In id, this message translates to:
  /// **'Tidak'**
  String get actionNo;

  /// No description provided for @actionReset.
  ///
  /// In id, this message translates to:
  /// **'Reset'**
  String get actionReset;

  /// No description provided for @actionConfirm.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi'**
  String get actionConfirm;

  /// No description provided for @actionSave.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In id, this message translates to:
  /// **'Hapus'**
  String get actionDelete;

  /// No description provided for @actionEdit.
  ///
  /// In id, this message translates to:
  /// **'Ubah'**
  String get actionEdit;

  /// No description provided for @actionUndo.
  ///
  /// In id, this message translates to:
  /// **'Urungkan'**
  String get actionUndo;

  /// No description provided for @actionRetake.
  ///
  /// In id, this message translates to:
  /// **'Ulang'**
  String get actionRetake;

  /// No description provided for @actionClose.
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get actionClose;

  /// No description provided for @actionOpenSettings.
  ///
  /// In id, this message translates to:
  /// **'Buka Pengaturan'**
  String get actionOpenSettings;

  /// No description provided for @actionRetry.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get actionRetry;

  /// No description provided for @actionAddFirstGrade.
  ///
  /// In id, this message translates to:
  /// **'Tambah Nilai Pertama'**
  String get actionAddFirstGrade;

  /// No description provided for @actionAddGrade.
  ///
  /// In id, this message translates to:
  /// **'Tambah Nilai'**
  String get actionAddGrade;

  /// No description provided for @actionAddSchedule.
  ///
  /// In id, this message translates to:
  /// **'Tambah Jadwal'**
  String get actionAddSchedule;

  /// No description provided for @actionAddTask.
  ///
  /// In id, this message translates to:
  /// **'Tambah Tugas'**
  String get actionAddTask;

  /// No description provided for @actionAddEvent.
  ///
  /// In id, this message translates to:
  /// **'Tambah Acara'**
  String get actionAddEvent;

  /// No description provided for @actionRecordAttendance.
  ///
  /// In id, this message translates to:
  /// **'Isi Presensi'**
  String get actionRecordAttendance;

  /// No description provided for @actionAttendanceRecap.
  ///
  /// In id, this message translates to:
  /// **'Rekap Presensi'**
  String get actionAttendanceRecap;

  /// No description provided for @emptyHomeTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada data akademik'**
  String get emptyHomeTitle;

  /// No description provided for @emptyHomeDescription.
  ///
  /// In id, this message translates to:
  /// **'Mulai catat nilai atau jadwal kuliahmu agar ringkasan tampil di sini.'**
  String get emptyHomeDescription;

  /// No description provided for @emptyGradesTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada catatan nilai'**
  String get emptyGradesTitle;

  /// No description provided for @emptyGradesDescription.
  ///
  /// In id, this message translates to:
  /// **'Tambahkan mata kuliah dan nilai semestermu untuk menghitung IPS dan IPK otomatis.'**
  String get emptyGradesDescription;

  /// No description provided for @emptyScheduleTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada jadwal'**
  String get emptyScheduleTitle;

  /// No description provided for @emptyScheduleDescription.
  ///
  /// In id, this message translates to:
  /// **'Susun jadwal mingguanmu agar tidak terlewat sesi perkuliahan.'**
  String get emptyScheduleDescription;

  /// No description provided for @emptyTasksTitle.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada tugas'**
  String get emptyTasksTitle;

  /// No description provided for @emptyTasksDescription.
  ///
  /// In id, this message translates to:
  /// **'Semua tugas sudah terkendali. Tambahkan tugas baru jika ada tenggat mendatang.'**
  String get emptyTasksDescription;

  /// No description provided for @emptyCompletedTasksTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada yang selesai'**
  String get emptyCompletedTasksTitle;

  /// No description provided for @emptyCompletedTasksDescription.
  ///
  /// In id, this message translates to:
  /// **'Tandai tugas aktif sebagai selesai untuk melihat riwayat rekap penyelesaian di sini.'**
  String get emptyCompletedTasksDescription;

  /// No description provided for @emptyEventsTitle.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada acara'**
  String get emptyEventsTitle;

  /// No description provided for @emptyEventsDescription.
  ///
  /// In id, this message translates to:
  /// **'Belum ada kegiatan organisasi atau acara kampus pada tanggal terpilih.'**
  String get emptyEventsDescription;

  /// No description provided for @emptySettingsDescription.
  ///
  /// In id, this message translates to:
  /// **'Kelola profil, bahasa, konversi nilai, notifikasi, dan cadangan data.'**
  String get emptySettingsDescription;

  /// No description provided for @errorLoadData.
  ///
  /// In id, this message translates to:
  /// **'Gagal memuat data'**
  String get errorLoadData;

  /// No description provided for @permissionNotificationDeniedBanner.
  ///
  /// In id, this message translates to:
  /// **'Izin notifikasi ditolak. Aktifkan di pengaturan agar pengingat tampil tepat waktu.'**
  String get permissionNotificationDeniedBanner;

  /// No description provided for @statIpkLabel.
  ///
  /// In id, this message translates to:
  /// **'IPK Kumulatif'**
  String get statIpkLabel;

  /// No description provided for @statIpsSemesterLabel.
  ///
  /// In id, this message translates to:
  /// **'IPS {semester}'**
  String statIpsSemesterLabel(int semester);

  /// No description provided for @statCompletedSksLabel.
  ///
  /// In id, this message translates to:
  /// **'SKS Selesai'**
  String get statCompletedSksLabel;

  /// No description provided for @statCompletedCoursesLabel.
  ///
  /// In id, this message translates to:
  /// **'MK Selesai'**
  String get statCompletedCoursesLabel;

  /// No description provided for @filterAllSemesters.
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get filterAllSemesters;

  /// No description provided for @semesterLabel.
  ///
  /// In id, this message translates to:
  /// **'Semester {semester}'**
  String semesterLabel(int semester);

  /// No description provided for @semesterShortLabel.
  ///
  /// In id, this message translates to:
  /// **'Sem {semester}'**
  String semesterShortLabel(int semester);

  /// No description provided for @sksUnit.
  ///
  /// In id, this message translates to:
  /// **'{sks} SKS'**
  String sksUnit(int sks);

  /// No description provided for @gradeNeedsRetake.
  ///
  /// In id, this message translates to:
  /// **'Perlu mengulang'**
  String get gradeNeedsRetake;

  /// No description provided for @gradeRetakeBadge.
  ///
  /// In id, this message translates to:
  /// **'Perbaikan'**
  String get gradeRetakeBadge;

  /// No description provided for @gradeUsedInIpk.
  ///
  /// In id, this message translates to:
  /// **'Dipakai di IPK'**
  String get gradeUsedInIpk;

  /// No description provided for @gradeNotUsedInIpk.
  ///
  /// In id, this message translates to:
  /// **'Riwayat (tidak dipakai di IPK)'**
  String get gradeNotUsedInIpk;

  /// No description provided for @gradeRetakeOfInfo.
  ///
  /// In id, this message translates to:
  /// **'Mengulang dari Sem {semester} ({gradeIndex})'**
  String gradeRetakeOfInfo(int semester, String gradeIndex);

  /// No description provided for @gradeFormAddTitle.
  ///
  /// In id, this message translates to:
  /// **'Tambah Nilai'**
  String get gradeFormAddTitle;

  /// No description provided for @gradeFormEditTitle.
  ///
  /// In id, this message translates to:
  /// **'Ubah Nilai'**
  String get gradeFormEditTitle;

  /// No description provided for @gradeFieldCourseNameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama Mata Kuliah'**
  String get gradeFieldCourseNameLabel;

  /// No description provided for @gradeFieldCourseNameHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Statistika Dasar'**
  String get gradeFieldCourseNameHint;

  /// No description provided for @gradeFieldCourseNameError.
  ///
  /// In id, this message translates to:
  /// **'Nama mata kuliah wajib diisi. Masukkan nama mata kuliah.'**
  String get gradeFieldCourseNameError;

  /// No description provided for @gradeFieldSemesterLabel.
  ///
  /// In id, this message translates to:
  /// **'Semester (1–14)'**
  String get gradeFieldSemesterLabel;

  /// No description provided for @gradeFieldSemesterError.
  ///
  /// In id, this message translates to:
  /// **'Semester tidak valid. Pilih semester antara 1 hingga 14.'**
  String get gradeFieldSemesterError;

  /// No description provided for @gradeFieldSksLabel.
  ///
  /// In id, this message translates to:
  /// **'Jumlah SKS'**
  String get gradeFieldSksLabel;

  /// No description provided for @gradeFieldSksHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: 3'**
  String get gradeFieldSksHint;

  /// No description provided for @gradeFieldSksError.
  ///
  /// In id, this message translates to:
  /// **'SKS tidak valid. Masukkan angka SKS lebih dari 0.'**
  String get gradeFieldSksError;

  /// No description provided for @gradeFieldIndexLabel.
  ///
  /// In id, this message translates to:
  /// **'Indeks Nilai'**
  String get gradeFieldIndexLabel;

  /// No description provided for @gradeFieldRetakeLabel.
  ///
  /// In id, this message translates to:
  /// **'Mengulang / Perbaikan dari (Opsional)'**
  String get gradeFieldRetakeLabel;

  /// No description provided for @gradeRetakeNoneOption.
  ///
  /// In id, this message translates to:
  /// **'Bukan mengulang (MK baru)'**
  String get gradeRetakeNoneOption;

  /// No description provided for @gradeRetakeSuggestionBanner.
  ///
  /// In id, this message translates to:
  /// **'Ditemukan MK \"{courseName}\" di Semester {semester} (nilai {gradeIndex}). Tautkan sebagai mengulang?'**
  String gradeRetakeSuggestionBanner(
    String courseName,
    int semester,
    String gradeIndex,
  );

  /// No description provided for @gradeRetakeLinkAction.
  ///
  /// In id, this message translates to:
  /// **'Tautkan'**
  String get gradeRetakeLinkAction;

  /// No description provided for @gradeDeleteDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Nilai Mata Kuliah?'**
  String get gradeDeleteDialogTitle;

  /// No description provided for @gradeDeleteDialogMessage.
  ///
  /// In id, this message translates to:
  /// **'Entri \"{courseName}\" (Semester {semester}) akan dihapus dan IPK akan dihitung ulang.'**
  String gradeDeleteDialogMessage(String courseName, int semester);

  /// No description provided for @toastGradeSaved.
  ///
  /// In id, this message translates to:
  /// **'Nilai tersimpan'**
  String get toastGradeSaved;

  /// No description provided for @toastGradeDeleted.
  ///
  /// In id, this message translates to:
  /// **'Nilai dihapus'**
  String get toastGradeDeleted;

  /// No description provided for @semanticsCourseGradeCard.
  ///
  /// In id, this message translates to:
  /// **'{courseName}, {sks} SKS, nilai {gradeIndex}, semester {semester}'**
  String semanticsCourseGradeCard(
    String courseName,
    int sks,
    String gradeIndex,
    int semester,
  );

  /// No description provided for @semanticsGradeIndexOption.
  ///
  /// In id, this message translates to:
  /// **'Indeks nilai {gradeIndex}'**
  String semanticsGradeIndexOption(String gradeIndex);

  /// No description provided for @dayAll.
  ///
  /// In id, this message translates to:
  /// **'Semua'**
  String get dayAll;

  /// No description provided for @dayMonday.
  ///
  /// In id, this message translates to:
  /// **'Senin'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In id, this message translates to:
  /// **'Selasa'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In id, this message translates to:
  /// **'Rabu'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In id, this message translates to:
  /// **'Kamis'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In id, this message translates to:
  /// **'Jumat'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In id, this message translates to:
  /// **'Sabtu'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In id, this message translates to:
  /// **'Minggu'**
  String get daySunday;

  /// No description provided for @dayShortMon.
  ///
  /// In id, this message translates to:
  /// **'Sen'**
  String get dayShortMon;

  /// No description provided for @dayShortTue.
  ///
  /// In id, this message translates to:
  /// **'Sel'**
  String get dayShortTue;

  /// No description provided for @dayShortWed.
  ///
  /// In id, this message translates to:
  /// **'Rab'**
  String get dayShortWed;

  /// No description provided for @dayShortThu.
  ///
  /// In id, this message translates to:
  /// **'Kam'**
  String get dayShortThu;

  /// No description provided for @dayShortFri.
  ///
  /// In id, this message translates to:
  /// **'Jum'**
  String get dayShortFri;

  /// No description provided for @dayShortSat.
  ///
  /// In id, this message translates to:
  /// **'Sab'**
  String get dayShortSat;

  /// No description provided for @dayShortSun.
  ///
  /// In id, this message translates to:
  /// **'Min'**
  String get dayShortSun;

  /// No description provided for @scheduleFormAddTitle.
  ///
  /// In id, this message translates to:
  /// **'Tambah Jadwal Kuliah'**
  String get scheduleFormAddTitle;

  /// No description provided for @scheduleFormEditTitle.
  ///
  /// In id, this message translates to:
  /// **'Ubah Jadwal Kuliah'**
  String get scheduleFormEditTitle;

  /// No description provided for @scheduleFieldDayLabel.
  ///
  /// In id, this message translates to:
  /// **'Hari Kuliah'**
  String get scheduleFieldDayLabel;

  /// No description provided for @scheduleFieldStartTimeLabel.
  ///
  /// In id, this message translates to:
  /// **'Jam Mulai'**
  String get scheduleFieldStartTimeLabel;

  /// No description provided for @scheduleFieldStartTimeHint.
  ///
  /// In id, this message translates to:
  /// **'08:00'**
  String get scheduleFieldStartTimeHint;

  /// No description provided for @scheduleFieldEndTimeLabel.
  ///
  /// In id, this message translates to:
  /// **'Jam Selesai'**
  String get scheduleFieldEndTimeLabel;

  /// No description provided for @scheduleFieldEndTimeHint.
  ///
  /// In id, this message translates to:
  /// **'10:00'**
  String get scheduleFieldEndTimeHint;

  /// No description provided for @scheduleFieldTimeFormatError.
  ///
  /// In id, this message translates to:
  /// **'Format jam tidak valid. Gunakan format JJ:MM (contoh 08:30).'**
  String get scheduleFieldTimeFormatError;

  /// No description provided for @scheduleFieldEndTimeError.
  ///
  /// In id, this message translates to:
  /// **'Jam selesai harus lebih besar dari jam mulai.'**
  String get scheduleFieldEndTimeError;

  /// No description provided for @scheduleFieldRoomLabel.
  ///
  /// In id, this message translates to:
  /// **'Ruangan'**
  String get scheduleFieldRoomLabel;

  /// No description provided for @scheduleFieldRoomHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Gedung A R.302'**
  String get scheduleFieldRoomHint;

  /// No description provided for @scheduleFieldRoomError.
  ///
  /// In id, this message translates to:
  /// **'Ruangan wajib diisi. Masukkan nama atau kode ruangan.'**
  String get scheduleFieldRoomError;

  /// No description provided for @scheduleConflictWarning.
  ///
  /// In id, this message translates to:
  /// **'Jadwal bentrok dengan \"{courseName}\" ({timeRange}). Kamu tetap bisa menyimpan jadwal ini.'**
  String scheduleConflictWarning(String courseName, String timeRange);

  /// No description provided for @scheduleDeleteDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Jadwal Kuliah?'**
  String get scheduleDeleteDialogTitle;

  /// No description provided for @scheduleDeleteDialogMessage.
  ///
  /// In id, this message translates to:
  /// **'Jadwal \"{courseName}\" ({dayName}) akan dihapus.'**
  String scheduleDeleteDialogMessage(String courseName, String dayName);

  /// No description provided for @toastScheduleSaved.
  ///
  /// In id, this message translates to:
  /// **'Jadwal tersimpan'**
  String get toastScheduleSaved;

  /// No description provided for @toastScheduleDeleted.
  ///
  /// In id, this message translates to:
  /// **'Jadwal dihapus'**
  String get toastScheduleDeleted;

  /// No description provided for @attendanceSheetTitle.
  ///
  /// In id, this message translates to:
  /// **'Presensi Kuliah'**
  String get attendanceSheetTitle;

  /// No description provided for @attendanceDateLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Pertemuan'**
  String get attendanceDateLabel;

  /// No description provided for @attendanceStatusLabel.
  ///
  /// In id, this message translates to:
  /// **'Status Kehadiran'**
  String get attendanceStatusLabel;

  /// No description provided for @attendanceStatusPresent.
  ///
  /// In id, this message translates to:
  /// **'Hadir'**
  String get attendanceStatusPresent;

  /// No description provided for @attendanceStatusSick.
  ///
  /// In id, this message translates to:
  /// **'Sakit'**
  String get attendanceStatusSick;

  /// No description provided for @attendanceStatusPermission.
  ///
  /// In id, this message translates to:
  /// **'Izin'**
  String get attendanceStatusPermission;

  /// No description provided for @attendanceStatusAbsent.
  ///
  /// In id, this message translates to:
  /// **'Alfa'**
  String get attendanceStatusAbsent;

  /// No description provided for @attendanceNotesLabel.
  ///
  /// In id, this message translates to:
  /// **'Keterangan / Catatan Pertemuan'**
  String get attendanceNotesLabel;

  /// No description provided for @attendanceNotesHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Membahas materi Bab 3'**
  String get attendanceNotesHint;

  /// No description provided for @attendanceRecordedAtInfo.
  ///
  /// In id, this message translates to:
  /// **'Dicatat otomatis saat disimpan'**
  String get attendanceRecordedAtInfo;

  /// No description provided for @toastAttendanceSaved.
  ///
  /// In id, this message translates to:
  /// **'Presensi tersimpan'**
  String get toastAttendanceSaved;

  /// No description provided for @attendanceRecapTitle.
  ///
  /// In id, this message translates to:
  /// **'Rekap Kehadiran per MK'**
  String get attendanceRecapTitle;

  /// No description provided for @attendanceRecapEmpty.
  ///
  /// In id, this message translates to:
  /// **'Belum ada catatan presensi kuliah.'**
  String get attendanceRecapEmpty;

  /// No description provided for @attendanceRecapSummary.
  ///
  /// In id, this message translates to:
  /// **'{presentCount} Hadir dari {totalCount} sesi ({percentage}%)'**
  String attendanceRecapSummary(
    int presentCount,
    int totalCount,
    String percentage,
  );

  /// No description provided for @attendanceRecapBreakdown.
  ///
  /// In id, this message translates to:
  /// **'Hadir: {present} · Sakit: {sick} · Izin: {permission} · Alfa: {absent}'**
  String attendanceRecapBreakdown(
    int present,
    int sick,
    int permission,
    int absent,
  );

  /// No description provided for @semanticsScheduleCard.
  ///
  /// In id, this message translates to:
  /// **'{courseName}, {dayName} pukul {timeRange}, ruangan {room}'**
  String semanticsScheduleCard(
    String courseName,
    String dayName,
    String timeRange,
    String room,
  );

  /// No description provided for @calendarPrevMonth.
  ///
  /// In id, this message translates to:
  /// **'Bulan sebelumnya'**
  String get calendarPrevMonth;

  /// No description provided for @calendarNextMonth.
  ///
  /// In id, this message translates to:
  /// **'Bulan berikutnya'**
  String get calendarNextMonth;

  /// No description provided for @calendarClearDateFilter.
  ///
  /// In id, this message translates to:
  /// **'Tampilkan semua tanggal'**
  String get calendarClearDateFilter;

  /// No description provided for @semanticsCalendarDayMarkers.
  ///
  /// In id, this message translates to:
  /// **'Tanggal {day}/{month}/{year}, {count} penanda'**
  String semanticsCalendarDayMarkers(int day, int month, int year, int count);

  /// No description provided for @taskTabActive.
  ///
  /// In id, this message translates to:
  /// **'Aktif'**
  String get taskTabActive;

  /// No description provided for @taskTabCompleted.
  ///
  /// In id, this message translates to:
  /// **'Selesai (Rekap)'**
  String get taskTabCompleted;

  /// No description provided for @taskFormAddTitle.
  ///
  /// In id, this message translates to:
  /// **'Tambah Tugas Kuliah'**
  String get taskFormAddTitle;

  /// No description provided for @taskFormEditTitle.
  ///
  /// In id, this message translates to:
  /// **'Ubah Tugas Kuliah'**
  String get taskFormEditTitle;

  /// No description provided for @taskFieldDescriptionLabel.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi Tugas'**
  String get taskFieldDescriptionLabel;

  /// No description provided for @taskFieldDescriptionHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Laporan Praktikum Modul 2'**
  String get taskFieldDescriptionHint;

  /// No description provided for @taskFieldDescriptionError.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi tugas wajib diisi. Masukkan deskripsi singkat tugas.'**
  String get taskFieldDescriptionError;

  /// No description provided for @taskFieldDueDateLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Tenggat'**
  String get taskFieldDueDateLabel;

  /// No description provided for @taskFieldDueDateHint.
  ///
  /// In id, this message translates to:
  /// **'2026-11-05'**
  String get taskFieldDueDateHint;

  /// No description provided for @taskFieldDueDateError.
  ///
  /// In id, this message translates to:
  /// **'Format tanggal tidak valid. Gunakan format TTTT-BB-HH.'**
  String get taskFieldDueDateError;

  /// No description provided for @taskFieldDueTimeLabel.
  ///
  /// In id, this message translates to:
  /// **'Jam Tenggat'**
  String get taskFieldDueTimeLabel;

  /// No description provided for @taskFieldDueTimeHint.
  ///
  /// In id, this message translates to:
  /// **'23:59'**
  String get taskFieldDueTimeHint;

  /// No description provided for @taskStatusOverdue.
  ///
  /// In id, this message translates to:
  /// **'Terlambat'**
  String get taskStatusOverdue;

  /// No description provided for @taskStatusUrgentHours.
  ///
  /// In id, this message translates to:
  /// **'Mendesak · {hours} jam lagi'**
  String taskStatusUrgentHours(int hours);

  /// No description provided for @taskStatusRemainingDays.
  ///
  /// In id, this message translates to:
  /// **'{days} hari lagi'**
  String taskStatusRemainingDays(int days);

  /// No description provided for @taskCompletedAtLabel.
  ///
  /// In id, this message translates to:
  /// **'Selesai pada {dateTime}'**
  String taskCompletedAtLabel(String dateTime);

  /// No description provided for @taskMarkComplete.
  ///
  /// In id, this message translates to:
  /// **'Tandai tugas selesai'**
  String get taskMarkComplete;

  /// No description provided for @taskUnmarkComplete.
  ///
  /// In id, this message translates to:
  /// **'Batalkan tanda selesai'**
  String get taskUnmarkComplete;

  /// No description provided for @taskDeleteDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Tugas Kuliah?'**
  String get taskDeleteDialogTitle;

  /// No description provided for @taskDeleteDialogMessage.
  ///
  /// In id, this message translates to:
  /// **'Tugas \"{courseName}\" akan dihapus.'**
  String taskDeleteDialogMessage(String courseName);

  /// No description provided for @toastTaskSaved.
  ///
  /// In id, this message translates to:
  /// **'Tugas tersimpan'**
  String get toastTaskSaved;

  /// No description provided for @toastTaskCompleted.
  ///
  /// In id, this message translates to:
  /// **'Tugas selesai'**
  String get toastTaskCompleted;

  /// No description provided for @toastTaskUncompleted.
  ///
  /// In id, this message translates to:
  /// **'Tugas dikembalikan ke daftar aktif'**
  String get toastTaskUncompleted;

  /// No description provided for @toastTaskDeleted.
  ///
  /// In id, this message translates to:
  /// **'Tugas dihapus'**
  String get toastTaskDeleted;

  /// No description provided for @eventFormAddTitle.
  ///
  /// In id, this message translates to:
  /// **'Tambah Acara Kampus'**
  String get eventFormAddTitle;

  /// No description provided for @eventFormEditTitle.
  ///
  /// In id, this message translates to:
  /// **'Ubah Acara Kampus'**
  String get eventFormEditTitle;

  /// No description provided for @eventFieldNameLabel.
  ///
  /// In id, this message translates to:
  /// **'Nama Acara'**
  String get eventFieldNameLabel;

  /// No description provided for @eventFieldNameHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Rapat Himpunan Mahasiswa'**
  String get eventFieldNameHint;

  /// No description provided for @eventFieldNameError.
  ///
  /// In id, this message translates to:
  /// **'Nama acara wajib diisi. Masukkan nama acara.'**
  String get eventFieldNameError;

  /// No description provided for @eventFieldDescriptionLabel.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi Acara'**
  String get eventFieldDescriptionLabel;

  /// No description provided for @eventFieldDescriptionHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Pembahasan program kerja semester ini'**
  String get eventFieldDescriptionHint;

  /// No description provided for @eventFieldDescriptionError.
  ///
  /// In id, this message translates to:
  /// **'Deskripsi acara wajib diisi. Masukkan deskripsi acara.'**
  String get eventFieldDescriptionError;

  /// No description provided for @eventFieldDateLabel.
  ///
  /// In id, this message translates to:
  /// **'Tanggal Acara'**
  String get eventFieldDateLabel;

  /// No description provided for @eventFieldDateHint.
  ///
  /// In id, this message translates to:
  /// **'2026-11-10'**
  String get eventFieldDateHint;

  /// No description provided for @eventDeleteDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Acara?'**
  String get eventDeleteDialogTitle;

  /// No description provided for @eventDeleteDialogMessage.
  ///
  /// In id, this message translates to:
  /// **'Acara \"{eventName}\" akan dihapus.'**
  String eventDeleteDialogMessage(String eventName);

  /// No description provided for @toastEventSaved.
  ///
  /// In id, this message translates to:
  /// **'Acara tersimpan'**
  String get toastEventSaved;

  /// No description provided for @toastEventDeleted.
  ///
  /// In id, this message translates to:
  /// **'Acara dihapus'**
  String get toastEventDeleted;

  /// No description provided for @semanticsLoading.
  ///
  /// In id, this message translates to:
  /// **'Sedang memuat'**
  String get semanticsLoading;

  /// No description provided for @semanticsOpenSettings.
  ///
  /// In id, this message translates to:
  /// **'Buka Pengaturan Profil dan Aplikasi'**
  String get semanticsOpenSettings;

  /// No description provided for @homeGreeting.
  ///
  /// In id, this message translates to:
  /// **'Halo, {name}!'**
  String homeGreeting(String name);

  /// No description provided for @homeDefaultStudentName.
  ///
  /// In id, this message translates to:
  /// **'Mahasiswa'**
  String get homeDefaultStudentName;

  /// No description provided for @homeTodayScheduleTitle.
  ///
  /// In id, this message translates to:
  /// **'Jadwal Hari Ini'**
  String get homeTodayScheduleTitle;

  /// No description provided for @homeTodayScheduleEmpty.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada jadwal kuliah hari ini.'**
  String get homeTodayScheduleEmpty;

  /// No description provided for @homeWeekTasksTitle.
  ///
  /// In id, this message translates to:
  /// **'Tugas 7 Hari ke Depan'**
  String get homeWeekTasksTitle;

  /// No description provided for @homeWeekTasksEmpty.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada tenggat tugas dalam 7 hari ke depan.'**
  String get homeWeekTasksEmpty;

  /// No description provided for @homeIpsTrendTitle.
  ///
  /// In id, this message translates to:
  /// **'Tren IPS per Semester'**
  String get homeIpsTrendTitle;

  /// No description provided for @homeIpsTrendEmpty.
  ///
  /// In id, this message translates to:
  /// **'Tambahkan nilai untuk melihat grafik tren IPS.'**
  String get homeIpsTrendEmpty;

  /// No description provided for @homeGradeDistributionTitle.
  ///
  /// In id, this message translates to:
  /// **'Sebaran Nilai'**
  String get homeGradeDistributionTitle;

  /// No description provided for @homeGradeDistributionEmpty.
  ///
  /// In id, this message translates to:
  /// **'Belum ada sebaran nilai yang tercatat.'**
  String get homeGradeDistributionEmpty;

  /// No description provided for @homeChartTableSummaryLabel.
  ///
  /// In id, this message translates to:
  /// **'Ringkasan Teks Grafik'**
  String get homeChartTableSummaryLabel;

  /// No description provided for @actionExport.
  ///
  /// In id, this message translates to:
  /// **'Ekspor'**
  String get actionExport;

  /// No description provided for @exportSheetTitle.
  ///
  /// In id, this message translates to:
  /// **'Ekspor Dokumen / Gambar'**
  String get exportSheetTitle;

  /// No description provided for @exportScopeLabel.
  ///
  /// In id, this message translates to:
  /// **'Cakupan Data'**
  String get exportScopeLabel;

  /// No description provided for @exportScopeHomeStats.
  ///
  /// In id, this message translates to:
  /// **'Statistik Beranda (IPK & Sebaran Nilai)'**
  String get exportScopeHomeStats;

  /// No description provided for @exportScopeAllGrades.
  ///
  /// In id, this message translates to:
  /// **'Transkrip Nilai Semua Semester & IPK'**
  String get exportScopeAllGrades;

  /// No description provided for @exportScopeScheduleAttendance.
  ///
  /// In id, this message translates to:
  /// **'Jadwal Mingguan & Rekap Presensi'**
  String get exportScopeScheduleAttendance;

  /// No description provided for @exportFormatLabel.
  ///
  /// In id, this message translates to:
  /// **'Format Berkas'**
  String get exportFormatLabel;

  /// No description provided for @exportFormatPdf.
  ///
  /// In id, this message translates to:
  /// **'PDF'**
  String get exportFormatPdf;

  /// No description provided for @exportFormatPng.
  ///
  /// In id, this message translates to:
  /// **'PNG (Gambar)'**
  String get exportFormatPng;

  /// No description provided for @exportFormatJpg.
  ///
  /// In id, this message translates to:
  /// **'JPG'**
  String get exportFormatJpg;

  /// No description provided for @exportGenerateAndShare.
  ///
  /// In id, this message translates to:
  /// **'Ekspor'**
  String get exportGenerateAndShare;

  /// No description provided for @exportProgressLoading.
  ///
  /// In id, this message translates to:
  /// **'Membuat berkas ekspor...'**
  String get exportProgressLoading;

  /// No description provided for @toastExportSuccess.
  ///
  /// In id, this message translates to:
  /// **'Berkas ekspor siap dibagikan'**
  String get toastExportSuccess;

  /// No description provided for @errorExportFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal membuat berkas ekspor'**
  String get errorExportFailed;

  /// No description provided for @settingsGroupAccount.
  ///
  /// In id, this message translates to:
  /// **'Akun & Profil'**
  String get settingsGroupAccount;

  /// No description provided for @settingsGroupPreferences.
  ///
  /// In id, this message translates to:
  /// **'Preferensi Akademik'**
  String get settingsGroupPreferences;

  /// No description provided for @settingsGroupData.
  ///
  /// In id, this message translates to:
  /// **'Pengingat & Data Lokal'**
  String get settingsGroupData;

  /// No description provided for @settingsGroupAbout.
  ///
  /// In id, this message translates to:
  /// **'Tentang & Dukungan'**
  String get settingsGroupAbout;

  /// No description provided for @settingsEditProfileTitle.
  ///
  /// In id, this message translates to:
  /// **'Profil Mahasiswa'**
  String get settingsEditProfileTitle;

  /// No description provided for @settingsEditProfileSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Ubah biodata dan foto profil lokal'**
  String get settingsEditProfileSubtitle;

  /// No description provided for @settingsPickPhotoGallery.
  ///
  /// In id, this message translates to:
  /// **'Pilih dari Galeri'**
  String get settingsPickPhotoGallery;

  /// No description provided for @settingsPickPhotoCamera.
  ///
  /// In id, this message translates to:
  /// **'Ambil Foto Kamera'**
  String get settingsPickPhotoCamera;

  /// No description provided for @settingsRemovePhoto.
  ///
  /// In id, this message translates to:
  /// **'Hapus Foto'**
  String get settingsRemovePhoto;

  /// No description provided for @toastProfileUpdated.
  ///
  /// In id, this message translates to:
  /// **'Profil diperbarui'**
  String get toastProfileUpdated;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Aplikasi'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageIndonesian.
  ///
  /// In id, this message translates to:
  /// **'Indonesia'**
  String get settingsLanguageIndonesian;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In id, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @toastLanguageChanged.
  ///
  /// In id, this message translates to:
  /// **'Bahasa berhasil diubah'**
  String get toastLanguageChanged;

  /// No description provided for @settingsConversionTitle.
  ///
  /// In id, this message translates to:
  /// **'Konversi Nilai'**
  String get settingsConversionTitle;

  /// No description provided for @settingsConversionSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Bobot indeks nilai dan kustomisasi konversi'**
  String get settingsConversionSubtitle;

  /// No description provided for @settingsMinPassingGradeLabel.
  ///
  /// In id, this message translates to:
  /// **'Nilai Lulus Minimum'**
  String get settingsMinPassingGradeLabel;

  /// No description provided for @settingsRetakeRuleLabel.
  ///
  /// In id, this message translates to:
  /// **'Aturan Nilai Mengulang (IPK)'**
  String get settingsRetakeRuleLabel;

  /// No description provided for @settingsRetakeRuleHighest.
  ///
  /// In id, this message translates to:
  /// **'Nilai Tertinggi (Default)'**
  String get settingsRetakeRuleHighest;

  /// No description provided for @settingsRetakeRuleLatest.
  ///
  /// In id, this message translates to:
  /// **'Nilai Terbaru'**
  String get settingsRetakeRuleLatest;

  /// No description provided for @settingsResetConversion.
  ///
  /// In id, this message translates to:
  /// **'Reset'**
  String get settingsResetConversion;

  /// No description provided for @toastConversionSaved.
  ///
  /// In id, this message translates to:
  /// **'Aturan konversi disimpan & IPK dihitung ulang'**
  String get toastConversionSaved;

  /// No description provided for @settingsFormulaGuideTitle.
  ///
  /// In id, this message translates to:
  /// **'Panduan Rumus IPS & IPK'**
  String get settingsFormulaGuideTitle;

  /// No description provided for @settingsFormulaGuideSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Penjelasan perhitungan nilai dan kasus mengulang'**
  String get settingsFormulaGuideSubtitle;

  /// No description provided for @formulaGuideBody.
  ///
  /// In id, this message translates to:
  /// **'1. IPS bersifat historis: Σ(bobot × SKS) / Σ SKS dari semua entri pada semester tersebut (termasuk nilai E dan perbaikan).\n\n2. IPK Kumulatif: Σ(bobot × SKS) / Σ SKS dari satu entri terpakai per kelompok mata kuliah (nilai tertinggi secara default, atau nilai terbaru).\n\n3. Nilai E selalu wajib mengulang (tidak lulus). Sebelum diulang, nilai E tetap masuk pembagi IPK (bobot 0). Setelah diulang, nilai baru menggantikan nilai E di IPK, sementara IPS semester lama tidak berubah.\n\n4. SKS Selesai dan MK Selesai hanya menghitung kelompok MK yang entri terpakainya lulus (≥ nilai lulus minimum).'**
  String get formulaGuideBody;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In id, this message translates to:
  /// **'Pengingat & Notifikasi'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Atur pengingat jadwal, tugas, dan acara'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsNotifyScheduleLabel.
  ///
  /// In id, this message translates to:
  /// **'Pengingat Jadwal Kuliah'**
  String get settingsNotifyScheduleLabel;

  /// No description provided for @settingsNotifyTaskLabel.
  ///
  /// In id, this message translates to:
  /// **'Pengingat Tenggat Tugas'**
  String get settingsNotifyTaskLabel;

  /// No description provided for @settingsNotifyEventLabel.
  ///
  /// In id, this message translates to:
  /// **'Pengingat Acara Kampus'**
  String get settingsNotifyEventLabel;

  /// No description provided for @settingsReminderOffsetMinutes.
  ///
  /// In id, this message translates to:
  /// **'{minutes} menit sebelum'**
  String settingsReminderOffsetMinutes(int minutes);

  /// No description provided for @toastNotificationsSaved.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan notifikasi disimpan'**
  String get toastNotificationsSaved;

  /// No description provided for @settingsBackupTitle.
  ///
  /// In id, this message translates to:
  /// **'Backup & Restore Data'**
  String get settingsBackupTitle;

  /// No description provided for @settingsBackupSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Cadangkan atau pulihkan seluruh data JSON (Offline)'**
  String get settingsBackupSubtitle;

  /// No description provided for @backupNeverInfo.
  ///
  /// In id, this message translates to:
  /// **'Belum pernah melakukan backup'**
  String get backupNeverInfo;

  /// No description provided for @backupLastAtInfo.
  ///
  /// In id, this message translates to:
  /// **'Backup terakhir: {dateTime}'**
  String backupLastAtInfo(String dateTime);

  /// No description provided for @backupGuideBody.
  ///
  /// In id, this message translates to:
  /// **'Simpan berkas JSON backup di folder aman atau penyimpanan cloud pribadimu. Saat ganti perangkat, pilih berkas tersebut lewat menu Restore.'**
  String get backupGuideBody;

  /// No description provided for @actionCreateBackup.
  ///
  /// In id, this message translates to:
  /// **'Buat Backup JSON'**
  String get actionCreateBackup;

  /// No description provided for @actionRestoreBackup.
  ///
  /// In id, this message translates to:
  /// **'Pilih File & Restore'**
  String get actionRestoreBackup;

  /// No description provided for @restoreConfirmTitle.
  ///
  /// In id, this message translates to:
  /// **'Pulihkan Data dari Backup?'**
  String get restoreConfirmTitle;

  /// No description provided for @restoreConfirmDescription.
  ///
  /// In id, this message translates to:
  /// **'Seluruh data lokal saat ini akan diganti dengan isi berkas backup. Geser untuk mengonfirmasi pemulihan.'**
  String get restoreConfirmDescription;

  /// No description provided for @slideToRestoreLabel.
  ///
  /// In id, this message translates to:
  /// **'Geser untuk Restore'**
  String get slideToRestoreLabel;

  /// No description provided for @toastBackupCreated.
  ///
  /// In id, this message translates to:
  /// **'Backup berhasil dibuat'**
  String get toastBackupCreated;

  /// No description provided for @toastRestoreSuccess.
  ///
  /// In id, this message translates to:
  /// **'Restore berhasil. Seluruh data telah dipulihkan.'**
  String get toastRestoreSuccess;

  /// No description provided for @errorBackupInvalid.
  ///
  /// In id, this message translates to:
  /// **'File tidak valid atau versi skema tidak cocok. Data lama tetap aman.'**
  String get errorBackupInvalid;

  /// No description provided for @settingsAboutAppTitle.
  ///
  /// In id, this message translates to:
  /// **'Tentang Aplikasi'**
  String get settingsAboutAppTitle;

  /// No description provided for @settingsAboutAppSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Versi 1.0.0 · Lisensi MIT · Open Source'**
  String get settingsAboutAppSubtitle;

  /// No description provided for @aboutAppDescription.
  ///
  /// In id, this message translates to:
  /// **'Nguliah adalah aplikasi Android offline-first bebas iklan untuk membantu mahasiswa mengelola nilai, jadwal, presensi, tugas, dan acara kampus secara mandiri.'**
  String get aboutAppDescription;

  /// No description provided for @aboutAppLicenseLabel.
  ///
  /// In id, this message translates to:
  /// **'Lisensi: MIT License (Repositori GitHub Publik)'**
  String get aboutAppLicenseLabel;

  /// No description provided for @settingsAboutDevTitle.
  ///
  /// In id, this message translates to:
  /// **'Tentang Pengembang & Dukungan'**
  String get settingsAboutDevTitle;

  /// No description provided for @settingsAboutDevSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Profil pengembang & dukungan sukarela (QRIS)'**
  String get settingsAboutDevSubtitle;

  /// No description provided for @aboutDevDescription.
  ///
  /// In id, this message translates to:
  /// **'Dikembangkan secara terbuka untuk mahasiswa Indonesia. Jika aplikasi ini membantumu, kamu dapat memberikan dukungan sukarela melalui QRIS di bawah ini.'**
  String get aboutDevDescription;

  /// No description provided for @qrisCardTitle.
  ///
  /// In id, this message translates to:
  /// **'Dukung lewat QRIS (Buy Me a Coffee)'**
  String get qrisCardTitle;

  /// No description provided for @semanticsQrisImage.
  ///
  /// In id, this message translates to:
  /// **'Gambar kode pembayaran QRIS statis untuk mendukung pengembang Nguliah'**
  String get semanticsQrisImage;

  /// No description provided for @permissionMediaDeniedBanner.
  ///
  /// In id, this message translates to:
  /// **'Izin kamera/galeri ditolak. Gunakan inisial profil atau aktifkan izin di Pengaturan Sistem.'**
  String get permissionMediaDeniedBanner;

  /// No description provided for @permissionStorageDeniedBanner.
  ///
  /// In id, this message translates to:
  /// **'Izin penyimpanan/pemilih berkas ditolak. Aktifkan izin di Pengaturan Sistem untuk melanjutkan.'**
  String get permissionStorageDeniedBanner;

  /// No description provided for @authRestoreOption.
  ///
  /// In id, this message translates to:
  /// **'Sudah punya backup? Pulihkan Data'**
  String get authRestoreOption;

  /// No description provided for @homeUpcomingEventsTitle.
  ///
  /// In id, this message translates to:
  /// **'Acara 7 Hari ke Depan'**
  String get homeUpcomingEventsTitle;

  /// No description provided for @homeUpcomingEventsEmpty.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada acara kampus dalam 7 hari ke depan.'**
  String get homeUpcomingEventsEmpty;

  /// No description provided for @homeChartToggleBar.
  ///
  /// In id, this message translates to:
  /// **'Diagram Batang'**
  String get homeChartToggleBar;

  /// No description provided for @homeChartTogglePie.
  ///
  /// In id, this message translates to:
  /// **'Pie Chart (%)'**
  String get homeChartTogglePie;

  /// No description provided for @attendanceStatusDispensation.
  ///
  /// In id, this message translates to:
  /// **'Dispen'**
  String get attendanceStatusDispensation;

  /// No description provided for @attendanceRestrictedOutsideClass.
  ///
  /// In id, this message translates to:
  /// **'Presensi hanya dapat diisi saat jam KBM berlangsung ({timeRange}). Di luar jam ini dicatat sebagai Alfa.'**
  String attendanceRestrictedOutsideClass(String timeRange);

  /// No description provided for @attendanceCountMeetingsLabel.
  ///
  /// In id, this message translates to:
  /// **'Jumlah Pertemuan'**
  String get attendanceCountMeetingsLabel;

  /// No description provided for @attendanceCountPresentLabel.
  ///
  /// In id, this message translates to:
  /// **'Jumlah Kehadiran'**
  String get attendanceCountPresentLabel;

  /// No description provided for @attendancePercentageLabel.
  ///
  /// In id, this message translates to:
  /// **'Persentase Kehadiran'**
  String get attendancePercentageLabel;

  /// No description provided for @attendanceSlideToConfirmEdit.
  ///
  /// In id, this message translates to:
  /// **'Geser untuk Simpan Perubahan'**
  String get attendanceSlideToConfirmEdit;

  /// No description provided for @taskConfirmCompleteTitle.
  ///
  /// In id, this message translates to:
  /// **'Tandai Tugas Selesai?'**
  String get taskConfirmCompleteTitle;

  /// No description provided for @taskConfirmCompleteMessage.
  ///
  /// In id, this message translates to:
  /// **'Tugas \"{taskTitle}\" akan dipindahkan ke daftar selesai.'**
  String taskConfirmCompleteMessage(String taskTitle);

  /// No description provided for @taskConfirmUncompleteTitle.
  ///
  /// In id, this message translates to:
  /// **'Kembalikan Status Tugas?'**
  String get taskConfirmUncompleteTitle;

  /// No description provided for @taskConfirmUncompleteMessage.
  ///
  /// In id, this message translates to:
  /// **'Tugas \"{taskTitle}\" akan dikembalikan ke daftar aktif.'**
  String taskConfirmUncompleteMessage(String taskTitle);

  /// No description provided for @eventTabActive.
  ///
  /// In id, this message translates to:
  /// **'Acara Aktif'**
  String get eventTabActive;

  /// No description provided for @eventTabCompleted.
  ///
  /// In id, this message translates to:
  /// **'Selesai (Rekap)'**
  String get eventTabCompleted;

  /// No description provided for @eventFieldLocationLabel.
  ///
  /// In id, this message translates to:
  /// **'Lokasi Acara'**
  String get eventFieldLocationLabel;

  /// No description provided for @eventFieldLocationHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: Gedung B R.201 / Zoom'**
  String get eventFieldLocationHint;

  /// No description provided for @settingsThemeModeTitle.
  ///
  /// In id, this message translates to:
  /// **'Mode Tema'**
  String get settingsThemeModeTitle;

  /// No description provided for @settingsThemeModeLight.
  ///
  /// In id, this message translates to:
  /// **'Terang'**
  String get settingsThemeModeLight;

  /// No description provided for @settingsThemeModeDark.
  ///
  /// In id, this message translates to:
  /// **'Gelap'**
  String get settingsThemeModeDark;

  /// No description provided for @settingsCustomReminderMinutesLabel.
  ///
  /// In id, this message translates to:
  /// **'Waktu Pengingat (Menit Sebelum)'**
  String get settingsCustomReminderMinutesLabel;

  /// No description provided for @settingsCustomReminderMinutesHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: 30'**
  String get settingsCustomReminderMinutesHint;

  /// No description provided for @toastDeviceNotificationActive.
  ///
  /// In id, this message translates to:
  /// **'Izin notifikasi perangkat aktif'**
  String get toastDeviceNotificationActive;

  /// No description provided for @toastDeviceNotificationDenied.
  ///
  /// In id, this message translates to:
  /// **'Izin notifikasi perangkat ditolak/belum diaktifkan'**
  String get toastDeviceNotificationDenied;

  /// No description provided for @settingsEnableDeviceNotification.
  ///
  /// In id, this message translates to:
  /// **'Notifikasi Perangkat'**
  String get settingsEnableDeviceNotification;

  /// No description provided for @settingsEnableDeviceNotificationSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Kelola izin dan setelan notifikasi sistem'**
  String get settingsEnableDeviceNotificationSubtitle;

  /// No description provided for @settingsOpenSystemSettings.
  ///
  /// In id, this message translates to:
  /// **'Buka Setelan Notifikasi Sistem'**
  String get settingsOpenSystemSettings;

  /// No description provided for @settingsLogoutTitle.
  ///
  /// In id, this message translates to:
  /// **'Keluar Akun'**
  String get settingsLogoutTitle;

  /// No description provided for @settingsLogoutSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus sesi profil dan kembali ke layar Masuk'**
  String get settingsLogoutSubtitle;

  /// No description provided for @settingsLogoutDialogTitle.
  ///
  /// In id, this message translates to:
  /// **'Keluar dari Akun?'**
  String get settingsLogoutDialogTitle;

  /// No description provided for @settingsLogoutDialogMessage.
  ///
  /// In id, this message translates to:
  /// **'Data akademik tetap tersimpan di perangkat. Anda akan diarahkan kembali ke layar Masuk.'**
  String get settingsLogoutDialogMessage;

  /// No description provided for @settingsAddGradeConversion.
  ///
  /// In id, this message translates to:
  /// **'Tambah Indeks Nilai'**
  String get settingsAddGradeConversion;

  /// No description provided for @settingsGradeIndexLabel.
  ///
  /// In id, this message translates to:
  /// **'Indeks Huruf'**
  String get settingsGradeIndexLabel;

  /// No description provided for @settingsGradeIndexHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: A-'**
  String get settingsGradeIndexHint;

  /// No description provided for @settingsGradeWeightLabel.
  ///
  /// In id, this message translates to:
  /// **'Bobot'**
  String get settingsGradeWeightLabel;

  /// No description provided for @settingsGradeWeightHint.
  ///
  /// In id, this message translates to:
  /// **'Contoh: 3.75'**
  String get settingsGradeWeightHint;

  /// No description provided for @settingsDeleteGradeIndexTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Indeks Nilai?'**
  String get settingsDeleteGradeIndexTitle;

  /// No description provided for @settingsDeleteGradeIndexMessage.
  ///
  /// In id, this message translates to:
  /// **'Indeks \"{index}\" akan dihapus dari aturan konversi.'**
  String settingsDeleteGradeIndexMessage(String index);

  /// No description provided for @settingsDeveloperPhotoGuide.
  ///
  /// In id, this message translates to:
  /// **'Letakkan foto profil pengembang di assets/images/developer.png dan foto QRIS di assets/images/qris.png'**
  String get settingsDeveloperPhotoGuide;

  /// No description provided for @settingsExportSectionTitle.
  ///
  /// In id, this message translates to:
  /// **'Ekspor Dokumen & Data'**
  String get settingsExportSectionTitle;

  /// No description provided for @settingsExportStatsTitle.
  ///
  /// In id, this message translates to:
  /// **'Ekspor Statistik & IPK'**
  String get settingsExportStatsTitle;

  /// No description provided for @settingsExportGradesTitle.
  ///
  /// In id, this message translates to:
  /// **'Ekspor Transkrip Nilai (Semua Semester)'**
  String get settingsExportGradesTitle;

  /// No description provided for @settingsExportScheduleTitle.
  ///
  /// In id, this message translates to:
  /// **'Ekspor Jadwal & Rekap Presensi'**
  String get settingsExportScheduleTitle;

  /// No description provided for @gradeFormSlideDropdownHint.
  ///
  /// In id, this message translates to:
  /// **'Pilih Indeks Nilai'**
  String get gradeFormSlideDropdownHint;

  /// No description provided for @gradeFieldSemesterTypedHint.
  ///
  /// In id, this message translates to:
  /// **'1 - 14'**
  String get gradeFieldSemesterTypedHint;

  /// No description provided for @gradesIpkTitle.
  ///
  /// In id, this message translates to:
  /// **'IPK'**
  String get gradesIpkTitle;

  /// No description provided for @gradesCompletedSksTitle.
  ///
  /// In id, this message translates to:
  /// **'SKS Selesai'**
  String get gradesCompletedSksTitle;

  /// No description provided for @gradesCompletedCoursesTitle.
  ///
  /// In id, this message translates to:
  /// **'MK Selesai'**
  String get gradesCompletedCoursesTitle;

  /// No description provided for @taskCancelConfirmTitle.
  ///
  /// In id, this message translates to:
  /// **'Batalkan Penyelesaian Tugas?'**
  String get taskCancelConfirmTitle;

  /// No description provided for @taskCompleteConfirmTitle.
  ///
  /// In id, this message translates to:
  /// **'Selesaikan Tugas Kuliah?'**
  String get taskCompleteConfirmTitle;

  /// No description provided for @taskCancelConfirmMessage.
  ///
  /// In id, this message translates to:
  /// **'Status tugas ini akan diubah kembali menjadi aktif.'**
  String get taskCancelConfirmMessage;

  /// No description provided for @taskCompleteConfirmMessage.
  ///
  /// In id, this message translates to:
  /// **'Apakah tugas ini sudah selesai Anda kerjakan?'**
  String get taskCompleteConfirmMessage;

  /// No description provided for @fieldRequired.
  ///
  /// In id, this message translates to:
  /// **'Bidang ini wajib diisi'**
  String get fieldRequired;

  /// No description provided for @attendanceMeetingHistoryTitle.
  ///
  /// In id, this message translates to:
  /// **'Detail Pertemuan Kuliah'**
  String get attendanceMeetingHistoryTitle;

  /// No description provided for @attendanceOutsideHoursWarning.
  ///
  /// In id, this message translates to:
  /// **'Presensi di luar jam perkuliahan otomatis dicatat sebagai Alfa.'**
  String get attendanceOutsideHoursWarning;

  /// No description provided for @settingsEditGradeConversion.
  ///
  /// In id, this message translates to:
  /// **'Ubah Indeks Nilai'**
  String get settingsEditGradeConversion;

  /// No description provided for @taskActionUncomplete.
  ///
  /// In id, this message translates to:
  /// **'Batalkan Selesai'**
  String get taskActionUncomplete;

  /// No description provided for @emptyCompletedEventsTitle.
  ///
  /// In id, this message translates to:
  /// **'Belum ada acara selesai'**
  String get emptyCompletedEventsTitle;

  /// No description provided for @emptyCompletedEventsDescription.
  ///
  /// In id, this message translates to:
  /// **'Belum ada rekapan acara kampus yang telah selesai.'**
  String get emptyCompletedEventsDescription;

  /// No description provided for @settingsHideScoresTitle.
  ///
  /// In id, this message translates to:
  /// **'Sembunyikan Nilai Akademik'**
  String get settingsHideScoresTitle;

  /// No description provided for @settingsHideScoresSubtitle.
  ///
  /// In id, this message translates to:
  /// **'Sensor IPK, IPS, SKS, dan MK selesai dengan tanda bintang *'**
  String get settingsHideScoresSubtitle;

  /// No description provided for @settingsConfirmSaveConversionTitle.
  ///
  /// In id, this message translates to:
  /// **'Simpan Konversi Nilai?'**
  String get settingsConfirmSaveConversionTitle;

  /// No description provided for @settingsConfirmSaveConversionMessage.
  ///
  /// In id, this message translates to:
  /// **'Perubahan konversi nilai akan mempengaruhi perhitungan IPK dan IPS. Simpan sekarang?'**
  String get settingsConfirmSaveConversionMessage;

  /// No description provided for @settingsConfirmDeleteConversionTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Indeks Nilai?'**
  String get settingsConfirmDeleteConversionTitle;

  /// No description provided for @settingsConfirmDeleteConversionMessage.
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda yakin ingin menghapus indeks nilai ini dari daftar konversi?'**
  String get settingsConfirmDeleteConversionMessage;

  /// No description provided for @shortIpsLabel.
  ///
  /// In id, this message translates to:
  /// **'IPS'**
  String get shortIpsLabel;

  /// No description provided for @shortIpkLabel.
  ///
  /// In id, this message translates to:
  /// **'IPK'**
  String get shortIpkLabel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
