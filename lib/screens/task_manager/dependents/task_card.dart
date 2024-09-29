import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/images.dart';

class TaskCard extends StatelessWidget {
  final TaskItem task;
  final Function()? onTap;
  final Function onTapImage;
  final bool showDivider;
  const TaskCard(
      {super.key,
      required this.task,
      required this.showDivider,
      required this.onTap,
      required this.onTapImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (task.image.isEmpty)
                Padding(
                  padding: EdgeInsets.only(left: 49.w, top: 28.h),
                  child: Text(
                    "${task.fromTime.split(" ")[0]}\n${task.toTime.split(" ")[1]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Fonts.neueMontreal,
                      fontWeight: FontWeight.w500,
                      color: ColorUtil.black,
                      fontSize: 14.sp,
                      height: 1.2.h,
                    ),
                  ),
                ),
              if (task.image.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    onTapImage();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 45.w, top: 25.h),
                    height: 65.h,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage:
                              MemoryImage(base64Decode(task.image)),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 49.w,
                            height: 26.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: ColorUtil.darkGray,
                                borderRadius: BorderRadius.circular(41.r)),
                            child: Text(
                              "${task.fromTime.split(" ")[0]}\n${task.toTime.split(" ")[1]}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: Fonts.neueMontreal,
                                fontWeight: FontWeight.w500,
                                color: ColorUtil.white,
                                fontSize: 10.sp,
                                height: 1.2.h,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              GestureDetector(
                onTap: onTap == null ? null : () => onTap!(),
                behavior: HitTestBehavior.translucent,
                child: Container(
                  width: 266.w,
                  constraints: BoxConstraints(minHeight: 98.h),
                  margin: EdgeInsets.only(right: 26.w),
                  padding: EdgeInsets.only(
                      top: 15.h, left: 22.w, right: 15.w, bottom: 13.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: ColorUtil.black.withOpacity(.1))
                      ],
                      color: Color(TaskColor.values.byName(task.color).color)),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200.w,
                              child: Text(
                                task.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: Fonts.neueMontreal,
                                  fontWeight: FontWeight.w700,
                                  color: ColorUtil.black,
                                  fontSize: 15.sp,
                                  height: 1.2.h,
                                ),
                              ),
                            ),
                            Image.asset(
                              task.completed
                                  ? Images.selectedIcon
                                  : Images.unSelectedIcon,
                              width: 12.w,
                              height: 12.h,
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 7.h),
                          child: Text(
                            task.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: Fonts.neueMontreal,
                              fontWeight: FontWeight.w400,
                              color: ColorUtil.lightGray,
                              fontSize: 11.sp,
                              height: 1.2.h,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(top: 15.h),
                          child: Text(
                            "${task.fromTime} - ${task.toTime}",
                            style: TextStyle(
                              fontFamily: Fonts.neueMontreal,
                              fontWeight: FontWeight.w500,
                              color: ColorUtil.charcoalGray,
                              fontSize: 11.sp,
                              height: 1.2.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: showDivider
                ? Divider(
                    color: ColorUtil.lightGrayish,
                    endIndent: 23.w,
                    indent: 28.w,
                  )
                : SizedBox(
                    height: 10.h,
                  ),
          )
        ],
      ),
    );
  }
}
