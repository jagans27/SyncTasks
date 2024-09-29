import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/fonts.dart';

Future<void> imagePopup(BuildContext context, {required TaskItem task}) async {
  try {
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Scaffold(
            backgroundColor: ColorUtil.black.withOpacity(.4),
            body: GestureDetector(
              onTap: () {},
              child: Center(
                child: Container(
                  width: 354.w,
                  padding: EdgeInsets.only(
                      top: 26.h,bottom: 26.h),
                  decoration: BoxDecoration(
                      color: ColorUtil.white,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 310.w,
                        height: 350.h,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Container(
                                  height: 300.h,
                                  width: 310.w,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(
                                        base64Decode(task.image),
                                      ),fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r))),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                  color: ColorUtil.black.withOpacity(.50),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.r),
                                      topRight: Radius.circular(10.r))),
                              child: Text(task.title,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: Fonts.neueMontreal,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4.h,
                                      color: ColorUtil.white,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18.sp)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 310.w,
                        child: Text(task.description,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontFamily: Fonts.neueMontreal,
                                fontWeight: FontWeight.w500,
                                height: 1.2.h,
                                color: ColorUtil.darkCharcoal.withOpacity(.7),
                                fontSize: 15.sp)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  } catch (ex) {
    ex.logError();
  }
}
