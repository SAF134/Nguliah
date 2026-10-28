import 'package:isar_community/isar.dart';

part 'app_settings_model.g.dart';

/// Aturan pemilihan entri nilai untuk mata kuliah mengulang.
enum RetakeRule { highest, latest }

/// Model Isar untuk koleksi Pengaturan aplikasi (termasuk konversi nilai).
@collection
class AppSettings {
  AppSettings({
    this.id = 1,
    this.localeCode = 'id',
    this.themeMode = 'light',
    this.onboardingCompleted = false,
    this.weightA = 4.0,
    this.weightAB = 3.5,
    this.weightB = 3.0,
    this.weightBC = 2.5,
    this.weightC = 2.0,
    this.weightD = 1.0,
    this.weightE = 0.0,
    this.customGradeWeightsJson = '',
    this.minPassingGrade = 'D',
    this.retakeRule = RetakeRule.latest,
    this.scheduleNotificationEnabled = true,
    this.scheduleReminderOffsetMinutes = 30,
    this.taskNotificationEnabled = true,
    this.taskReminderOffsetMinutes = 60,
    this.eventNotificationEnabled = true,
    this.eventReminderOffsetMinutes = 60,
    this.hideAcademicScores = false,
    this.lastBackupAt,
  });

  Id id;

  late String localeCode;
  late String themeMode;
  late bool onboardingCompleted;

  // Bobot konversi nilai (default: A=4, AB=3.5, B=3, BC=2.5, C=2, D=1, E=0)
  late double weightA;
  late double weightAB;
  late double weightB;
  late double weightBC;
  late double weightC;
  late double weightD;
  late double weightE;

  /// Serialisasi JSON peta konversi nilai kustom untuk mendukung CRUD indeks dan bobot.
  late String customGradeWeightsJson;

  /// Nilai lulus minimum (default: D).
  late String minPassingGrade;

  /// Aturan nilai mengulang (default: latest, opsi: highest).
  @Enumerated(EnumType.name)
  late RetakeRule retakeRule;

  // Pengaturan notifikasi
  late bool scheduleNotificationEnabled;
  late int scheduleReminderOffsetMinutes;
  late bool taskNotificationEnabled;
  late int taskReminderOffsetMinutes;
  late bool eventNotificationEnabled;
  late int eventReminderOffsetMinutes;

  /// Status penyembunyian nilai akademik (tersensor tanda bintang *).
  late bool hideAcademicScores;

  DateTime? lastBackupAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'localeCode': localeCode,
    'themeMode': themeMode,
    'onboardingCompleted': onboardingCompleted,
    'weightA': weightA,
    'weightAB': weightAB,
    'weightB': weightB,
    'weightBC': weightBC,
    'weightC': weightC,
    'weightD': weightD,
    'weightE': weightE,
    'customGradeWeightsJson': customGradeWeightsJson,
    'minPassingGrade': minPassingGrade,
    'retakeRule': retakeRule.name,
    'scheduleNotificationEnabled': scheduleNotificationEnabled,
    'scheduleReminderOffsetMinutes': scheduleReminderOffsetMinutes,
    'taskNotificationEnabled': taskNotificationEnabled,
    'taskReminderOffsetMinutes': taskReminderOffsetMinutes,
    'eventNotificationEnabled': eventNotificationEnabled,
    'eventReminderOffsetMinutes': eventReminderOffsetMinutes,
    'hideAcademicScores': hideAcademicScores,
    'lastBackupAt': lastBackupAt?.toIso8601String(),
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
    id: (json['id'] as num?)?.toInt() ?? 1,
    localeCode: (json['localeCode'] as String?) ?? 'id',
    themeMode: (json['themeMode'] as String?) ?? 'light',
    onboardingCompleted: (json['onboardingCompleted'] as bool?) ?? false,
    weightA: (json['weightA'] as num?)?.toDouble() ?? 4.0,
    weightAB: (json['weightAB'] as num?)?.toDouble() ?? 3.5,
    weightB: (json['weightB'] as num?)?.toDouble() ?? 3.0,
    weightBC: (json['weightBC'] as num?)?.toDouble() ?? 2.5,
    weightC: (json['weightC'] as num?)?.toDouble() ?? 2.0,
    weightD: (json['weightD'] as num?)?.toDouble() ?? 1.0,
    weightE: (json['weightE'] as num?)?.toDouble() ?? 0.0,
    customGradeWeightsJson: (json['customGradeWeightsJson'] as String?) ?? '',
    minPassingGrade: (json['minPassingGrade'] as String?) ?? 'D',
    retakeRule: RetakeRule.values.byName(
      (json['retakeRule'] as String?) ?? RetakeRule.latest.name,
    ),
    scheduleNotificationEnabled:
        (json['scheduleNotificationEnabled'] as bool?) ?? true,
    scheduleReminderOffsetMinutes:
        (json['scheduleReminderOffsetMinutes'] as num?)?.toInt() ?? 30,
    taskNotificationEnabled: (json['taskNotificationEnabled'] as bool?) ?? true,
    taskReminderOffsetMinutes:
        (json['taskReminderOffsetMinutes'] as num?)?.toInt() ?? 60,
    eventNotificationEnabled:
        (json['eventNotificationEnabled'] as bool?) ?? true,
    eventReminderOffsetMinutes:
        (json['eventReminderOffsetMinutes'] as num?)?.toInt() ?? 60,
    hideAcademicScores: (json['hideAcademicScores'] as bool?) ?? false,
    lastBackupAt: json['lastBackupAt'] != null
        ? DateTime.parse(json['lastBackupAt'] as String)
        : null,
  );
}
