import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/fonts.dart';

class BottomSheetIconButton extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;
  const BottomSheetIconButton({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(),
      child: Column(
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorUtil.black,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 0)
                ]),
            child: Center(
              child: Image.asset(
                image,
                width: 20.w,
                height: 20.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Text(title,
                style: TextStyle(
                    fontFamily: Fonts.neueMontreal,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2.h,
                    color: ColorUtil.white)),
          )
        ],
      ),
    );
  }
}
