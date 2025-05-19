import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'infrastructure/local/app_translations.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'infrastructure/shared/one_signal.dart';
import 'infrastructure/theme/theme.dart';
import 'initializer.dart';

/*
* firebase and gmail
* email - onit2838@gmail.com
 pass - rajat@123
* */

/*one signal creadiantionals
* one signal id ="976fbc20-109c-4d8f-8824-d959a5bc0899";
* user name => onit.appentus@gmail.com
  password => Appentus#8233
 */

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Initializer.init();
  await OneSignalClass().initOneSignal();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: GetMaterialApp(
          initialRoute: Routes.splash,
          getPages: AppPages.pageList,
          debugShowCheckedModeBanner: false,
          //theme: themeData,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          builder: (context, Widget? child) {
            final MediaQueryData data = MediaQuery.of(context);
            return MediaQuery(
              data: data.copyWith(textScaleFactor: 1.1),
              child: child!,
            );
          },
          supportedLocales: AppTranslations.locales,
          locale: AppTranslations.locale,
          fallbackLocale: AppTranslations.fallbackLocale,
          translations: AppTranslations(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      );
    });
  }

}

