import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/fonts.dart';

class BottomNavButton extends StatelessWidget {
  final bool isSelected;
  final Function onTapFunction;
  final String title;
  final String icon;
  const BottomNavButton(
      {super.key,
      required this.isSelected,
      required this.onTapFunction,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapFunction(),
      behavior: HitTestBehavior.translucent,
      child: AnimatedSize(
        duration: Durations.short4,
        child: Container(
          height: 36.h,
          width: isSelected ? 111.w : 40.05.w,
          decoration: isSelected
              ? BoxDecoration(
                  color: ColorUtil.black,
                  borderRadius: BorderRadius.circular(29.r),
                  boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                          color: ColorUtil.black.withOpacity(.25))
                    ])
              : null,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: Image.asset(
                  icon,
                  width: 22.05.w,
                  height: 18.h,
                ),
              ),
              if (isSelected)
                Padding(
                  padding: EdgeInsets.only(left: 12.95.w),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: Fonts.neueMontreal,
                        color: ColorUtil.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
