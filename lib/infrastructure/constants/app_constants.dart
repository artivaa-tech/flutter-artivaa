// Dart imports:
import 'dart:math' as math;

/// Note that the userID needs to be globally unique,
final String locaLiveID = math.Random().nextInt(10000).toString();
const bool isHost = true;

class AppConstants{

  static const int loggerLineLength = 120;
  static const int loggerErrorMethodCount = 8;
  static const int loggerMethodCount = 2;


  static String isSelectedTheme = 'isSelectedTheme';

  static String apiToken = 'apiToken';
  static String userData = 'userData';

  static String fcmToken  = "fcmToken";
  static String loggedIn  = "loggedIn";

  static String selectedLanguage =  "selectedLanguage";
  static String selectedTheme =  "selectedTheme";

  static String profileToggleStatus =  "profileToggleStatus";

  static String socketUrl = 'http://54.205.45.174:3000';
  static String oneSignalID = 'oneSignalID';



}