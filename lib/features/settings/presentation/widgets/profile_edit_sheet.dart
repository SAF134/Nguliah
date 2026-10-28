import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nguliah/core/theme/app_tokens.dart';
import 'package:nguliah/core/theme/app_typography.dart';
import 'package:nguliah/core/utils/l10n_extension.dart';
import 'package:nguliah/core/widgets/app_text_field.dart';
import 'package:nguliah/core/widgets/primary_button.dart';
import 'package:nguliah/core/widgets/profile_avatar.dart';
import 'package:nguliah/core/widgets/secondary_button.dart';
import 'package:nguliah/data/models/user_profile_model.dart';
import 'package:path_provider/path_provider.dart';

/// Bottom sheet untuk mengubah biodata dan foto profil lokal mahasiswa.
class ProfileEditSheet extends StatefulWidget {
  const ProfileEditSheet({
    required this.initialProfile,
    required this.onSave,
    super.key,
  });

  final UserProfile? initialProfile;
  final Future<void> Function(UserProfile updated) onSave;

  @override
  State<ProfileEditSheet> createState() => _ProfileEditSheetState();
}

class _ProfileEditSheetState extends State<ProfileEditSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _uniController;
  late final TextEditingController _facultyController;
  late final TextEditingController _majorController;
  late final TextEditingController _entryYearController;
  String? _avatarPath;

  String? _nameError;
  String? _uniError;
  String? _facultyError;
  String? _majorError;
  String? _entryYearError;
  String? _photoPermissionError;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final p = widget.initialProfile;
    _nameController = TextEditingController(text: p?.name ?? '');
    _uniController = TextEditingController(text: p?.university ?? '');
    _facultyController = TextEditingController(text: p?.faculty ?? '');
    _majorController = TextEditingController(text: p?.major ?? '');
    _entryYearController = TextEditingController(
      text: (p?.entryYear ?? DateTime.now().year).toString(),
    );
    _avatarPath = p?.photoPath;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _uniController.dispose();
    _facultyController.dispose();
    _majorController.dispose();
    _entryYearController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      if (picked != null && mounted) {
        String persistedPath = picked.path;
        try {
          final docsDir = await getApplicationDocumentsDirectory();
          final target = File(
            '${docsDir.path}/profile_avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
          );
          await File(picked.path).copy(target.path);
          persistedPath = target.path;
        } catch (_) {
          // Gunakan path asli bila direktori dokumen tidak tersedia di lingkungan tes
        }
        if (mounted) {
          setState(() {
            _avatarPath = persistedPath;
            _photoPermissionError = null;
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _photoPermissionError = context.l10n.permissionMediaDeniedBanner;
        });
      }
    }
  }

  Future<void> _submit() async {
    final l10n = context.l10n;
    final name = _nameController.text.trim();
    final uni = _uniController.text.trim();
    final faculty = _facultyController.text.trim();
    final major = _majorController.text.trim();
    final parsedYear = int.tryParse(_entryYearController.text.trim());

    setState(() {
      _nameError = name.length < 2 ? l10n.fieldFullNameError : null;
      _uniError = uni.isEmpty ? l10n.fieldUniversityError : null;
      _facultyError = faculty.isEmpty ? l10n.fieldFacultyError : null;
      _majorError = major.isEmpty ? l10n.fieldMajorError : null;
      _entryYearError =
          (parsedYear == null || parsedYear < 1900 || parsedYear > 2100)
          ? l10n.fieldRequired
          : null;
    });

    if (_nameError != null ||
        _uniError != null ||
        _facultyError != null ||
        _majorError != null ||
        _entryYearError != null ||
        parsedYear == null) {
      return;
    }

    setState(() => _isSaving = true);
    final now = DateTime.now();
    final updated = UserProfile(
      id: 1,
      name: name,
      university: uni,
      faculty: faculty,
      major: major,
      entryYear: parsedYear,
      photoPath: _avatarPath,
      updatedAt: now,
    );
    await widget.onSave(updated);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return Padding(
      padding: EdgeInsets.only(
        left: AppTokens.screenMargin,
        right: AppTokens.screenMargin,
        top: AppTokens.space20,
        bottom: viewInsets.bottom + AppTokens.space24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              l10n.settingsEditProfileTitle,
              style: AppTypography.h2(palette.text900),
            ),
            const SizedBox(height: AppTokens.space16),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: palette.primary, width: 2),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: palette.primary.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ProfileAvatar(
                      name: _nameController.text.trim().isNotEmpty
                          ? _nameController.text.trim()
                          : l10n.homeDefaultStudentName,
                      photoPath: _avatarPath,
                      radius: AppTokens.space32,
                    ),
                  ),
                  const SizedBox(height: AppTokens.space8),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: palette.primary,
                      side: BorderSide(color: palette.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppTokens.radiusFull,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTokens.space16,
                        vertical: AppTokens.space8,
                      ),
                    ),
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined, size: 18),
                    label: Text(l10n.settingsPickPhotoGallery),
                  ),
                ],
              ),
            ),
            if (_photoPermissionError != null) ...<Widget>[
              const SizedBox(height: AppTokens.space8),
              Semantics(
                liveRegion: true,
                child: Text(
                  _photoPermissionError!,
                  style: AppTypography.caption(palette.error),
                ),
              ),
            ],
            const SizedBox(height: AppTokens.space12),
            AppTextField(
              label: l10n.fieldFullNameLabel,
              hintText: l10n.fieldFullNameHint,
              controller: _nameController,
              errorText: _nameError,
            ),
            const SizedBox(height: AppTokens.space12),
            AppTextField(
              label: l10n.fieldUniversityLabel,
              hintText: l10n.fieldUniversityHint,
              controller: _uniController,
              errorText: _uniError,
            ),
            const SizedBox(height: AppTokens.space12),
            AppTextField(
              label: l10n.fieldFacultyLabel,
              hintText: l10n.fieldFacultyHint,
              controller: _facultyController,
              errorText: _facultyError,
            ),
            const SizedBox(height: AppTokens.space12),
            AppTextField(
              label: l10n.fieldMajorLabel,
              hintText: l10n.fieldMajorHint,
              controller: _majorController,
              errorText: _majorError,
            ),
            const SizedBox(height: AppTokens.space12),
            AppTextField(
              label: l10n.fieldEntryYearLabel,
              hintText: l10n.fieldEntryYearHint,
              controller: _entryYearController,
              errorText: _entryYearError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppTokens.space24),
            Row(
              children: <Widget>[
                Expanded(
                  child: SecondaryButton(
                    label: l10n.actionCancel,
                    onPressed: _isSaving
                        ? null
                        : () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppTokens.space12),
                Expanded(
                  child: PrimaryButton(
                    label: l10n.actionSave,
                    isLoading: _isSaving,
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
