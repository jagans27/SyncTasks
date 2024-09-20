import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sync_tasks/screens/add_task/add_task.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/fonts.dart';

Future<void> confirmationPopup(BuildContext context,
    {required List<String> buttonTexts,
    required List<Function> buttonActions,
    required actionText}) async {
  try {
    // if the length is not same
    if (buttonTexts.length != buttonActions.length) {
      throw Exception("Mismatch length Exception");
    }

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
                  height: 197.h,
                  width: 354.w,
                  padding: EdgeInsets.only(top: 26.h, left: 36.w, right: 36.w),
                  decoration: BoxDecoration(
                      color: ColorUtil.white,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Do you want to ",
                              style: TextStyle(
                                  fontFamily: Fonts.neueMontreal,
                                  fontSize: 17.sp,
                                  height: 1.2.h,
                                  fontWeight: FontWeight.w500,
                                  color: ColorUtil.black),
                              children: [
                            TextSpan(
                                text: "$actionText?",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700))
                          ])),
                      SizedBox(height: 22.h),
                      FilledButton(
                          onPressed: () => buttonActions[0](),
                          style: FilledButton.styleFrom(
                              backgroundColor: ColorUtil.black,
                              fixedSize: Size(282.w, 51.h)),
                          child: Text(
                            buttonTexts[0],
                            style: TextStyle(
                                fontFamily: Fonts.neueMontreal,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                                height: 1.2.h,
                                color: ColorUtil.white),
                          )),
                      SizedBox(height: 18.h),
                      GestureDetector(
                        onTap: () => buttonActions[1](),
                        child: Text(
                          buttonTexts[1],
                          style: TextStyle(
                              fontFamily: Fonts.neueMontreal,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.2.h,
                              color: ColorUtil.darkCharcoal),
                        ),
                      )
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
