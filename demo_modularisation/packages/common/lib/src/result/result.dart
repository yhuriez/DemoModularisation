/// Classe générique pour encapsuler le résultat d'une opération
/// qui peut réussir ou échouer
sealed class Result<T> {
  const Result();
}

/// Résultat de succès
class Success<T> extends Result<T> {
  final T data;
  
  const Success(this.data);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.data == data;
  }
  
  @override
  int get hashCode => data.hashCode;
}

/// Résultat d'échec
class Failure<T> extends Result<T> {
  final Exception exception;
  
  const Failure(this.exception);
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> && other.exception == exception;
  }
  
  @override
  int get hashCode => exception.hashCode;
}

/// Extensions pour faciliter l'utilisation de Result
extension ResultExtensions<T> on Result<T> {
  /// Retourne true si le résultat est un succès
  bool get isSuccess => this is Success<T>;
  
  /// Retourne true si le résultat est un échec
  bool get isFailure => this is Failure<T>;
  
  /// Récupère les données si succès, null sinon
  T? get dataOrNull {
    return switch (this) {
      Success(data: final data) => data,
      Failure() => null,
    };
  }
  
  /// Récupère l'exception si échec, null sinon
  Exception? get exceptionOrNull {
    return switch (this) {
      Success() => null,
      Failure(exception: final exception) => exception,
    };
  }
  
  /// Exécute une action selon le type de résultat
  R when<R>({
    required R Function(T data) success,
    required R Function(Exception exception) failure,
  }) {
    return switch (this) {
      Success(data: final data) => success(data),
      Failure(exception: final exception) => failure(exception),
    };
  }
}

