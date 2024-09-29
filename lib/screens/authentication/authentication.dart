import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sync_tasks/providers/authentication_notifier/authentication_notifier.dart';
import 'package:sync_tasks/routes/pages.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/images.dart';
import 'package:sync_tasks/util/strings.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  late AuthenticationNotifier _authenticationNotifier;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _checkAuthentication();
    });
  }

  @override
  Widget build(BuildContext context) {
    _authenticationNotifier = Provider.of<AuthenticationNotifier>(context);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor: ColorUtil.darkGray,
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
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _checkAuthentication();
                    },
                    child: Image.asset(
                      Images.biometricIcon,
                      width: 107.w,
                      height: 96.h,
                    ),
                  ),
                  Text(
                    Strings.authentication,
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

  Future<void> _checkAuthentication() async {
    bool isAuthenticated = await _authenticationNotifier.authenticate();

    if (isAuthenticated && mounted) {
      context.pushReplacement(Pages.rootScreen);
    }
  }
}
