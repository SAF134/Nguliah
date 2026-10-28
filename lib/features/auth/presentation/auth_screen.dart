import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nguliah/core/router/app_routes.dart';
import 'package:nguliah/core/services/backup_service.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/app_logger.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/core/widgets/glass_card.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/features/auth/application/auth_providers.dart';

/// Layar Masuk (Biodata 5 kolom wajib tanpa akun/server) sesuai PRD.md & DESIGN.md.
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _nameController = TextEditingController();
  final _universityController = TextEditingController();
  final _facultyController = TextEditingController();
  final _majorController = TextEditingController();
  final _yearController = TextEditingController();

  final _nameFocus = FocusNode();
  final _universityFocus = FocusNode();
  final _facultyFocus = FocusNode();
  final _majorFocus = FocusNode();
  final _yearFocus = FocusNode();

  bool _submitted = false;
  bool _isSaving = false;
  bool _isRestoring = false;

  @override
  void dispose() {
    _nameController.dispose();
    _universityController.dispose();
    _facultyController.dispose();
    _majorController.dispose();
    _yearController.dispose();
    _nameFocus.dispose();
    _universityFocus.dispose();
    _facultyFocus.dispose();
    _majorFocus.dispose();
    _yearFocus.dispose();
    super.dispose();
  }

  bool get _isNameValid => _nameController.text.trim().length >= 2;
  bool get _isUniversityValid => _universityController.text.trim().isNotEmpty;
  bool get _isFacultyValid => _facultyController.text.trim().isNotEmpty;
  bool get _isMajorValid => _majorController.text.trim().isNotEmpty;
  bool get _isYearValid {
    final year = int.tryParse(_yearController.text.trim());
    return year != null && _yearController.text.trim().length == 4;
  }

  bool get _isFormValid =>
      _isNameValid &&
      _isUniversityValid &&
      _isFacultyValid &&
      _isMajorValid &&
      _isYearValid;

  Future<void> _handleSave() async {
    setState(() => _submitted = true);
    if (!_isFormValid || _isSaving) return;

    setState(() => _isSaving = true);
    try {
      await saveStudentBiodata(
        ref,
        name: _nameController.text,
        university: _universityController.text,
        faculty: _facultyController.text,
        major: _majorController.text,
        entryYear: int.parse(_yearController.text.trim()),
      );
      if (!mounted) return;
      context.go(AppRoutes.home);
    } catch (error, stackTrace) {
      AppLogger.error('Gagal menyimpan biodata mahasiswa', error, stackTrace);
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _handleRestoreBackup() async {
    final l10n = context.l10n;
    setState(() => _isRestoring = true);
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: const <String>['json'],
      );
      if (files.isEmpty) {
        if (mounted) setState(() => _isRestoring = false);
        return;
      }
      final filePath = files.first.path;
      if (filePath == null) {
        if (mounted) setState(() => _isRestoring = false);
        return;
      }

      final rawJson = await File(filePath).readAsString();
      final bundle = BackupService.parseAndValidateJson(rawJson);
      await ref.read(backupServiceProvider).applyRestoreBundle(bundle);

      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.toastRestoreSuccess)));
        context.go(AppRoutes.home);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isRestoring = false);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.errorBackupInvalid)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final palette = context.palette;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTokens.screenMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: AppTokens.space12),
              Center(
                child: Container(
                  width: AppTokens.space48 + AppTokens.space16,
                  height: AppTokens.space48 + AppTokens.space16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: palette.primary, width: 2),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: palette.primary.withValues(alpha: 0.22),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: AppTokens.space16),
              Semantics(
                header: true,
                child: Text(
                  l10n.screenAuthTitle,
                  style: AppTypography.h1(palette.text900),
                ),
              ),
              const SizedBox(height: AppTokens.space8),
              Text(
                l10n.screenAuthSubtitle,
                style: AppTypography.body(palette.text600),
              ),
              const SizedBox(height: AppTokens.space24),
              GlassCard(
                borderColor: palette.primary,
                borderWidth: 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AppTextField(
                      label: l10n.fieldFullNameLabel,
                      hintText: l10n.fieldFullNameHint,
                      controller: _nameController,
                      focusNode: _nameFocus,
                      textInputAction: TextInputAction.next,
                      errorText: _submitted && !_isNameValid
                          ? l10n.fieldFullNameError
                          : null,
                      onChanged: (_) {
                        if (_submitted) setState(() {});
                      },
                      onSubmitted: (_) => _universityFocus.requestFocus(),
                    ),
                    const SizedBox(height: AppTokens.space16),
                    AppTextField(
                      label: l10n.fieldUniversityLabel,
                      hintText: l10n.fieldUniversityHint,
                      controller: _universityController,
                      focusNode: _universityFocus,
                      textInputAction: TextInputAction.next,
                      errorText: _submitted && !_isUniversityValid
                          ? l10n.fieldUniversityError
                          : null,
                      onChanged: (_) {
                        if (_submitted) setState(() {});
                      },
                      onSubmitted: (_) => _facultyFocus.requestFocus(),
                    ),
                    const SizedBox(height: AppTokens.space16),
                    AppTextField(
                      label: l10n.fieldFacultyLabel,
                      hintText: l10n.fieldFacultyHint,
                      controller: _facultyController,
                      focusNode: _facultyFocus,
                      textInputAction: TextInputAction.next,
                      errorText: _submitted && !_isFacultyValid
                          ? l10n.fieldFacultyError
                          : null,
                      onChanged: (_) {
                        if (_submitted) setState(() {});
                      },
                      onSubmitted: (_) => _majorFocus.requestFocus(),
                    ),
                    const SizedBox(height: AppTokens.space16),
                    AppTextField(
                      label: l10n.fieldMajorLabel,
                      hintText: l10n.fieldMajorHint,
                      controller: _majorController,
                      focusNode: _majorFocus,
                      textInputAction: TextInputAction.next,
                      errorText: _submitted && !_isMajorValid
                          ? l10n.fieldMajorError
                          : null,
                      onChanged: (_) {
                        if (_submitted) setState(() {});
                      },
                      onSubmitted: (_) => _yearFocus.requestFocus(),
                    ),
                    const SizedBox(height: AppTokens.space16),
                    AppTextField(
                      label: l10n.fieldEntryYearLabel,
                      hintText: 'Contoh: 2026',
                      controller: _yearController,
                      focusNode: _yearFocus,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      errorText: _submitted && !_isYearValid
                          ? l10n.fieldEntryYearError
                          : null,
                      onChanged: (_) {
                        if (_submitted) setState(() {});
                      },
                      onSubmitted: (_) => _handleSave(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTokens.space24),
              PrimaryButton(
                label: l10n.actionSaveAndStart,
                icon: Icons.check_rounded,
                isLoading: _isSaving,
                onPressed: _handleSave,
              ),
              const SizedBox(height: AppTokens.space16),
              Center(
                child: SecondaryButton(
                  label: l10n.authRestoreOption,
                  icon: Icons.restore_page_outlined,
                  variant: SecondaryButtonVariant.text,
                  enabled: !_isRestoring && !_isSaving,
                  onPressed: _handleRestoreBackup,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
