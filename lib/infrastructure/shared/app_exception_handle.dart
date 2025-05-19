import 'package:dio/dio.dart';
import 'package:get/get.dart';


handleApiException(code, message, DioException dioError,{required type}) {
  if(type == 'socketError'){
    return 'no_internet_connection'.tr;
  }
  else if (type == 'connectionTimeout') {
    return 'connection_timeout'.tr;
  }
  else {
    return message;
  }
}

handleFirebaseException(errorCode) {
  print(errorCode);
  switch (errorCode) {
    case "user-disabled":
      return "user_disabled".tr;
    case "too-many-requests":
      return "to_many_requests".tr;
    case "invalid-phone-number":
      return "invalid_phone_number".tr;
    case "invalid-verification-code":
      return "Invalid_code".tr;
    case "session-expired":
      return "session_expired".tr;
    case "quota-exceeded":
      return 'quota_exceed'.tr;
    case "operation-not-allowed":
      return "operation_not_allowed".tr;
    case "network-request-failed":
      return "no_internet_connection".tr;
    case "network_error":
      return "no_internet_connection".tr;
    default:
      return "something_went_wrong".tr;
  }
}

