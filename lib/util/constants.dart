class ErrorMessage {
  static String titleErrorMessage = "title must be at least 4 characters.";
  static String descriptionErrorMessage =
      "description must be at least 6 characters.";
  static String fromToTimeErrorMessage = "please set task times before adding.";
  static String toTimeErrorMessage = "end time must be after start time.";
  static String toTimeEmptyErrorMessage = "please set to time.";
  static String fromTimeEmptyErrorMessage = "please set from time.";
}

enum TaskColor {
  bubblegumBlush, // FDEAEB
  lavenderMist, // F4EFFE
  mintCream, // EFFDEA
  cherryBlossom, // FDEAF9
  aquaHaze // E5FFFC
}

enum SharedPreferenceKeys {
  isBiometricEnabled,
}
