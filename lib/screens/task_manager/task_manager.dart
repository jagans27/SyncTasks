import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sync_tasks/screens/common/confirmation_popup/confirmation_popup.dart';
import 'package:sync_tasks/screens/common/edit_bottom_sheet/edit_bottom_sheet.dart';
import 'package:sync_tasks/screens/task_manager/dependents/task_card.dart';
import 'package:sync_tasks/screens/task_manager/task_manager_vm.dart';
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
  final TaskManagerVM _taskManagerVM = TaskManagerVM();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(builder: (context) {
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
                  child: CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(Images.sampleProfile),
                  ),
                )
              ],
            ),
            SizedBox(height: 27.h),
            ...List.generate(_taskManagerVM.tasks.length, (index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 37.w, bottom: 14.h),
                      child: Text(
                          Util.generateTaskDayFormatString(
                              _taskManagerVM.tasks[index].date),
                          style: TextStyle(
                              color: ColorUtil.almostBlack,
                              fontFamily: Fonts.neueMontreal,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                    ...List.generate(
                      _taskManagerVM.tasks[index].tasks.length,
                      (taskIndex) {
                        return TaskCard(
                          task: _taskManagerVM.tasks[index].tasks[taskIndex],
                          showDivider: taskIndex !=
                              _taskManagerVM.tasks[index].tasks.length - 1,
                          onTap: !Util.isCurrentDay(
                                  _taskManagerVM.tasks[index].date)
                              ? null
                              : () {
                                  editBottomSheet(
                                      context: context,
                                      buttonNames: [
                                        "Delete",
                                        "Update",
                                        _taskManagerVM.tasks[index]
                                                .tasks[taskIndex].completed
                                            ? "Undone"
                                            : "Done",
                                      ],
                                      buttonIcon: [
                                        Images.delete,
                                        Images.editIcon,
                                        _taskManagerVM.tasks[index]
                                                .tasks[taskIndex].completed
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
                                              buttonActions: [() {}, () {}],
                                              actionText: "Delete Task");
                                        },
                                        () {},
                                        _taskManagerVM.tasks[index]
                                                .tasks[taskIndex].completed
                                            ? () {}
                                            : () {},
                                      ]);
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
