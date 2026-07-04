import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserRole { user, bd, admin, superAdmin }

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String name,
    required String email,
    String? phoneNumber,
    @Default(UserRole.user) UserRole role,
    @Default(0) int coins,
    @Default(0) int diamonds,
    @Default(1) int level,
    String? agencyId,
    String? profileImage,
    @Default(0) int followers,
    @Default(0) int following,
    @Default(0) int likes,
    @Default(false) bool isVip,
    @Default([]) List<String> guildIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
