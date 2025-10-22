import 'package:domain/domain.dart';

/// Modèle de données pour l'utilisateur
class UserModel {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;
  
  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });
  
  /// Conversion depuis JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
  
  /// Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
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

