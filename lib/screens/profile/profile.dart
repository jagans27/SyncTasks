import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sync_tasks/providers/profile_notifier/profile_notifier.dart';
import 'package:sync_tasks/providers/root_nav_notifier/root_nav_notifier.dart';
import 'package:sync_tasks/routes/pages.dart';
import 'package:sync_tasks/screens/common/confirmation_popup/confirmation_popup.dart';
import 'package:sync_tasks/screens/profile/dependents/custom_switch.dart';
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
  late ProfileNotifier _profileNotifier;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _profileNotifier.retrieveBiometricStatus();
        _profileNotifier.getWorkScore();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _profileNotifier = Provider.of<ProfileNotifier>(context);

    return Consumer2<ProfileNotifier, RootNavNotifier>(
        builder: (context, provider, rootProvider, child) {
      return SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(bottom: 122.h),
          child: Column(
            children: [
              SizedBox(height: 68.3.h),
              Skeletonizer(
                enabled: provider.userData == null,
                child: Container(
                    height: 121.h,
                    width: 121.w,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: (provider.userData == null ||
                            provider.userData?.profileUrl == null)
                        ? Image.asset(Images.emptyProfile)
                        : FadeInImage(
                            placeholder: AssetImage(Images.emptyProfile),
                            image: NetworkImage(
                                provider.userData?.profileUrl ?? ""),
                            fit: BoxFit.cover,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(Images.emptyProfile,
                                  fit: BoxFit.cover);
                            },
                          )),
              ),
              SizedBox(height: 10.3.h),
              Skeletonizer(
                enabled: provider.userData == null,
                child: Text(provider.userData!.name ?? "Anonymous",
                    style: TextStyle(
                        fontFamily: Fonts.neueMontreal,
                        fontWeight: FontWeight.w700,
                        height: 1.2.h,
                        color: ColorUtil.black,
                        fontSize: 23.sp)),
              ),
              SizedBox(height: 9.h),
              Skeletonizer(
                enabled: provider.userData == null,
                child: Text(provider.userData!.email,
                    style: TextStyle(
                        fontFamily: Fonts.neueMontreal,
                        fontWeight: FontWeight.w400,
                        height: 1.2.h,
                        color: ColorUtil.black,
                        fontSize: 18.sp)),
              ),
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
                      child: Skeletonizer(
                        enabled: provider.workScore == null &&
                            provider.networkConnectionError == false,
                        effect: const ShimmerEffect(
                          baseColor: Color.fromARGB(255, 55, 55, 55),
                          highlightColor: Color.fromARGB(255, 169, 169, 169),
                          duration: Duration(milliseconds: 900),
                        ),
                        child: provider.networkConnectionError == false
                            ? Text(
                                provider.workScore ??
                                   Strings.sampleText,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontFamily: Fonts.neueMontreal,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2.h,
                                    color: ColorUtil.lightSteelGray,
                                    fontSize: 15.sp))
                            : Center(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    provider.getWorkScore();
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        Images.noInternetIcon,
                                        width: 30.w,
                                        height: 30.h,
                                        color: ColorUtil.lightSteelGray,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5.h),
                                        child: Text(Strings.retry,
                                            style: TextStyle(
                                                fontFamily: Fonts.neueMontreal,
                                                fontWeight: FontWeight.w500,
                                                height: 1.2.h,
                                                color: ColorUtil.lightSteelGray,
                                                fontSize: 13.sp)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
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
                        isEnabled: _profileNotifier.isBiometricEnabled,
                        onTap: () {
                          _profileNotifier.updateBiometricStatus();
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
                        buttonActions: [
                          () async {
                            bool isSuccess = await provider.signOutFromGoogle();
                            if (mounted && isSuccess) {
                              provider.resetData();
                              rootProvider.resetCurrentIndex();
                              // ignore: use_build_context_synchronously
                              context.go(Pages.login);
                            }
                          },
                          () {
                            context.pop();
                          }
                        ],
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
                        buttonActions: [
                          () async {
                            bool isSuccess = await provider.deleteAccount();
                            if (mounted && isSuccess) {
                              provider.resetData();
                              rootProvider.resetCurrentIndex();
                              // ignore: use_build_context_synchronously
                              context.go(Pages.login);
                            }
                          },
                          () {
                            context.pop();
                          }
                        ],
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
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
