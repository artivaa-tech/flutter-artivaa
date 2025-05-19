import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/country_model.dart';
import '../theme/colors.theme.dart';
import '../theme/text.theme.dart';

class CountryWidget extends StatelessWidget{

  final List<Countries> countriesList;
  final Function onSelect;
  final Function onSearch;

  const CountryWidget({super.key,required this.countriesList,required this.onSelect,required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 1.5,
      decoration: BoxDecoration(
          color: ColorsTheme.col1C1C1C, borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'choose_countries'.tr,
                  style: boldTextStyle(fontSize: dimen14, color: ColorsTheme.colWhite),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    Res.cancelOnReelPage,
                    height: 32,
                    width: 32,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: ColorsTheme.col404040,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 0,bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorsTheme.colInputBorder, width: 1), borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
                margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                width: Get.width,
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: 'search_country'.tr,
                    contentPadding: EdgeInsets.zero,
                    hintStyle: regularTextStyle(fontSize: dimen12, color: ColorsTheme.colHint),
                  ),
                  onChanged: (text) {
                    onSearch(text);
                  },
                  style: regularTextStyle(fontSize: dimen12, color: ColorsTheme.colWhite),
                ),
              )),
          Expanded(
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      onSelect(index);
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(
                                  countriesList[index].dialCode!,
                                  style: semiBoldTextStyle(fontSize: dimen11, color: ColorsTheme.colWhite),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                countriesList[index].name!,
                                style: regularTextStyle(fontSize: dimen12, color: ColorsTheme.colWhite),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      color: ColorsTheme.col404040,
                    ),
                  );
                },
                itemCount: countriesList.length),
          ),
        ],
      ),
    );
  }

}