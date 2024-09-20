import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/screens/common/confirmation_popup/confirmation_popup.dart';
import 'package:sync_tasks/screens/profile/dependents/custom_switch.dart';
import 'package:sync_tasks/screens/profile/profile_vm.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/images.dart';
import 'package:sync_tasks/util/strings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  final ProfileVM _profileVM = ProfileVM();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(builder: (context) {
      return Column(
        children: [
          SizedBox(height: 68.3.h),
          CircleAvatar(
            radius: 60.5.r,
            backgroundColor: ColorUtil.white,
            backgroundImage: AssetImage(Images.sampleProfile),
          ),
          SizedBox(height: 10.3.h),
          Text("JAGAN S",
              style: TextStyle(
                  fontFamily: Fonts.neueMontreal,
                  fontWeight: FontWeight.w700,
                  height: 1.2.h,
                  color: ColorUtil.black,
                  fontSize: 23.sp)),
          SizedBox(height: 9.h),
          Text("jagan123@gmail.com",
              style: TextStyle(
                  fontFamily: Fonts.neueMontreal,
                  fontWeight: FontWeight.w400,
                  height: 1.2.h,
                  color: ColorUtil.black,
                  fontSize: 18.sp)),
          SizedBox(height: 23.h),
          Container(
            width: 342.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22.r),
                color: ColorUtil.darkGray),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 7.w, left: 12.w),
                        child: Image.asset(
                          Images.geminiIcon,
                          width: 21.w,
                          height: 21.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(Strings.aiScore,
                            style: TextStyle(
                                fontFamily: Fonts.neueMontreal,
                                fontWeight: FontWeight.w500,
                                height: 1.2.h,
                                color: ColorUtil.white,
                                fontSize: 18.sp)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 14.h, right: 23.w, left: 22.w, bottom: 18.h),
                  child: Text(
                      "Today is the hard day you going work so keepin mind that every work should has to be more precise and workable and enough for the day.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontFamily: Fonts.neueMontreal,
                          fontWeight: FontWeight.w500,
                          height: 1.2.h,
                          color: ColorUtil.lightSteelGray,
                          fontSize: 15.sp)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 21.h, bottom: 47.h),
            child: Container(
              width: 178.w,
              height: 38.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorUtil.darkGray,
                  borderRadius: BorderRadius.circular(41.r)),
              child: Text(Strings.accountAction,
                  style: TextStyle(
                      fontFamily: Fonts.neueMontreal,
                      fontWeight: FontWeight.w700,
                      height: 1.2.h,
                      color: ColorUtil.white,
                      fontSize: 15.sp)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40.w),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 7.w),
                  child: Image.asset(
                    Images.lockIcon,
                    height: 21.h,
                    width: 21.w,
                  ),
                ),
                Text(Strings.biometricAuthentication,
                    style: TextStyle(
                        fontFamily: Fonts.neueMontreal,
                        fontWeight: FontWeight.w500,
                        height: 1.2.h,
                        color: ColorUtil.black,
                        fontSize: 19.sp)),
                const Spacer(),
                CustomSwitch(
                    isEnabled: _profileVM.isBiometricEnabled,
                    onTap: () {
                      _profileVM.updateBiometricStatus();
                    }),
                SizedBox(width: 23.w)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 41.w, top: 31.h),
            child: GestureDetector(
              onTap: () {
                confirmationPopup(context,
                    buttonTexts: ["Logout", "Cancel"],
                    buttonActions: [() {}, () {}],
                    actionText: "Logout");
              },
              behavior: HitTestBehavior.translucent,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 7.w),
                      child: Image.asset(
                        Images.logout,
                        height: 21.h,
                        width: 21.w,
                      ),
                    ),
                    Text(Strings.logout,
                        style: TextStyle(
                            fontFamily: Fonts.neueMontreal,
                            fontWeight: FontWeight.w500,
                            height: 1.2.h,
                            color: ColorUtil.black,
                            fontSize: 19.sp))
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 38.w, top: 31.h),
            child: GestureDetector(
              onTap: () {
                confirmationPopup(context,
                    buttonTexts: ["Delete Account", "Cancel"],
                    buttonActions: [() {}, () {}],
                    actionText: "Delete Account");
              },
              behavior: HitTestBehavior.translucent,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 7.w),
                      child: Image.asset(
                        Images.delete,
                        height: 21.h,
                        width: 21.w,
                      ),
                    ),
                    Text(Strings.deleteAccount,
                        style: TextStyle(
                            fontFamily: Fonts.neueMontreal,
                            fontWeight: FontWeight.w500,
                            height: 1.2.h,
                            color: ColorUtil.pureRed,
                            fontSize: 19.sp))
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
