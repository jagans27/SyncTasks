import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/images.dart';
import 'package:sync_tasks/util/style_util.dart';

class TimerTextfield extends StatelessWidget {
  final TextEditingController controller;
  final Function onTap;
  const TimerTextfield({super.key,required this.controller,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
        onTap: () =>onTap(),
        maxLength: 100,
        maxLines: 1,
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
            hintText: "Select Time",
            hintStyle: StyleUtil.placeholder
                .merge(TextStyle(color: ColorUtil.darkSteelGray)),
            counterText: "",
            contentPadding: EdgeInsets.only(left: 8.w, right: 16.w),
            constraints: BoxConstraints(minHeight: 41.h,maxHeight: 41.h),
            prefixIcon: Image.asset(
              Images.timerIcon,
              width: 19.w,
              height: 19.w,
            ),
            prefixIconConstraints:
                BoxConstraints(maxWidth: 37.w, minWidth: 37.w),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorUtil.darkGray,
                    width: 1.w),
                borderRadius: BorderRadius.circular(11.r)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorUtil.pureRed.withOpacity(.5),
                    width: 1.w),
                borderRadius: BorderRadius.circular(11.r)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorUtil.darkGray,
                    width: 1.w),
                borderRadius: BorderRadius.circular(11.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: ColorUtil.darkGray,
                    width: 1.w),
                borderRadius: BorderRadius.circular(11.r))),
        style: StyleUtil.placeholder.merge(
          TextStyle(color: ColorUtil.darkGray),
        ));
  }
}
