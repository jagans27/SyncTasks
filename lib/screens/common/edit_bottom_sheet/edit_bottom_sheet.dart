import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/screens/root_nav/dependents/bottom_sheet_icon_button.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/strings.dart';

void editBottomSheet(
    {required BuildContext context,
    required List<String> buttonNames,
    required List<String> buttonIcon,
    required List<Function> onClickFunctions}) {
  try {
    // if there is no element
    if (buttonNames.isEmpty || buttonIcon.isEmpty || onClickFunctions.isEmpty) {
      throw Exception("List Empty Exception");
    }

    // if the length is not same throw error
    if (buttonNames.length != buttonIcon.length ||
        buttonNames.length != onClickFunctions.length) {
      throw Exception("Mismatch length Exception");
    }

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: ColorUtil.semiTransparentGray.withOpacity(.46),
      builder: (BuildContext context) {
        return Container(
            height: 192.h,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                color: ColorUtil.darkGray,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(37.r),
                    topRight: Radius.circular(37.r))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 2.6.h,
                    width: 85.w,
                    margin: EdgeInsets.only(top: 7.8.h, bottom: 21.6.h),
                    decoration: BoxDecoration(
                        color: ColorUtil.offWhite,
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 32.w, bottom: 26.h),
                  child: Text(Strings.chooseOption,
                      style: TextStyle(
                        fontFamily: Fonts.neueMontreal,
                        fontWeight: FontWeight.w500,
                        color: ColorUtil.white,
                        fontSize: 18.sp,
                        height: 1.2.h,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 57.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(buttonNames.length, (int index) {
                      return BottomSheetIconButton(
                          image: buttonIcon[index],
                          title: buttonNames[index],
                          onTap: () => onClickFunctions[index]());
                    }),
                  ),
                )
              ],
            ));
      },
    );
  } catch (ex) {
    ex.logError();
  }
}
