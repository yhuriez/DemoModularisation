import 'package:equatable/equatable.dart';

/// Entité représentant un utilisateur
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;
  
  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });
  
  @override
  List<Object?> get props => [id, email, name, createdAt];
  
  /// Copie avec modification
  User copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  @override
  String toString() => 'User(id: $id, email: $email, name: $name)';
}

