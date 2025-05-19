import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../theme/colors.theme.dart';
import '../theme/text.theme.dart';

errorScreen({error}) {
  return Get.bottomSheet(
      Wrap(
        children: [
          Container(
            decoration: BoxDecoration(
                color: ColorsTheme.col1C1C1C, borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                      child: Icon(
                        Icons.cancel_outlined,
                        color: ColorsTheme.colPrimary,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: ColorsTheme.col1C1C1C,
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        Res.imgLogo1,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "error!".tr,
                        style: boldTextStyle(fontSize: dimen17, color: ColorsTheme.colWhite),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          error.toString(),
                          textAlign: TextAlign.center,
                          style: regularTextStyle(fontSize: dimen14, color: ColorsTheme.colWhite),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      enableDrag: false,
      isDismissible: false,
      exitBottomSheetDuration: const Duration(milliseconds: 500));
}

successScreen({String? title, error}) {
  return Get.bottomSheet(
      Wrap(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.center,
                //   child: InkWell(
                //     onTap: () {
                //       Get.back();
                //     },
                //     child: Container(
                //       margin: const EdgeInsets.only(top:10,bottom: 10),
                //       child: Icon(
                //         Icons.cancel_outlined,
                //         color: ColorsTheme.colPrimary,
                //         size: 40,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  color: ColorsTheme.colWhite,
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        Res.splashAnimation1,
                        height: 100,
                      ),
                      Text(
                        title != null && title.isNotEmpty ? title : 'success'.tr,
                        style: boldTextStyle(fontSize: dimen17, color: ColorsTheme.colBlack),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          error.toString(),
                          textAlign: TextAlign.center,
                          style: regularTextStyle(fontSize: dimen14, color: ColorsTheme.colBlack),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      enableDrag: false,
      isDismissible: false,
      exitBottomSheetDuration: const Duration(milliseconds: 500));
}

successScreenMsg({String? title, message}) {
  return Get.bottomSheet(
      Wrap(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(25.0)),
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.center,
                //   child: InkWell(
                //     onTap: () {
                //       Get.back();
                //     },
                //     child: Container(
                //       margin: const EdgeInsets.only(top:10,bottom: 10),
                //       child: Icon(
                //         Icons.cancel_outlined,
                //         color: ColorsTheme.colPrimary,
                //         size: 40,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  color: ColorsTheme.colWhite,
                  width: Get.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        Res.splashAnimation1,
                        height: 100,
                      ),
                      Text(
                        title != null && title.isNotEmpty ? title : 'success'.tr,
                        style: boldTextStyle(fontSize: dimen17, color: ColorsTheme.colBlack),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          message.toString(),
                          textAlign: TextAlign.center,
                          style: regularTextStyle(fontSize: dimen14, color: ColorsTheme.colBlack),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      enableDrag: false,
      isDismissible: false,
      exitBottomSheetDuration: const Duration(milliseconds: 500));
}

errorCustomToast({
  String? message,
  Color? backgroundColor,
  Color? textColor
}) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(Res.customError),
        const SizedBox(
          width: 12.0,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            message.toString(),
            textAlign: TextAlign.center,
            style: regularTextStyle(fontSize: dimen14, color: ColorsTheme.colBlack),
          ),
        ),
      ],
    ),
  );

  return Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.red,
      textColor: textColor ?? Colors.white,
      fontSize: 16.0);
}


transparentSnackBar({String? title, message}){
  return Get.snackbar(
    title ?? 'success'.tr,
    message,
    snackPosition: SnackPosition.BOTTOM,
  );
}
transparentSnackBarPostReel({String? title, message}){
  return Get.snackbar(
    title ?? 'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
  );
}