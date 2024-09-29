import 'package:sync_tasks/util/config/dev_config.dart';
import 'package:sync_tasks/util/config/prod_config.dart';

class Constants {
  static Map<String, String> config =
      const String.fromEnvironment('ENV', defaultValue: 'dev') == "dev"
          ? devConfig
          : prodConfig;

  static GeminiAIConstants geminiAIConstants = GeminiAIConstants(
      endPoint: config["google-gemini-url"] ?? "",
      apiKey: config["google-gemini-APIKey"] ?? "");

  static String geminiAIPrompt =
      "Need task motivational statement of the day in 50 words";
}

class GeminiAIConstants {
  final String endPoint;
  final String apiKey;

  const GeminiAIConstants({required this.endPoint, required this.apiKey});
}

class ErrorMessage {
  static String titleErrorMessage = "title must be at least 4 characters.";
  static String descriptionErrorMessage =
      "description must be at least 6 characters.";
  static String fromToTimeErrorMessage = "please set task times before adding.";
  static String toTimeEmptyErrorMessage = "please set to time.";
  static String fromTimeEmptyErrorMessage = "please set from time.";
  static String connectInternetError = "please connect to internet.";
  static String emailNotFoundError = "email not found.";
  static String signOutFailureError = "signOut Failed.";
  static String deleteAccountFailureError = "delete account Failed.";

  static String userDetailsNotFound = "user details not found.";
}

class SuccessMessage {
  static String loginSuccessMessage = "login success.";
  static String logoutSuccessMessage = "successfully logged out.";
  static String deleteSuccessMessage = "account successfully deleted.";
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

enum HiveBoxes { taskBox, userBox, aiBox }

enum HiveKey { userData, aiData }
