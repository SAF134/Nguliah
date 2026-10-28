import 'package:isar_community/isar.dart';

part 'user_profile_model.g.dart';

/// Model Isar untuk koleksi Profil mahasiswa (satu pengguna per perangkat).
@collection
class UserProfile {
  UserProfile({
    this.id = 1,
    required this.name,
    required this.university,
    required this.faculty,
    required this.major,
    required this.entryYear,
    this.photoPath,
    required this.updatedAt,
  });

  Id id;

  late String name;
  late String university;
  late String faculty;
  late String major;
  late int entryYear;
  String? photoPath;
  late DateTime updatedAt;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'name': name,
    'university': university,
    'faculty': faculty,
    'major': major,
    'entryYear': entryYear,
    'photoPath': photoPath,
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: (json['id'] as num?)?.toInt() ?? 1,
    name: json['name'] as String,
    university: json['university'] as String,
    faculty: json['faculty'] as String,
    major: json['major'] as String,
    entryYear: (json['entryYear'] as num).toInt(),
    photoPath: json['photoPath'] as String?,
    updatedAt: DateTime.parse(json['updatedAt'] as String),
  );
}
