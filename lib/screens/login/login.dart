import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sync_tasks/providers/login_notifier/login_notifier.dart';
import 'package:sync_tasks/routes/pages.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/images.dart';
import 'package:sync_tasks/util/strings.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginNotifier _loginNotifier;

  @override
  Widget build(BuildContext context) {
    _loginNotifier = Provider.of<LoginNotifier>(context, listen: false);

    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: ColorUtil.darkGray,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: ColorUtil.darkGray),
        child: SafeArea(
            child: Scaffold(
                backgroundColor: ColorUtil.darkGray,
                body: Stack(
                  children: [
                    Positioned(
                      top: 60.3.h,
                      left: 37.w,
                      child: Text(
                        Strings.appName,
                        style: TextStyle(
                            fontFamily: Fonts.neueMontreal,
                            color: ColorUtil.white,
                            fontSize: 19.sp,
                            height: 1.2.h,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 123.3.h,
                      child: Image.asset(
                        Images.loginIcon,
                        height: 417.h,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 37.w),
                              child: Text(
                                Strings.letsGetStarted,
                                style: TextStyle(
                                    fontFamily: Fonts.neueMontreal,
                                    color: ColorUtil.white,
                                    fontSize: 40.sp,
                                    height: 1.2.h,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 37.w),
                              child: Text(
                                Strings.everythingStartFromHere,
                                style: TextStyle(
                                    fontFamily: Fonts.neueMontreal,
                                    color: ColorUtil.lightGray,
                                    fontSize: 15.sp,
                                    height: 1.2.h,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(height: 38.h),
                          GestureDetector(
                            onTap: () async {
                              bool isLoginSuccessful =
                                  await _loginNotifier.signInWithGoogle();

                              if (mounted && isLoginSuccessful) {
                                // ignore: use_build_context_synchronously
                                context.pushReplacement(Pages.rootScreen);
                              }
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                              height: 50.h,
                              width: 317.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: ColorUtil.white,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(Images.googleIcon,
                                      width: 30.w, height: 30.h),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.w),
                                    child: Text(
                                      Strings.continueWithGoogle,
                                      style: TextStyle(
                                          fontFamily: Fonts.neueMontreal,
                                          color: ColorUtil.black,
                                          fontSize: 15.sp,
                                          height: 1.2.h,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 50.h),
                        ],
                      ),
                    ),
                  ],
                ))));
  }
}
