/// Extensions utilitaires pour les chaînes de caractères
extension StringExtensions on String {
  /// Vérifie si la chaîne est un email valide
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(this);
  }
  
  /// Vérifie si la chaîne est un mot de passe valide (min 6 caractères)
  bool get isValidPassword {
    return length >= 6;
  }
  
  /// Capitalise la première lettre
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
  
  /// Vérifie si la chaîne est vide ou ne contient que des espaces
  bool get isBlank {
    return trim().isEmpty;
  }
}

