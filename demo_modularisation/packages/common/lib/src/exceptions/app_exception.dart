/// Exception de base pour l'application
abstract class AppException implements Exception {
  final String message;
  final String? code;
  
  const AppException(this.message, [this.code]);
  
  @override
  String toString() => 'AppException: $message${code != null ? ' (code: $code)' : ''}';
}

/// Exception d'authentification
class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
  
  @override
  String toString() => 'AuthException: $message${code != null ? ' (code: $code)' : ''}';
}

/// Exception réseau
class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
  
  @override
  String toString() => 'NetworkException: $message${code != null ? ' (code: $code)' : ''}';
}

/// Exception de stockage
class StorageException extends AppException {
  const StorageException(super.message, [super.code]);
  
  @override
  String toString() => 'StorageException: $message${code != null ? ' (code: $code)' : ''}';
}

/// Exception de validation
class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
  
  @override
  String toString() => 'ValidationException: $message${code != null ? ' (code: $code)' : ''}';
}

/// Exception serveur
class ServerException extends AppException {
  const ServerException(super.message, [super.code]);
  
  @override
  String toString() => 'ServerException: $message${code != null ? ' (code: $code)' : ''}';
}

