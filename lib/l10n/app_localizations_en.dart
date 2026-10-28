// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nguliah';

  @override
  String get appTagline =>
      'Manage your grades, schedule, tasks, and campus events in one place.';

  @override
  String get splashLoading => 'Loading academic data...';

  @override
  String get navHome => 'Home';

  @override
  String get navGrades => 'Grades';

  @override
  String get navSchedule => 'Schedule';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navEvents => 'Events';

  @override
  String get screenOnboardingTitle => 'Discover Nguliah';

  @override
  String get screenOnboardingSubtitle =>
      '4 simple steps to organize your studies offline.';

  @override
  String get onboardingSlide1Title => 'Track Grades & GPA';

  @override
  String get onboardingSlide1Desc =>
      'Record semester grades, manage retaken courses, and view accurate semester and cumulative GPA.';

  @override
  String get onboardingSlide2Title => 'Class Schedule & Attendance';

  @override
  String get onboardingSlide2Desc =>
      'Organize weekly classes, detect schedule conflicts, and log attendance for every session.';

  @override
  String get onboardingSlide3Title => 'Manage Tasks & Deadlines';

  @override
  String get onboardingSlide3Desc =>
      'Monitor remaining time for assignments with calendar markers and timely reminders.';

  @override
  String get onboardingSlide4Title => 'Organize Campus Events';

  @override
  String get onboardingSlide4Desc =>
      'Plan student organization activities and non-class events in a clean monthly calendar.';

  @override
  String onboardingSlideIndicator(int current, int total) {
    return 'Slide $current of $total';
  }

  @override
  String get slideToStartLabel => 'Slide to Start';

  @override
  String get slideToConfirmAction => 'Confirm without sliding';

  @override
  String get screenAuthTitle => 'Student Profile';

  @override
  String get screenAuthSubtitle =>
      'Fill in your basic details to personalize the app. All data stays on this device.';

  @override
  String get fieldFullNameLabel => 'Full Name';

  @override
  String get fieldFullNameHint => 'Example: Rani Putri';

  @override
  String get fieldFullNameError =>
      'Full name is required. Enter at least 2 characters.';

  @override
  String get fieldUniversityLabel => 'University / Institution';

  @override
  String get fieldUniversityHint => 'Example: University of Indonesia';

  @override
  String get fieldUniversityError =>
      'University is required. Enter your institution name.';

  @override
  String get fieldFacultyLabel => 'Faculty / Department';

  @override
  String get fieldFacultyHint => 'Example: Faculty of Computer Science';

  @override
  String get fieldFacultyError =>
      'Faculty is required. Enter your faculty or department name.';

  @override
  String get fieldMajorLabel => 'Study Program / Major';

  @override
  String get fieldMajorHint => 'Example: Information Systems';

  @override
  String get fieldMajorError => 'Study program is required. Enter your major.';

  @override
  String get fieldEntryYearLabel => 'Entry Year';

  @override
  String get fieldEntryYearHint => 'Select entry year';

  @override
  String get fieldEntryYearError =>
      'Entry year is required. Select a valid year.';

  @override
  String get screenHomeTitle => 'Home';

  @override
  String get screenGradesTitle => 'Academic Grades';

  @override
  String get screenScheduleTitle => 'Class Schedule';

  @override
  String get screenTasksTitle => 'Course Tasks';

  @override
  String get screenEventsTitle => 'Campus Events';

  @override
  String get screenSettingsTitle => 'Settings';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionSkip => 'Skip';

  @override
  String get actionStart => 'Get Started';

  @override
  String get actionSaveAndStart => 'Save & Start';

  @override
  String get actionYes => 'Yes';

  @override
  String get actionNo => 'No';

  @override
  String get actionReset => 'Reset';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get actionSave => 'Save';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionEdit => 'Edit';

  @override
  String get actionUndo => 'Undo';

  @override
  String get actionRetake => 'Retake';

  @override
  String get actionClose => 'Close';

  @override
  String get actionOpenSettings => 'Open Settings';

  @override
  String get actionRetry => 'Retry';

  @override
  String get actionAddFirstGrade => 'Add First Grade';

  @override
  String get actionAddGrade => 'Add Grade';

  @override
  String get actionAddSchedule => 'Add Schedule';

  @override
  String get actionAddTask => 'Add Task';

  @override
  String get actionAddEvent => 'Add Event';

  @override
  String get actionRecordAttendance => 'Log Attendance';

  @override
  String get actionAttendanceRecap => 'Attendance Recap';

  @override
  String get emptyHomeTitle => 'No academic data yet';

  @override
  String get emptyHomeDescription =>
      'Start recording your grades or class schedule to see your summary here.';

  @override
  String get emptyGradesTitle => 'No grades recorded yet';

  @override
  String get emptyGradesDescription =>
      'Add your courses and semester grades to automatically calculate GPS and GPA.';

  @override
  String get emptyScheduleTitle => 'No schedule yet';

  @override
  String get emptyScheduleDescription =>
      'Set up your weekly schedule so you never miss a class session.';

  @override
  String get emptyTasksTitle => 'No tasks';

  @override
  String get emptyTasksDescription =>
      'You are all caught up. Add a new task whenever you have an upcoming deadline.';

  @override
  String get emptyCompletedTasksTitle => 'No completed tasks yet';

  @override
  String get emptyCompletedTasksDescription =>
      'Mark active tasks as completed to view your completion history here.';

  @override
  String get emptyEventsTitle => 'No events';

  @override
  String get emptyEventsDescription =>
      'There are no campus or organization events scheduled on the selected date.';

  @override
  String get emptySettingsDescription =>
      'Manage your profile, language, grade conversion, notifications, and data backup.';

  @override
  String get errorLoadData => 'Failed to load data';

  @override
  String get permissionNotificationDeniedBanner =>
      'Notification permission denied. Enable it in settings to receive timely reminders.';

  @override
  String get statIpkLabel => 'GPA';

  @override
  String statIpsSemesterLabel(int semester) {
    return 'GPS $semester';
  }

  @override
  String get statCompletedSksLabel => 'Completed Credits';

  @override
  String get statCompletedCoursesLabel => 'Completed Courses';

  @override
  String get filterAllSemesters => 'All';

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
    return '$sks Credits';
  }

  @override
  String get gradeNeedsRetake => 'Retake required';

  @override
  String get gradeRetakeBadge => 'Retake';

  @override
  String get gradeUsedInIpk => 'Counted in GPA';

  @override
  String get gradeNotUsedInIpk => 'History (not counted in GPA)';

  @override
  String gradeRetakeOfInfo(int semester, String gradeIndex) {
    return 'Retake of Sem $semester ($gradeIndex)';
  }

  @override
  String get gradeFormAddTitle => 'Add Grade';

  @override
  String get gradeFormEditTitle => 'Edit Grade';

  @override
  String get gradeFieldCourseNameLabel => 'Course Name';

  @override
  String get gradeFieldCourseNameHint => 'Example: Basic Statistics';

  @override
  String get gradeFieldCourseNameError =>
      'Course name is required. Enter the course name.';

  @override
  String get gradeFieldSemesterLabel => 'Semester (1–14)';

  @override
  String get gradeFieldSemesterError =>
      'Invalid semester. Select a semester between 1 and 14.';

  @override
  String get gradeFieldSksLabel => 'Credits (SKS)';

  @override
  String get gradeFieldSksHint => 'Example: 3';

  @override
  String get gradeFieldSksError =>
      'Invalid credits. Enter a number greater than 0.';

  @override
  String get gradeFieldIndexLabel => 'Grade Index';

  @override
  String get gradeFieldRetakeLabel => 'Retake / Improvement of (Optional)';

  @override
  String get gradeRetakeNoneOption => 'Not a retake (New course)';

  @override
  String gradeRetakeSuggestionBanner(
    String courseName,
    int semester,
    String gradeIndex,
  ) {
    return 'Found \"$courseName\" in Semester $semester (grade $gradeIndex). Link as a retake?';
  }

  @override
  String get gradeRetakeLinkAction => 'Link';

  @override
  String get gradeDeleteDialogTitle => 'Delete Course Grade?';

  @override
  String gradeDeleteDialogMessage(String courseName, int semester) {
    return 'Entry \"$courseName\" (Semester $semester) will be deleted and your GPA will be recalculated.';
  }

  @override
  String get toastGradeSaved => 'Grade saved';

  @override
  String get toastGradeDeleted => 'Grade deleted';

  @override
  String semanticsCourseGradeCard(
    String courseName,
    int sks,
    String gradeIndex,
    int semester,
  ) {
    return '$courseName, $sks credits, grade $gradeIndex, semester $semester';
  }

  @override
  String semanticsGradeIndexOption(String gradeIndex) {
    return 'Grade index $gradeIndex';
  }

  @override
  String get dayAll => 'All';

  @override
  String get dayMonday => 'Monday';

  @override
  String get dayTuesday => 'Tuesday';

  @override
  String get dayWednesday => 'Wednesday';

  @override
  String get dayThursday => 'Thursday';

  @override
  String get dayFriday => 'Friday';

  @override
  String get daySaturday => 'Saturday';

  @override
  String get daySunday => 'Sunday';

  @override
  String get dayShortMon => 'Mon';

  @override
  String get dayShortTue => 'Tue';

  @override
  String get dayShortWed => 'Wed';

  @override
  String get dayShortThu => 'Thu';

  @override
  String get dayShortFri => 'Fri';

  @override
  String get dayShortSat => 'Sat';

  @override
  String get dayShortSun => 'Sun';

  @override
  String get scheduleFormAddTitle => 'Add Class Schedule';

  @override
  String get scheduleFormEditTitle => 'Edit Class Schedule';

  @override
  String get scheduleFieldDayLabel => 'Class Day';

  @override
  String get scheduleFieldStartTimeLabel => 'Start Time (HH:MM)';

  @override
  String get scheduleFieldStartTimeHint => '08:00';

  @override
  String get scheduleFieldEndTimeLabel => 'End Time (HH:MM)';

  @override
  String get scheduleFieldEndTimeHint => '10:00';

  @override
  String get scheduleFieldTimeFormatError =>
      'Invalid time format. Use HH:MM format (e.g. 08:30).';

  @override
  String get scheduleFieldEndTimeError => 'End time must be after start time.';

  @override
  String get scheduleFieldRoomLabel => 'Room';

  @override
  String get scheduleFieldRoomHint => 'Example: Building A R.302';

  @override
  String get scheduleFieldRoomError =>
      'Room is required. Enter the room name or code.';

  @override
  String scheduleConflictWarning(String courseName, String timeRange) {
    return 'Schedule conflicts with \"$courseName\" ($timeRange). You can still save this schedule.';
  }

  @override
  String get scheduleDeleteDialogTitle => 'Delete Class Schedule?';

  @override
  String scheduleDeleteDialogMessage(String courseName, String dayName) {
    return 'Schedule \"$courseName\" ($dayName) will be deleted.';
  }

  @override
  String get toastScheduleSaved => 'Schedule saved';

  @override
  String get toastScheduleDeleted => 'Schedule deleted';

  @override
  String get attendanceSheetTitle => 'Class Attendance';

  @override
  String get attendanceDateLabel => 'Session Date';

  @override
  String get attendanceStatusLabel => 'Attendance Status';

  @override
  String get attendanceStatusPresent => 'Present';

  @override
  String get attendanceStatusSick => 'Sick';

  @override
  String get attendanceStatusPermission => 'Excused';

  @override
  String get attendanceStatusAbsent => 'Absent';

  @override
  String get attendanceNotesLabel => 'Session Notes';

  @override
  String get attendanceNotesHint => 'Example: Discussed Chapter 3';

  @override
  String get attendanceRecordedAtInfo => 'Recorded automatically upon saving';

  @override
  String get toastAttendanceSaved => 'Attendance saved';

  @override
  String get attendanceRecapTitle => 'Attendance Recap per Course';

  @override
  String get attendanceRecapEmpty => 'No attendance records yet.';

  @override
  String attendanceRecapSummary(
    int presentCount,
    int totalCount,
    String percentage,
  ) {
    return '$presentCount Present of $totalCount sessions ($percentage%)';
  }

  @override
  String attendanceRecapBreakdown(
    int present,
    int sick,
    int permission,
    int absent,
  ) {
    return 'Present: $present · Sick: $sick · Excused: $permission · Absent: $absent';
  }

  @override
  String semanticsScheduleCard(
    String courseName,
    String dayName,
    String timeRange,
    String room,
  ) {
    return '$courseName, $dayName at $timeRange, room $room';
  }

  @override
  String get calendarPrevMonth => 'Previous month';

  @override
  String get calendarNextMonth => 'Next month';

  @override
  String get calendarClearDateFilter => 'Show all dates';

  @override
  String semanticsCalendarDayMarkers(int day, int month, int year, int count) {
    return 'Date $day/$month/$year, $count markers';
  }

  @override
  String get taskTabActive => 'Active';

  @override
  String get taskTabCompleted => 'Completed (Recap)';

  @override
  String get taskFormAddTitle => 'Add Course Task';

  @override
  String get taskFormEditTitle => 'Edit Course Task';

  @override
  String get taskFieldDescriptionLabel => 'Task Description';

  @override
  String get taskFieldDescriptionHint => 'Example: Lab Report Module 2';

  @override
  String get taskFieldDescriptionError =>
      'Task description is required. Enter a brief description.';

  @override
  String get taskFieldDueDateLabel => 'Due Date (YYYY-MM-DD)';

  @override
  String get taskFieldDueDateHint => '2026-11-05';

  @override
  String get taskFieldDueDateError =>
      'Invalid date format. Use YYYY-MM-DD format.';

  @override
  String get taskFieldDueTimeLabel => 'Due Time (HH:MM)';

  @override
  String get taskFieldDueTimeHint => '23:59';

  @override
  String get taskStatusOverdue => 'Overdue';

  @override
  String taskStatusUrgentHours(int hours) {
    return 'Urgent · ${hours}h left';
  }

  @override
  String taskStatusRemainingDays(int days) {
    return '$days days left';
  }

  @override
  String taskCompletedAtLabel(String dateTime) {
    return 'Completed on $dateTime';
  }

  @override
  String get taskMarkComplete => 'Mark task as completed';

  @override
  String get taskUnmarkComplete => 'Unmark task completion';

  @override
  String get taskDeleteDialogTitle => 'Delete Course Task?';

  @override
  String taskDeleteDialogMessage(String courseName) {
    return 'Task \"$courseName\" will be deleted.';
  }

  @override
  String get toastTaskSaved => 'Task saved';

  @override
  String get toastTaskCompleted => 'Task completed';

  @override
  String get toastTaskUncompleted => 'Task returned to active list';

  @override
  String get toastTaskDeleted => 'Task deleted';

  @override
  String get eventFormAddTitle => 'Add Campus Event';

  @override
  String get eventFormEditTitle => 'Edit Campus Event';

  @override
  String get eventFieldNameLabel => 'Event Name';

  @override
  String get eventFieldNameHint => 'Example: Student Council Meeting';

  @override
  String get eventFieldNameError =>
      'Event name is required. Enter the event name.';

  @override
  String get eventFieldDescriptionLabel => 'Event Description';

  @override
  String get eventFieldDescriptionHint =>
      'Example: Discussing this semester\'s work program';

  @override
  String get eventFieldDescriptionError =>
      'Event description is required. Enter a brief description.';

  @override
  String get eventFieldDateLabel => 'Event Date (YYYY-MM-DD)';

  @override
  String get eventFieldDateHint => '2026-11-10';

  @override
  String get eventDeleteDialogTitle => 'Delete Event?';

  @override
  String eventDeleteDialogMessage(String eventName) {
    return 'Event \"$eventName\" will be deleted.';
  }

  @override
  String get toastEventSaved => 'Event saved';

  @override
  String get toastEventDeleted => 'Event deleted';

  @override
  String get semanticsLoading => 'Loading';

  @override
  String get semanticsOpenSettings => 'Open Profile and App Settings';

  @override
  String homeGreeting(String name) {
    return 'Hello, $name!';
  }

  @override
  String get homeDefaultStudentName => 'Student';

  @override
  String get homeTodayScheduleTitle => 'Today\'s Schedule';

  @override
  String get homeTodayScheduleEmpty => 'No classes scheduled for today.';

  @override
  String get homeWeekTasksTitle => 'Tasks Due Within 7 Days';

  @override
  String get homeWeekTasksEmpty => 'No tasks due within the next 7 days.';

  @override
  String get homeIpsTrendTitle => 'Semester GPS Trend';

  @override
  String get homeIpsTrendEmpty =>
      'Add course grades to view your semester GPS trend.';

  @override
  String get homeGradeDistributionTitle =>
      'Grade Distribution (Effective Entries)';

  @override
  String get homeGradeDistributionEmpty =>
      'No grade distribution recorded yet.';

  @override
  String get homeChartTableSummaryLabel => 'Accessible Chart Summary';

  @override
  String get actionExport => 'Export';

  @override
  String get exportSheetTitle => 'Export Document / Image';

  @override
  String get exportScopeLabel => 'Data Scope';

  @override
  String get exportScopeHomeStats =>
      'Home Statistics (GPA & Grade Distribution)';

  @override
  String get exportScopeAllGrades => 'All Semesters Transcript & GPA';

  @override
  String get exportScopeScheduleAttendance =>
      'Weekly Schedule & Attendance Recap';

  @override
  String get exportFormatLabel => 'File Format';

  @override
  String get exportFormatPdf => 'PDF';

  @override
  String get exportFormatPng => 'PNG (Image)';

  @override
  String get exportFormatJpg => 'JPG';

  @override
  String get exportGenerateAndShare => 'Export';

  @override
  String get exportProgressLoading => 'Generating export file...';

  @override
  String get toastExportSuccess => 'Export file is ready to share';

  @override
  String get errorExportFailed => 'Failed to generate export file';

  @override
  String get settingsGroupAccount => 'Account & Profile';

  @override
  String get settingsGroupPreferences => 'Academic Preferences';

  @override
  String get settingsGroupData => 'Reminders & Local Data';

  @override
  String get settingsGroupAbout => 'About & Support';

  @override
  String get settingsEditProfileTitle => 'Student Profile';

  @override
  String get settingsEditProfileSubtitle =>
      'Update biodata and local profile photo';

  @override
  String get settingsPickPhotoGallery => 'Choose from Gallery';

  @override
  String get settingsPickPhotoCamera => 'Take Camera Photo';

  @override
  String get settingsRemovePhoto => 'Remove Photo';

  @override
  String get toastProfileUpdated => 'Profile updated';

  @override
  String get settingsLanguageTitle => 'App Language';

  @override
  String get settingsLanguageIndonesian => 'Indonesia';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get toastLanguageChanged => 'Language updated';

  @override
  String get settingsConversionTitle => 'Grade Conversion';

  @override
  String get settingsConversionSubtitle =>
      'Grade weights and conversion customization';

  @override
  String get settingsMinPassingGradeLabel => 'Minimum Passing Grade';

  @override
  String get settingsRetakeRuleLabel => 'Retake Grade Rule (GPA)';

  @override
  String get settingsRetakeRuleHighest => 'Highest Grade (Default)';

  @override
  String get settingsRetakeRuleLatest => 'Latest Grade';

  @override
  String get settingsResetConversion => 'Reset';

  @override
  String get toastConversionSaved =>
      'Conversion rules saved & GPA recalculated';

  @override
  String get settingsFormulaGuideTitle => 'GPS & GPA Formula Guide';

  @override
  String get settingsFormulaGuideSubtitle =>
      'Explanation of grade calculation and retakes';

  @override
  String get formulaGuideBody =>
      '1. Semester GPS is historical: Σ(weight × credits) / Σ credits of all entries in that semester (including E grades and retakes).\n\n2. GPA: Σ(weight × credits) / Σ credits using one effective entry per course group (highest grade by default, or latest grade).\n\n3. Grade E always requires a retake (not passed). Before retaking, E is included in the GPA denominator (weight 0). After retaking, the new grade replaces E in GPA while historical Semester GPS remains unchanged.\n\n4. Completed Credits and Completed Courses count each course group whose effective entry passes (≥ minimum passing grade).';

  @override
  String get settingsNotificationsTitle => 'Reminders & Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Configure schedule, task, and event reminders';

  @override
  String get settingsNotifyScheduleLabel => 'Class Schedule Reminders';

  @override
  String get settingsNotifyTaskLabel => 'Task Deadline Reminders';

  @override
  String get settingsNotifyEventLabel => 'Campus Event Reminders';

  @override
  String settingsReminderOffsetMinutes(int minutes) {
    return '$minutes min before';
  }

  @override
  String get toastNotificationsSaved => 'Notification settings saved';

  @override
  String get settingsBackupTitle => 'Backup & Restore Data';

  @override
  String get settingsBackupSubtitle =>
      'Export or restore all data as JSON (Offline)';

  @override
  String get backupNeverInfo => 'No backup created yet';

  @override
  String backupLastAtInfo(String dateTime) {
    return 'Last backup: $dateTime';
  }

  @override
  String get backupGuideBody =>
      'Keep your backup JSON file in a safe folder or personal cloud drive. When switching devices, select that file via Restore.';

  @override
  String get actionCreateBackup => 'Create JSON Backup';

  @override
  String get actionRestoreBackup => 'Select File & Restore';

  @override
  String get restoreConfirmTitle => 'Restore Data from Backup?';

  @override
  String get restoreConfirmDescription =>
      'All current local data will be replaced by the backup file contents. Slide to confirm restoration.';

  @override
  String get slideToRestoreLabel => 'Slide to Restore';

  @override
  String get toastBackupCreated => 'Backup created successfully';

  @override
  String get toastRestoreSuccess =>
      'Restore completed. All data has been restored.';

  @override
  String get errorBackupInvalid =>
      'Invalid file or mismatched schema version. Existing data remains safe.';

  @override
  String get settingsAboutAppTitle => 'About Application';

  @override
  String get settingsAboutAppSubtitle =>
      'Version 1.0.0 · MIT License · Open Source';

  @override
  String get aboutAppDescription =>
      'Nguliah is an ad-free, offline-first Android application helping university students manage grades, schedules, attendance, tasks, and campus events.';

  @override
  String get aboutAppLicenseLabel =>
      'License: MIT License (Public GitHub Repository)';

  @override
  String get settingsAboutDevTitle => 'About Developer & Support';

  @override
  String get settingsAboutDevSubtitle =>
      'Developer profile & voluntary support (QRIS)';

  @override
  String get aboutDevDescription =>
      'Openly developed for Indonesian university students. If this app helps you, you can support the developer via QRIS below.';

  @override
  String get qrisCardTitle => 'Support via QRIS (Buy Me a Coffee)';

  @override
  String get semanticsQrisImage =>
      'Static QRIS payment code image to support the Nguliah developer';

  @override
  String get permissionMediaDeniedBanner =>
      'Camera/gallery permission denied. Use profile initials or enable permission in System Settings.';

  @override
  String get permissionStorageDeniedBanner =>
      'Storage/file picker permission denied. Enable permission in System Settings to continue.';

  @override
  String get authRestoreOption => 'Already have a backup? Restore Data';

  @override
  String get homeUpcomingEventsTitle => 'Events in the Next 7 Days';

  @override
  String get homeUpcomingEventsEmpty =>
      'No campus events scheduled for the next 7 days.';

  @override
  String get homeChartToggleBar => 'Bar Chart';

  @override
  String get homeChartTogglePie => 'Pie Chart (%)';

  @override
  String get attendanceStatusDispensation => 'Dispensation';

  @override
  String attendanceRestrictedOutsideClass(String timeRange) {
    return 'Attendance can only be recorded during class hours ($timeRange). Outside class hours, it is recorded as Absent.';
  }

  @override
  String get attendanceCountMeetingsLabel => 'Total Meetings';

  @override
  String get attendanceCountPresentLabel => 'Total Attendance';

  @override
  String get attendancePercentageLabel => 'Attendance Rate';

  @override
  String get attendanceSlideToConfirmEdit => 'Slide to Save Changes';

  @override
  String get taskConfirmCompleteTitle => 'Mark Task as Completed?';

  @override
  String taskConfirmCompleteMessage(String taskTitle) {
    return 'Task \"$taskTitle\" will be moved to completed list.';
  }

  @override
  String get taskConfirmUncompleteTitle => 'Return Task to Active?';

  @override
  String taskConfirmUncompleteMessage(String taskTitle) {
    return 'Task \"$taskTitle\" will be returned to active list.';
  }

  @override
  String get eventTabActive => 'Active Events';

  @override
  String get eventTabCompleted => 'Completed (Recap)';

  @override
  String get eventFieldLocationLabel => 'Event Location';

  @override
  String get eventFieldLocationHint => 'Example: Hall Building B / Zoom';

  @override
  String get settingsThemeModeTitle => 'Theme Mode';

  @override
  String get settingsThemeModeLight => 'Light';

  @override
  String get settingsThemeModeDark => 'Dark';

  @override
  String get settingsCustomReminderMinutesLabel =>
      'Reminder Time (Minutes Before)';

  @override
  String get settingsCustomReminderMinutesHint => 'Example: 30';

  @override
  String get toastDeviceNotificationActive =>
      'Device notification permission is active';

  @override
  String get toastDeviceNotificationDenied =>
      'Device notification permission denied/not enabled';

  @override
  String get settingsEnableDeviceNotification => 'Device Notifications';

  @override
  String get settingsEnableDeviceNotificationSubtitle =>
      'Manage system notification settings & permissions';

  @override
  String get settingsOpenSystemSettings => 'Open System Notification Settings';

  @override
  String get settingsLogoutTitle => 'Log Out';

  @override
  String get settingsLogoutSubtitle =>
      'Clear profile session and return to Login screen';

  @override
  String get settingsLogoutDialogTitle => 'Log out of Account?';

  @override
  String get settingsLogoutDialogMessage =>
      'Academic data remains safely on this device. You will be redirected to the Login screen.';

  @override
  String get settingsAddGradeConversion => 'Add Grade Index';

  @override
  String get settingsGradeIndexLabel => 'Grade Letter Index';

  @override
  String get settingsGradeIndexHint => 'Example: A-';

  @override
  String get settingsGradeWeightLabel => 'Weight';

  @override
  String get settingsGradeWeightHint => 'Example: 3.75';

  @override
  String get settingsDeleteGradeIndexTitle => 'Delete Grade Index?';

  @override
  String settingsDeleteGradeIndexMessage(String index) {
    return 'Index \"$index\" will be deleted from conversion rules.';
  }

  @override
  String get settingsDeveloperPhotoGuide =>
      'Place developer photo at assets/images/developer.png and QRIS photo at assets/images/qris.png';

  @override
  String get settingsExportSectionTitle => 'Export Documents & Data';

  @override
  String get settingsExportStatsTitle => 'Export Statistics & GPA';

  @override
  String get settingsExportGradesTitle => 'Export Transcript (All Semesters)';

  @override
  String get settingsExportScheduleTitle =>
      'Export Schedule & Attendance Recap';

  @override
  String get gradeFormSlideDropdownHint => 'Select Grade Index';

  @override
  String get gradeFieldSemesterTypedHint => '1 - 14';

  @override
  String get gradesIpkTitle => 'GPA';

  @override
  String get gradesCompletedSksTitle => 'Completed Credits';

  @override
  String get gradesCompletedCoursesTitle => 'Completed Courses';

  @override
  String get taskCancelConfirmTitle => 'Revert Task Completion?';

  @override
  String get taskCompleteConfirmTitle => 'Complete Course Task?';

  @override
  String get taskCancelConfirmMessage =>
      'The task status will be changed back to active.';

  @override
  String get taskCompleteConfirmMessage => 'Have you completed this task?';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get attendanceMeetingHistoryTitle => 'Course Meeting Details';

  @override
  String get attendanceOutsideHoursWarning =>
      'Attendance outside class hours is automatically recorded as Absent.';

  @override
  String get settingsEditGradeConversion => 'Edit Grade Index';

  @override
  String get taskActionUncomplete => 'Undo Complete';

  @override
  String get emptyCompletedEventsTitle => 'No completed events';

  @override
  String get emptyCompletedEventsDescription =>
      'No completed campus events yet.';

  @override
  String get settingsHideScoresTitle => 'Hide Academic Scores';

  @override
  String get settingsHideScoresSubtitle =>
      'Censor GPA, GPS, completed credits and courses with asterisks *';

  @override
  String get settingsConfirmSaveConversionTitle => 'Save Grade Conversion?';

  @override
  String get settingsConfirmSaveConversionMessage =>
      'Changes to grade conversion will affect GPA and GPS calculations. Save now?';

  @override
  String get settingsConfirmDeleteConversionTitle => 'Delete Grade Index?';

  @override
  String get settingsConfirmDeleteConversionMessage =>
      'Are you sure you want to delete this grade index from the conversion list?';

  @override
  String get shortIpsLabel => 'GPS';

  @override
  String get shortIpkLabel => 'GPA';
}
