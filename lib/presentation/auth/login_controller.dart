import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../infrastructure/shared/app_exception_handle.dart';
import '../../../infrastructure/shared/auth_type_enum.dart';
import '../../../infrastructure/shared/common_fun.dart';
import '../../../infrastructure/shared/custom_toast.dart';
import '../../../infrastructure/shared/http_exception.dart';
import '../../../infrastructure/shared/one_signal.dart';
import '../../../infrastructure/shared/progress_dialog.dart';
import '../../../infrastructure/shared/social_auth.dart';
import '../../infrastructure/constants/common_keys.dart';

class LoginController extends GetxController {
  var isFormFilled = false.obs;

  var emailNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var isPasswordShow = false.obs;

  var fcmToken = ''.obs;

  @override
  void onInit() {
    Future.delayed(Duration.zero, () async {
      fcmToken.value = await CommonFunction.getFcmToken();
      await getPlayerId();
    });
    super.onInit();
  }

  getPlayerId() async {
    if(OneSignalClass.playerId.isEmpty){
      return await OneSignalClass.getPlayerId();
    }
    return OneSignalClass.playerId;
  }

  onCheckFormFill() {
    if (emailNumberController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isFormFilled.value = true;
    } else {
      isFormFilled.value = false;
    }
  }

  signInApi() async {
    var progressLoader = ProgressDialog();
    progressLoader.show();
   /* if (fcmToken.isEmpty) {
      fcmToken.value = await CommonFunction.getFcmToken();
    }*/
    var pId = await getPlayerId();

    // var params = {CommonKeys.password: passwordController.text, CommonKeys.notificationToken: fcmToken.value, CommonKeys.deviceType: CommonFunction.getDeviceType()};
    var params = {CommonKeys.password: passwordController.text, CommonKeys.notificationToken: pId, CommonKeys.deviceType: CommonFunction.getDeviceType()};
    if (isEmailValid(emailNumberController.text)) {
      params[CommonKeys.email] = emailNumberController.text;
    } else {
      params[CommonKeys.phone] = emailNumberController.text;
    }
    try {
      /*ApiResponseModel<UserData> userModel = await DioClient.base().funSignInApi(params);
      if (userModel.status == 200) {
        progressLoader.dismiss();
        PrefManager.putString(AppConstants.apiToken, userModel.data!.user!.token);
        PrefManager.putString(AppConstants.userData, json.encode(userModel.data!.user!));
        PrefManager.putBool(AppConstants.loggedIn, true);
        Get.offAllNamed(Routes.baseHome);
      } else {
        progressLoader.dismiss();
        errorCustomToast(message: userModel.message!);
      }*/
    } on CustomHttpException catch (exception) {
      progressLoader.dismiss();
      errorCustomToast(message: handleApiException(exception.code, exception.response, exception.exception, type: exception.type));
    } catch (e) {
      progressLoader.dismiss();
      errorCustomToast(message: 'something_went_wrong'.tr);
    }
  }

  googleLoginApi() async {
    var progressLoader = ProgressDialog();
    progressLoader.show();
    try {
      User? user = await Authentication.signInWithGoogle();
      if (fcmToken.isEmpty) {
        fcmToken.value = await CommonFunction.getFcmToken();
      }
      var pId = await getPlayerId();
      var params = {
        CommonKeys.firstName: user!.displayName!,
        CommonKeys.socialId: user.uid,
        // CommonKeys.notificationToken: fcmToken.value,
        CommonKeys.notificationToken: pId,
        CommonKeys.authType: AuthType.Google.name,
        CommonKeys.deviceType: CommonFunction.getDeviceType()
      };

      //ApiResponseModel<UserData> userModel = await DioClient.base().funSocialAuthApi(params);
     /* if (userModel.status == 200) {
        progressLoader.dismiss();
        PrefManager.putString(AppConstants.apiToken, userModel.data!.user!.token);
        PrefManager.putString(AppConstants.userData, json.encode(userModel.data!.user!));
        PrefManager.putBool(AppConstants.loggedIn, true);
        if(userModel.data!.user!.isSocialLogin!){
          Get.offAllNamed(Routes.baseHome);
        }
        else{
          Get.offAllNamed(Routes.introQuestion);
        }
      } else {
        progressLoader.dismiss();
        errorCustomToast(message: userModel.message!);
      }*/
    } on CustomHttpException catch (exception) {
      progressLoader.dismiss();
      errorCustomToast(message: handleApiException(exception.code, exception.response, exception.exception, type: exception.type));
    } on FirebaseAuthException catch (e) {
      progressLoader.dismiss();
      errorCustomToast(message: handleFirebaseException(e));
    } catch (e) {
      progressLoader.dismiss();
      if(e != 'Back for firebase'){
        errorCustomToast(message: 'something_went_wrong'.tr);
      }
    }
  }

  appleLoginApi() async {
    var progressLoader = ProgressDialog();
    progressLoader.show();

    try {
      User? user = await Authentication.signInWithApple();
      if (fcmToken.isEmpty) {
        fcmToken.value = await CommonFunction.getFcmToken();
      }
      var pId = await getPlayerId();
      var params = {
        CommonKeys.firstName: user!.displayName!,
        CommonKeys.socialId: user.uid,
        // CommonKeys.notificationToken: fcmToken.value,
        CommonKeys.notificationToken: pId,
        CommonKeys.authType: AuthType.Apple.name,
        CommonKeys.deviceType: CommonFunction.getDeviceType()
      };

     /* ApiResponseModel<UserData> userModel = await DioClient.base().funSocialAuthApi(params);
      if (userModel.status == 200) {
        progressLoader.dismiss();
        PrefManager.putString(AppConstants.apiToken, userModel.data!.user!.token);
        PrefManager.putString(AppConstants.userData, json.encode(userModel.data!.user!));
        PrefManager.putBool(AppConstants.loggedIn, true);
        if(userModel.data!.user!.isSocialLogin!){
          Get.offAllNamed(Routes.baseHome);
        }
        else{
          Get.offAllNamed(Routes.introQuestion);
        }
      } else {
        progressLoader.dismiss();
        errorCustomToast(message: userModel.message!);
      }*/
    } on CustomHttpException catch (exception) {
      progressLoader.dismiss();
      errorCustomToast(message: handleApiException(exception.code, exception.response, exception.exception, type: exception.type));
    } on FirebaseAuthException catch (e) {
      print('e');
      progressLoader.dismiss();
      errorCustomToast(message: handleFirebaseException(e));
    } catch (e) {
      progressLoader.dismiss();
      print('e');
      print(e);
      errorCustomToast(message: 'something_went_wrong'.tr);
    }
  }

}
