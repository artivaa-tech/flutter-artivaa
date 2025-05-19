
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'infrastructure/config/build_config.dart';
import 'infrastructure/config/env_config.dart';
import 'infrastructure/config/environment.dart';
import 'infrastructure/constants/app_constants.dart';
import 'infrastructure/shared/pref_manager.dart';


class Initializer {
  static Future<void> init() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      EnvConfig devConfig = EnvConfig(
        appName: "ONIT",
        baseUrl: '',
        baseUrlGooglePlace: '',
        shouldCollectCrashLog: true,
      );
      BuildConfig.instantiate(
        envType: Environment.development,
        envConfig: devConfig,
      );
      _initScreenPreference();
      await changeTheme();
    } catch (err) {
      rethrow;
    }
  }

  static changeTheme() async {
    var selectedTheme = await PrefManager.getString(AppConstants.isSelectedTheme);
    ThemeMode themeMode = (selectedTheme == "dark") ? ThemeMode.dark : ThemeMode.light;

    if(selectedTheme.toString().isEmpty){
      if(ThemeMode.system==ThemeMode.dark){
        PrefManager.putString(AppConstants.isSelectedTheme,"dark");
      }
      else{
        PrefManager.putString(AppConstants.isSelectedTheme,"light");
      }
      themeMode = ThemeMode.dark;
    }

    PrefManager.putString(AppConstants.isSelectedTheme,"dark");
    themeMode = ThemeMode.dark;
    Get.changeThemeMode(themeMode);
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

}


