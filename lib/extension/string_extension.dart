extension StringExtension on String {

  String get firstLetterCapitalized {
    return this[0].toUpperCase() + substring(1);
  }
}