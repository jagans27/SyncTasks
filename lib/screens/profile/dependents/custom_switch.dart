import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/util/color_util.dart';

class CustomSwitch extends StatelessWidget {
  final bool isEnabled;
  final Function onTap;
  const CustomSwitch({super.key, required this.isEnabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 30.w,
        height: 18.h,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(41.r),
            border: Border.all(color: ColorUtil.black, width: 2.w)),
        child: Row(
          mainAxisAlignment:
              isEnabled ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 7.r,
              backgroundColor: isEnabled ? ColorUtil.skyBlue : ColorUtil.black,
            )
          ],
        ),
      ),
    );
  }
}
