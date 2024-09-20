import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/fonts.dart';

class StyleUtil {
  static TextStyle label = TextStyle(
      fontFamily: Fonts.neueMontreal,
      fontSize: 18.sp,
      height: 1.2.h,
      fontWeight: FontWeight.w500,
      color: ColorUtil.almostBlack);
  static TextStyle placeholder = TextStyle(
      fontFamily: Fonts.neueMontreal,
      fontSize: 14.sp,
      height: 1.2.h,
      fontWeight: FontWeight.w400,
      color: ColorUtil.almostBlack);
}
