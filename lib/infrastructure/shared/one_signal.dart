import 'dart:convert';

import 'package:artivaa/infrastructure/shared/pref_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../constants/app_constants.dart';
import '../navigation/routes.dart';

class OneSignalClass {
  static String playerId = "";

  Future<void> initOneSignal() async {
    /// Set App Id.
    /* OneSignal.initialize("976fbc20-109c-4d8f-8824-d959a5bc0899");

    /// Get the Onesignal userId and update that into the firebase.
    /// So, that it can be used to send Notifications to users later.̥
    final status = await OneSignal.User.getOnesignalId();
    print("stattus  id${status}");*/
    // We will update this once he logged in and goes to dashboard.
    ////updateUserProfile(osUserID);
    // Store it into shared prefs, So that later we can use it.

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission


    await OneSignal.shared.consentGranted(true);
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.error);
      await OneSignal.shared.setAppId("976fbc20-109c-4d8f-8824-d959a5bc0899");

    OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
      String osUserID1 = changes.to.userId!;
      print("osUserID osUserID: $osUserID1");
      await PrefManager.putString(AppConstants.oneSignalID, osUserID1);
    });
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) async {
      print('results when app in background${result.notification.title}');
      print('results when app in background${result.notification.body}');
      print('results when app in background${result.notification.additionalData}');
      print('results when app in background${jsonEncode(result.notification)}');
      notificationRedirection(result);
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      print('results when app in setNotificationWillShowInForegroundHandler${event.notification.title}');
    });
    await OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {
      print("Accepted permission: $accepted");
    });

    OneSignal.shared.setSubscriptionObserver((changes) {
      print('setSubscriptionObserver${changes}');
    });

    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      print('results when app in background${result.notification.title}');
      print('results when app in background${jsonEncode(result.notification.body)}');
      print('results when app in background${result.notification.additionalData!.toString()}');
      print('results when app in background${result.notification.additionalData!['meta']}');
      print('results when app in background${result.notification.additionalData!['type']}');
      // print('results when app in background reel id${result.notification.additionalData!['meta']['id']}');
      // print('results when app in background${result.notification.additionalData!['meta']['user']['id']}');
      print('results when app in background ---->${result.action}');
      notificationRedirection(result);
    });
    await getPlayerId();
  }

  notificationRedirection(result) async {
    print('-------------------->first');
     var type = result.notification.additionalData!['type']??'';
     var id = result.notification.additionalData!['meta']['id'] ??'';
     // var userId = result.notification.additionalData!['meta']['user']['id'] ??'';
     // var storyType = result.notification.additionalData!['meta']['story_type'] ??'';
     // var chatType = result.notification.additionalData!['meta']['chat_type'] ??'';
     // var postType = result.notification.additionalData!['meta']['post_type'] ??'';
     // var conversationId = result.notification.additionalData!['meta']['conversation_id'] ??'';
     // var profileImage = result.notification.additionalData!['meta']['user']['media'] ??'';
     // var firstName = result.notification.additionalData!['meta']['user']['first_name'] ??'';
    // var userId = result.notification.additionalData!['foo']['userid'];

    //POST = 'POST',
    //   LIKE = 'LIKE',
    //   STORY = 'STORY',
    //   COMMENT = 'COMMENT',
    //   FOLLOWERS = 'FOLLOWERS',
    //   FOLLOWING = 'FOLLOWING',
    //   MATCHES = 'MATCHES',
    //   STORYREPLIES = 'STORYREPLIES',
    //   CALLS = 'CALLS',
    //   LIVE = 'LIVE',
    //   REELS = 'REELS',
    //   SERVICEALERTS = 'SERVICEALERTS',
    //   UPDATES = 'UPDATES',
    //   ADMIN = 'ADMIN',
    //   PROMOTIONAL = 'PROMOTIONAL',
    //   CHAT = 'CHAT',
    //   COMMUNITY = 'COMMUNITY',
      print('-------------------->${type}');

  }

  static getPlayerId() async {
    var status = await OneSignal.shared.getDeviceState();
    var osUserID = status!.userId ?? '';
    print("osUserID osUserID: $osUserID");
    playerId = osUserID;
    return playerId;
  }
}
