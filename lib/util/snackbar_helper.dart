import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/images.dart';

class SnackkBarHelper {
  static GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showMessge({required String message}) {
    try {
      snackBarKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Row(
            children: [
              Image.asset(
                Images.infoIcon,
                width: 18.w,
                height: 18.h,
              ),
              SizedBox(width: 10.w),
              Text(message,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: Fonts.neueMontreal,
                      overflow: TextOverflow.ellipsis,
                      color: ColorUtil.white)),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          behavior: SnackBarBehavior.floating,
          backgroundColor: ColorUtil.darkGray,
          duration: const Duration(seconds: 3),
        ));
    } catch (ex) {
      ex.logError();
    }
  }
}
