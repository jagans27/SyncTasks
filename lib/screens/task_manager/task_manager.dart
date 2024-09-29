import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sync_tasks/providers/profile_notifier/profile_notifier.dart';
import 'package:sync_tasks/providers/task_notifier/task_notifier.dart';
import 'package:sync_tasks/routes/pages.dart';
import 'package:sync_tasks/screens/common/confirmation_popup/confirmation_popup.dart';
import 'package:sync_tasks/screens/common/edit_bottom_sheet/edit_bottom_sheet.dart';
import 'package:sync_tasks/screens/task_manager/dependents/image_popup.dart';
import 'package:sync_tasks/screens/task_manager/dependents/task_card.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/images.dart';
import 'package:sync_tasks/util/strings.dart';
import 'package:sync_tasks/util/util.dart';

class TaskManger extends StatefulWidget {
  const TaskManger({super.key});

  @override
  State<TaskManger> createState() => _TaskMangerState();
}

class _TaskMangerState extends State<TaskManger>
    with AutomaticKeepAliveClientMixin {
  late TaskNotifier _taskNotifier;
  late ProfileNotifier _profileNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _taskNotifier.init();
      if (_profileNotifier.userData == null) {
        _profileNotifier.loadUserData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    _taskNotifier = Provider.of<TaskNotifier>(context);
    _profileNotifier = Provider.of<ProfileNotifier>(context);

    return Consumer2<TaskNotifier, ProfileNotifier>(
        builder: (context, provider, profileProvider, child) {
      return SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            SizedBox(height: 26.3.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 37.w),
                  height: 38.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                      color: ColorUtil.darkGray,
                      borderRadius: BorderRadius.circular(41.r)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Image.asset(
                          Images.appLogo,
                          width: 25.w,
                          height: 25.h,
                        ),
                      ),
                      Text(Strings.appName,
                          style: TextStyle(
                              color: ColorUtil.white,
                              fontSize: 18.sp,
                              fontFamily: Fonts.neueMontreal,
                              fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 35.w),
                  child: Skeletonizer(
                    enabled: profileProvider.userData == null,
                    child: Container(
                        height: 44.h,
                        width: 44.w,
                        clipBehavior: Clip.hardEdge,
                        decoration:
                            const BoxDecoration(shape: BoxShape.circle),
                        child: (profileProvider.userData == null ||
                                profileProvider.userData?.profileUrl == null)
                            ? Image.asset(Images.emptyProfile)
                            : FadeInImage(
                                placeholder: AssetImage(Images.emptyProfile),
                                image: NetworkImage(
                                    profileProvider.userData?.profileUrl ??
                                        ""),
                                fit: BoxFit.cover,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(Images.emptyProfile,
                                      fit: BoxFit.cover);
                                },
                              )),
                  ),
                )
              ],
            ),
            SizedBox(height: 27.h),
            if (provider.isLoading)
              Padding(
                padding: EdgeInsets.only(top: 180.h),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(Images.loadingLottie,
                          width: 100.w, height: 100.h),
                      Text(
                        Strings.fetching,
                        style: TextStyle(
                            fontFamily: Fonts.neueMontreal,
                            color: ColorUtil.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )
            else if (provider.tasks.isEmpty && provider.isLoading == false)
              Padding(
                padding: EdgeInsets.only(top: 150.h),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(Images.taskLottie,
                          width: 300.w, height: 180.h),
                      Text(
                        Strings.noTaskAvailable,
                        style: TextStyle(
                            fontFamily: Fonts.neueMontreal,
                            color: ColorUtil.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              )
            else if (provider.tasks.isNotEmpty)
              ...List.generate(provider.tasks.length, (index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 37.w, bottom: 14.h),
                        child: Text(
                            Util.generateTaskDayFormatString(
                                provider.tasks[index].date),
                            style: TextStyle(
                                color: ColorUtil.almostBlack,
                                fontFamily: Fonts.neueMontreal,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      ...List.generate(
                        provider.tasks[index].tasks.length,
                        (taskIndex) {
                          return TaskCard(
                            task: provider.tasks[index].tasks[taskIndex],
                            showDivider: taskIndex !=
                                provider.tasks[index].tasks.length - 1,
                            onTap: !Util.isCurrentDay(
                                    provider.tasks[index].date)
                                ? null
                                : () {
                                    editBottomSheet(
                                        context: context,
                                        buttonNames: [
                                          "Delete",
                                          "Update",
                                          provider.tasks[index].tasks[taskIndex]
                                                  .completed
                                              ? "Undone"
                                              : "Done",
                                        ],
                                        buttonIcon: [
                                          Images.delete,
                                          Images.editIcon,
                                          provider.tasks[index].tasks[taskIndex]
                                                  .completed
                                              ? Images.crossBigIcon
                                              : Images.tickIcon,
                                        ],
                                        onClickFunctions: [
                                          () {
                                            context.pop();
                                            confirmationPopup(context,
                                                buttonTexts: [
                                                  "Delete Task",
                                                  "Keep"
                                                ],
                                                buttonActions: [
                                                  () {
                                                    provider.deleteTask(
                                                        taskId: provider
                                                            .tasks[index]
                                                            .tasks[taskIndex]
                                                            .id);
                                                    context.pop();
                                                  },
                                                  () {
                                                    context.pop();
                                                  }
                                                ],
                                                actionText: "Delete Task");
                                          },
                                          () {
                                            context.pop();
                                            context.push(Pages.addTask,
                                                extra: provider.tasks[index]
                                                    .tasks[taskIndex]);
                                          },
                                          () {
                                            provider.updateTaskStatus(
                                                taskId: provider.tasks[index]
                                                    .tasks[taskIndex].id);
                                            context.pop();
                                          },
                                        ]);
                                  },
                            onTapImage: () {
                              imagePopup(context,
                                  task: provider.tasks[index].tasks[taskIndex]);
                            },
                          );
                        },
                      ),
                    ]);
              }),
            SizedBox(
              height: 89.h,
            )
          ]));
    });
  }

  @override
  bool get wantKeepAlive => true;
}
