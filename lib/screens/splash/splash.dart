import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sync_tasks/routes/pages.dart';
import 'package:sync_tasks/screens/splash/splash_vm.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/images.dart';
import 'package:sync_tasks/util/strings.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final SplashVM _splashVM = SplashVM();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        bool? navigateToAuthentication = await _splashVM.navigateUser();

        if (mounted && navigateToAuthentication != null) {
          if (navigateToAuthentication) {
            context.pushReplacement(Pages.authenticationScreen);
          } else {
            context.pushReplacement(Pages.rootScreen);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor: ColorUtil.darkGray,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: ColorUtil.darkGray),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorUtil.darkGray,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(top: 343.3.h, bottom: 46.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Images.appLogoFrame,
                    width: 138.w,
                    height: 60.h,
                  ),
                  Text(
                    Strings.slogan,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: Fonts.neueMontreal,
                        color: ColorUtil.lightGray),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
