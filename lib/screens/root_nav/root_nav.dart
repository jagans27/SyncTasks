import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sync_tasks/providers/root_nav_notifier/root_nav_notifier.dart';
import 'package:sync_tasks/routes/pages.dart';
import 'package:sync_tasks/screens/profile/profile.dart';
import 'package:sync_tasks/screens/root_nav/dependents/bottom_nav_button.dart';
import 'package:sync_tasks/screens/task_manager/task_manager.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/images.dart';

class RootNav extends StatefulWidget {
  const RootNav({super.key});

  @override
  State<RootNav> createState() => _RootNavState();
}

class _RootNavState extends State<RootNav> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RootNavNotifier>(builder: (context, provider, child) {
      return AnnotatedRegion(
          value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: ColorUtil.darkGray),
          child: Scaffold(
            backgroundColor: ColorUtil.white,
            body: Padding(
              padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              child: Stack(
                children: [
                  PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [TaskManger(), Profile()],
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      height: 122.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Positioned(
                            child: Container(
                              height: 89.h,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                  color: ColorUtil.darkGray,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(37.r),
                                      topRight: Radius.circular(37.r))),
                              child: Padding(
                                padding: EdgeInsets.only(left: 44.w),
                                child: Row(
                                  children: [
                                    BottomNavButton(
                                        title: "Tasks",
                                        icon: Images.taskIcon,
                                        isSelected: provider.currentIndex == 0,
                                        onTapFunction: () {
                                          if (provider.currentIndex != 0) {
                                            provider.updateCurrentIndex(
                                                index: 0);
                                            _pageController.animateToPage(0,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut);
                                          }
                                        }),
                                    SizedBox(
                                      width: 25.95.w,
                                    ),
                                    BottomNavButton(
                                        title: "Profile",
                                        icon: Images.profileIcon,
                                        isSelected: provider.currentIndex == 1,
                                        onTapFunction: () {
                                          if (provider.currentIndex != 1) {
                                            provider.updateCurrentIndex(
                                                index: 1);
                                            _pageController.animateToPage(1,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut);
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 71.w,
                            child: IconButton(
                              onPressed: () {
                                context.push(Pages.addTask);
                              },
                              style: IconButton.styleFrom(
                                  backgroundColor: ColorUtil.skyBlue,
                                  fixedSize: Size(60.w, 60.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                              icon: Image.asset(
                                Images.addIcon,
                                width: 24.w,
                                height: 24.h,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
