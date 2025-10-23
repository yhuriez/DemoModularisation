import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Modèle de données pour l'utilisateur
@freezed
class UserModel with _$UserModel {
  const UserModel._();
  
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    required DateTime createdAt,
  }) = _UserModel;
  
  /// Conversion depuis JSON
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  /// Conversion vers l'entité domain
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      createdAt: createdAt,
    );
  }
  
  /// Création depuis l'entité domain
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      createdAt: user.createdAt,
    );
  }
}

