import 'package:artivaa/infrastructure/shared/pref_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../res.dart';
import '../constants/app_constants.dart';
import '../theme/colors.theme.dart';
import '../theme/text.theme.dart';
import 'auth_type_enum.dart';

var postCategoryFilter = ["SOCIAL", "PROFESSIONAL", "MYCIRCLE"];

class CommonFunction {


  static String greetingMessage() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Hello';
    }
  }

  static getHeight() {
    if (Get.height <= 300) {
      return Get.height * 0.65;
    } else if (Get.height <= 400 && Get.height > 300) {
      return Get.height * 0.5;
    } else if (Get.height <= 500 && Get.height > 400) {
      return Get.height * 0.4;
    } else if (Get.height <= 600 && Get.height > 500) {
      return Get.height * 0.35;
    } else if (Get.height <= 700 && Get.height > 600) {
      return Get.height * 0.3;
    } else if (Get.height <= 800 && Get.height > 700) {
      return Get.height * 0.25;
    } else if (Get.height <= 900 && Get.height > 800) {
      return Get.height * 0.25;
    } else if (Get.height <= 1000 && Get.height > 900) {
      return Get.height * 0.2;
    } else if (Get.height <= 1100 && Get.height > 1000) {
      return Get.height * 0.2;
    } else if (Get.height <= 1200 && Get.height > 1100) {
      return Get.height * 0.18;
    } else if (Get.height > 1200) {
      return Get.height * 0.15;
    } else {
      return 200;
    }
  }

  static keyboardDismiss(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static getDeviceType() {
    if (GetPlatform.isAndroid) {
      return DeviceType.Android.name;
    } else if (GetPlatform.isIOS) {
      return DeviceType.IOS.name;
    }
    return DeviceType.unknown;
  }


  static getFcmToken() async {
    var fcmToken = await PrefManager.getString(AppConstants.fcmToken);
    if (fcmToken.toString().isNotEmpty) {
      return fcmToken;
    } else {
      try {
        String? token = '';
        token = await FirebaseMessaging.instance.getToken();
        await PrefManager.putString(AppConstants.fcmToken, token);
        print('token $token');
        return token;
      } catch (e) {
        debugPrint(e.toString());
        return fcmToken;
      }
    }
  }

/*


  static getVersionDetails() async {
    var appVersion = await getAppVersion();
    return "{'app_version' : $appVersion,'api_version' : ${AppConstants.apiVersion}}";
  }

  static getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    debugPrint('version $version');
    return version;
  }*/

  static setDateFormatWithDateDayMonth(utcTime) {
    if (utcTime != null && utcTime.toString().isNotEmpty) {
      // DateTime dateTime = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parseUtc(utcTime);
      DateTime dateTime = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(utcTime);
      //  DateTime localTime = dateTime.toLocal();
      String formattedTime = DateFormat('dd MMM').format(dateTime);
      return formattedTime;
    } else {
      return "0 0 0";
    }
  }

  static setDateFormatWithDayDateMonthTime(utcTime) {
    if (utcTime != null && utcTime.toString().isNotEmpty) {
      // DateTime dateTime = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parseUtc(utcTime);
      DateTime dateTime = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(utcTime,true).toLocal();
      //  DateTime localTime = dateTime.toLocal();
      String formattedTime = DateFormat('EEE dd MMM, hh:mm').format(dateTime);
      return formattedTime;
    } else {
      return " ";
    }
  }

  static setDateFormatWithDateDayMonthForChatTop(utcTime) {
    if (utcTime != null && utcTime.toString().isNotEmpty) {
      DateTime dateTime = DateFormat("yyyy-MM-dd").parse(utcTime);
      String formattedTime = DateFormat('dd MMM yyyy').format(dateTime);
      return formattedTime;
    } else {
      return " ";
    }
  }

  String getFormattedDateWithAmPM(String utcTime) {
    print('wertyuiop $utcTime');
    var dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(utcTime, true);
    var dateLocal = dateTime.toLocal();
    DateTime now = DateTime.now();
    if (utcTime.toString().isNotEmpty) {
      DateTime dateTime = DateFormat("yyyy-MM-dd' 'HH:mm:ss").parse(utcTime,true).toLocal();
      if (dateTime.day == now.day && dateTime.month == now.month && dateTime.year == now.year) {
        String formattedTime = DateFormat('hh:mm a').format(dateTime);
        return formattedTime;
      } else if (dateTime.day == now.day - 1 && dateTime.month == now.month && dateTime.year == now.year) {
        return 'Yesterday';
      } else {
        String formattedTime = DateFormat('dd/MM/yy').format(dateTime);
        return formattedTime;
      }
    } else {
      return " ";
    }

  }

}

Widget customButton(String buttonText, Function()? onTap, bool isActive) {
  return InkWell(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      width: Get.size.width * 0.8,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive ? ColorsTheme.col19DBCC : ColorsTheme.col303030,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        buttonText,
        style: boldTextStyle(fontSize: dimen14, color: isActive ? Colors.white : Colors.black),
      ),
    ),
  );
}

Widget customButtonWithArrow(String buttonText, Function()? onTap, bool isActive) {
  return InkWell(
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    focusColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    onTap: onTap,
    child: Container(
      width: Get.size.width * 0.8,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isActive ? ColorsTheme.col19DBCC : ColorsTheme.col303030,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        buttonText,
        style: boldTextStyle(fontSize: dimen14, color: Colors.black),
      ),
    ),
  );
}

bool isPasswordValid(String password) {
  print("fff");
  // Define a regular expression to match the password criteria
  RegExp passwordRegExp = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).{8,}$");

  //final RegExp passwordRegExp = RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)(?=.*[\W_]).{8,}$');

  // Use the RegExp test() method to check if the password matches the criteria
  print("passwordmatch ${passwordRegExp.hasMatch(password)}");
  return passwordRegExp.hasMatch(password);
}

bool isEmailValid(String email) {
  // Define a regular expression to match the password criteria
  final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

  // Use the RegExp test() method to check if the password matches the criteria
  print("passwordmatch ${emailRegExp.hasMatch(email)}");
  return emailRegExp.hasMatch(email);
}

String formatTimeAgo(Duration difference) {
  if (difference.inSeconds < 60) {
    return "${difference.inSeconds} second${difference.inSeconds == 1 ? '' : 's'} ${"ago".tr}";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ${"ago".tr}";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ${"ago".tr}";
  } else if (difference.inDays < 7) {
    return "${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ${"ago".tr}";
  } else if (difference.inDays < 30) {
    int weeks = (difference.inDays / 7).floor();
    return "$weeks week${weeks == 1 ? '' : 's'} ${"ago".tr}";
  } else if (difference.inDays < 365) {
    int months = (difference.inDays / 30).floor();
    return "$months month${months == 1 ? '' : 's'} ${"ago".tr}";
  } else {
    int years = (difference.inDays / 365).floor();
    return "$years year${years == 1 ? '' : 's'} ${"ago".tr}";
  }
}

firstNameLastName({required String firstName, required String lastName}){
  if(firstName.isNotEmpty){
    return firstName;
  }else if(lastName.isNotEmpty){
    return lastName;
  }
}


Widget noDataFound({required String content}){
  return Align(
    alignment: Alignment.center,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Res.icOnitTitle,height: 100,width: 100,),
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            content,
            style: boldTextStyle(fontSize: dimen16, color: ColorsTheme.colWhite),
          ),
        )
      ],
    ),
  );
}


getSimmerEffect({String? type}){
  return Container(
    width: double.infinity,
    padding: type!=null?const EdgeInsets.symmetric(horizontal: 15, vertical: 0):const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white30,
            enabled: true,
            period: const Duration(milliseconds: 1500),
            direction : ShimmerDirection.ltr,
            loop: 2,
            child: ListView.builder(
              padding:EdgeInsets.zero,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 15,
            ),
          ),
        ),
      ],
    ),
  );
}


getSimmerEffectForNotification({String? type}){
  return Container(
    width: double.infinity,
    padding: type!=null?const EdgeInsets.symmetric(horizontal: 15, vertical: 0):const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white30,
            enabled: true,
            period: const Duration(milliseconds: 1500),
            direction : ShimmerDirection.ltr,
            loop: 2,
            child: ListView.builder(
              padding:EdgeInsets.zero,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 15,
            ),
          ),
        ),
      ],
    ),
  );
}

getSimmerEffectForChat({String? type}){
  return Expanded(
    child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: Get.height,
        child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white30,
          enabled: true,
          period: const Duration(milliseconds: 1500),
          direction : ShimmerDirection.ltr,
          loop: 2,
          child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                bool isEven = index % 2 == 0;
                return Column(
                  crossAxisAlignment: isEven ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 50,
                      width: Get.width/2,
                      decoration: BoxDecoration(
                        color: ColorsTheme.colHint,
                        borderRadius:!isEven
                            ? const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8),bottomLeft: Radius.circular(8),)
                            : const BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8),bottomRight: Radius.circular(8),),),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: 15).paddingAll(10),
        ),
      ),
    ),
  );
}

Widget simmerEffectForProfile() {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    width: Get.width,
    height: 100.0,
    child: Shimmer.fromColors(
        enabled: true,
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade400,
        child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: 15,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.7,
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: ColorsTheme.col1C1C1C,
                    borderRadius: BorderRadius.circular(15)),
              );
            })),
  );
}

Widget simmerEffectForMyComments() {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white30,
            enabled: true,
            period: const Duration(milliseconds: 1500),
            direction : ShimmerDirection.ltr,
            loop: 2,
            child: ListView.builder(
              padding:EdgeInsets.zero,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 48.0,
                      height: 48.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ],
                ),
              ),
              itemCount: 15,
            ),
          ),
        ),
      ],
    ),
  );
}

getSimmerEffectForMyEventAndAttending(){
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.white54,
            highlightColor: Colors.white30,
            enabled: true,
            period: const Duration(milliseconds: 1500),
            direction : ShimmerDirection.ltr,
            loop: 2,
            child: ListView.builder(
              padding:EdgeInsets.zero,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black12, 
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 40.0,
                                height: 8.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: 15,
            ),
          ),
        ),
      ],
    ),
  );
}


getSimmerEffectForEvent(){
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white30,
            enabled: true,
            period: const Duration(milliseconds: 1500),
            direction : ShimmerDirection.ltr,
            loop: 2,
            child: ListView.builder(
              padding:EdgeInsets.zero,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: Get.width,
                          height: 200,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 8.0,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 40.0,
                              height: 8.0,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              itemCount: 15,
            ),
          ),
        ),
      ],
    ),
  );
}


getSimmerEffectForEventDetails(){
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.white30,
            enabled: true,
            period: const Duration(milliseconds: 1500),
            direction : ShimmerDirection.ltr,
            loop: 2,
            child: Container(
              decoration: BoxDecoration(
                 // color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        width: Get.width,
                        height: 200,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8.0,
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: 40.0,
                            height: 8.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding:EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 48.0,
                                  height: 48.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 2.0),
                                      ),
                                      Container(
                                        width: 40.0,
                                        height: 8.0,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          itemCount: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ),
        ),
      ],
    ),
  );
}

Widget simmerEffectForMatch() {
  return Shimmer.fromColors(
      enabled: true,
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade400,
      child: GridView.builder(
        shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: 15,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            childAspectRatio: 0.9,
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(color: ColorsTheme.col1C1C1C,
                     shape: BoxShape.circle),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 100,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            );
          }));
}


getSimmerEffectForHome(){
  return Container(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.white30,
              enabled: true,
              period: const Duration(milliseconds: 1500),
              direction : ShimmerDirection.ltr,
              loop: 2,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 20),
                          width: Get.width,
                          height: 120,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:  const EdgeInsets.symmetric(horizontal: 50.0,),
                                width: Get.width/2,
                                height: 12.0,
                                color: Colors.white30,
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                padding:  EdgeInsets.symmetric(horizontal: 50.0,),
                                width: Get.width/1.2,
                                height: 12.0,
                                color: Colors.white30,
                              ),
                              const SizedBox(height: 10,),
                              Container(
                                width: 100.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                    color: Colors.white30,
                                 borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 20),
                          width: Get.width,
                          height: 55,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.black12,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding:  const EdgeInsets.symmetric(horizontal: 50.0,),
                                height: 12.0,
                                color: Colors.white30,
                              ),

                              Container(
                                width: 30.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                    color: Colors.white30,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 150,
                          color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),
                              Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(5, (index) => Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(50)
                              ),
                            )),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
        ),
      ],
    ),
  );
}





