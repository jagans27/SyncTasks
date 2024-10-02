import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/providers/profile_notifier/profile_notifier.dart';
import 'package:sync_tasks/providers/task_notifier/task_notifier.dart';
import 'package:sync_tasks/routes/pages.dart';
import 'package:sync_tasks/screens/add_task/dependents/timer_textfield.dart';
import 'package:sync_tasks/screens/common/confirmation_popup/confirmation_popup.dart';
import 'package:sync_tasks/screens/common/edit_bottom_sheet/edit_bottom_sheet.dart';
import 'package:sync_tasks/util/color_util.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:sync_tasks/util/fonts.dart';
import 'package:sync_tasks/util/images.dart';
import 'package:sync_tasks/util/snackbar_helper.dart';
import 'package:sync_tasks/util/strings.dart';
import 'package:sync_tasks/util/style_util.dart';
import 'package:sync_tasks/util/util.dart';

class AddTask extends StatefulWidget {
  final TaskItem? taskData;
  const AddTask({super.key, this.taskData});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController _titleTextEditingController;
  late TextEditingController _descriptionTextEditingController;
  late TextEditingController _fromTimeTextEditingController;
  late TextEditingController _toTimeTextEditingController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  late TaskNotifier _taskNotifier;

  @override
  void initState() {
    super.initState();

    _titleTextEditingController = TextEditingController();
    _descriptionTextEditingController = TextEditingController();
    _fromTimeTextEditingController = TextEditingController();
    _toTimeTextEditingController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.taskData != null) {
        _titleTextEditingController.text = widget.taskData!.title;
        _descriptionTextEditingController.text = widget.taskData!.description;
        _fromTimeTextEditingController.text = widget.taskData!.fromTime;
        _toTimeTextEditingController.text = widget.taskData!.toTime;

        _taskNotifier.setTaskData(taskItem: widget.taskData!);
      }
    });

    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        _taskNotifier.isTitleValid();
      } else {
        _taskNotifier.clearTitleErrorMessage();
      }
    });

    _descriptionFocusNode.addListener(() {
      if (!_descriptionFocusNode.hasFocus) {
        _taskNotifier.isDescriptionValid();
      } else {
        _taskNotifier.clearDescriptionErrorMessage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _titleTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _fromTimeTextEditingController.dispose();
    _toTimeTextEditingController.dispose();
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _taskNotifier.clearAddTaskScreenData();
  }

  @override
  Widget build(BuildContext context) {
    _taskNotifier = Provider.of<TaskNotifier>(context);

    return Consumer2<TaskNotifier, ProfileNotifier>(
        builder: (context, provider, profileProvider, child) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop == false) {
            if ((provider.task.title.isEmpty &&
                provider.task.description.isEmpty &&
                provider.task.fromTime.isEmpty &&
                provider.task.toTime.isEmpty &&
                provider.task.image == null)) {
              context.pop();
            } else {
              await confirmationPopup(context,
                  buttonTexts: ["Discard", "Keep editing"],
                  buttonActions: [
                    () {
                      context.go(Pages.rootScreen);
                    },
                    () {
                      context.pop();
                    }
                  ],
                  actionText: "Discard changes");
            }
          }
        },
        child: AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: ColorUtil.darkGray,
            ),
            child: Scaffold(
              backgroundColor: ColorUtil.white,
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: EdgeInsets.only(
                    left: 37.w,
                    right: 37.w,
                    top: MediaQuery.paddingOf(context).top),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: IntrinsicHeight(
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
                              height: 38.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                  color: ColorUtil.darkGray,
                                  borderRadius: BorderRadius.circular(41.r)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Image.asset(
                                      Images.appLogo,
                                      width: 25.w,
                                      height: 25.h,
                                    ),
                                  ),
                                  Text(Strings.addTasks,
                                      style: TextStyle(
                                          color: ColorUtil.white,
                                          fontSize: 18.sp,
                                          fontFamily: Fonts.neueMontreal,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ),
                            Skeletonizer(
                              enabled: profileProvider.userData == null,
                              child: Container(
                                  height: 44.h,
                                  width: 44.w,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: (profileProvider.userData == null ||
                                          profileProvider
                                                  .userData?.profileUrl ==
                                              null)
                                      ? Image.asset(Images.emptyProfile)
                                      : FadeInImage(
                                          placeholder:
                                              AssetImage(Images.emptyProfile),
                                          image: NetworkImage(profileProvider
                                                  .userData?.profileUrl ??
                                              ""),
                                          fit: BoxFit.cover,
                                          imageErrorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                Images.emptyProfile,
                                                fit: BoxFit.cover);
                                          },
                                        )),
                            ),
                          ],
                        ),
                        SizedBox(height: 29.h),
                        Text(
                          "Title *",
                          style: StyleUtil.label,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: TextField(
                              onChanged: (String value) {
                                provider.updateTitle(title: value);
                              },
                              controller: _titleTextEditingController,
                              focusNode: _titleFocusNode,
                              maxLength: 100,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  error: provider.titleError.isNotEmpty
                                      ? const SizedBox.shrink()
                                      : null,
                                  errorStyle: StyleUtil.placeholder.merge(
                                      TextStyle(
                                          color: ColorUtil.pureRed
                                              .withOpacity(.5))),
                                  hintText: "Enter title",
                                  hintStyle: StyleUtil.placeholder.merge(
                                      TextStyle(
                                          color: ColorUtil.darkSteelGray)),
                                  counterText: "",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 13.w),
                                  constraints: BoxConstraints(
                                      minHeight: 45.h, maxHeight: 45.h),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color: ColorUtil.darkGray,
                                          width: 1.w),
                                      borderRadius:
                                          BorderRadius.circular(11.r)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color:
                                              ColorUtil.pureRed.withOpacity(.5),
                                          width: 1.w),
                                      borderRadius: BorderRadius.circular(11.r)),
                                  focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, color: ColorUtil.darkGray, width: 1.5.w), borderRadius: BorderRadius.circular(11.r)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, color: ColorUtil.darkGray, width: 1.5.w), borderRadius: BorderRadius.circular(11.r))),
                              style: StyleUtil.placeholder.merge(
                                TextStyle(color: ColorUtil.darkGray),
                              )),
                        ),
                        if (provider.titleError.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              provider.titleError,
                              style: StyleUtil.placeholder.merge(TextStyle(
                                  color: ColorUtil.pureRed.withOpacity(.5))),
                            ),
                          ),
                        SizedBox(height: 22.h),
                        Text(
                          "Description *",
                          style: StyleUtil.label,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: TextFormField(
                              onChanged: (String value) {
                                provider.updateDescription(description: value);
                              },
                              onTapOutside: (event) {
                                _descriptionFocusNode.unfocus();
                              },
                              controller: _descriptionTextEditingController,
                              focusNode: _descriptionFocusNode,
                              maxLength: 255,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.top,
                              textAlign: TextAlign.start,
                              cursorColor: ColorUtil.black,
                              cursorErrorColor: ColorUtil.black,
                              decoration: InputDecoration(
                                  error: provider.descriptionError.isNotEmpty
                                      ? const SizedBox.shrink()
                                      : null,
                                  counterText: "",
                                  hintText: "Enter what you going to do.",
                                  hintStyle: StyleUtil.placeholder.merge(
                                      TextStyle(
                                          color: ColorUtil.darkSteelGray)),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 13.w, vertical: 9.h),
                                  constraints: BoxConstraints(
                                      minHeight: 93.h, maxHeight: 93.h),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color: ColorUtil.darkGray,
                                          width: 1.w),
                                      borderRadius:
                                          BorderRadius.circular(11.r)),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color:
                                              ColorUtil.pureRed.withOpacity(.5),
                                          width: 1.w),
                                      borderRadius:
                                          BorderRadius.circular(11.r)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          style: BorderStyle.solid,
                                          color: ColorUtil.darkGray,
                                          width: 1.5.w),
                                      borderRadius:
                                          BorderRadius.circular(11.r)),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid, color: ColorUtil.darkGray, width: 1.5.w), borderRadius: BorderRadius.circular(11.r))),
                              expands: true,
                              style: StyleUtil.placeholder.merge(
                                TextStyle(color: ColorUtil.darkGray),
                              )),
                        ),
                        if (provider.descriptionError.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(
                              provider.descriptionError,
                              style: StyleUtil.placeholder.merge(TextStyle(
                                  color: ColorUtil.pureRed.withOpacity(.5))),
                            ),
                          ),
                        SizedBox(height: 22.h),
                        Text(
                          "Select color *",
                          style: StyleUtil.label,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 11.h, bottom: 21.h),
                          child: Row(
                            children: List.generate(
                              TaskColor.values.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    provider.updateColor(
                                        color: TaskColor.values[index].name);
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    height: 35.h,
                                    width: 35.h,
                                    margin: EdgeInsets.only(right: 20.w),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: provider.task.color ==
                                                    TaskColor.values[index].name
                                                ? ColorUtil.slateGray
                                                : Color(TaskColor
                                                    .values[index].color)),
                                        color: Color(
                                            TaskColor.values[index].color)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: Text(
                                    "From *",
                                    style: StyleUtil.label,
                                  ),
                                ),
                                SizedBox(
                                    width: 126.w,
                                    child: TimerTextfield(
                                      controller:
                                          _fromTimeTextEditingController,
                                      onTap: () async {
                                        String? pickedTime = await _selectTime(
                                            time: provider.task.fromTime.isEmpty
                                                ? TimeOfDay.now()
                                                    .format(context)
                                                : provider.task.fromTime);

                                        if (pickedTime != null) {
                                          _fromTimeTextEditingController.text =
                                              pickedTime;
                                          provider.updateFromTime(
                                              fromTime: pickedTime);
                                          provider.isFromTimeValid();

                                          if (provider.task.toTime.isNotEmpty) {
                                            provider.isToTimeValid();
                                          }
                                        } else {
                                          provider.isFromTimeValid();
                                          if (provider.task.toTime.isNotEmpty) {
                                            provider.isToTimeValid();
                                          }
                                        }
                                      },
                                    ))
                              ],
                            ),
                            SizedBox(width: 26.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: Text(
                                    "To *",
                                    style: StyleUtil.label,
                                  ),
                                ),
                                SizedBox(
                                    width: 126.w,
                                    child: TimerTextfield(
                                      controller: _toTimeTextEditingController,
                                      onTap: () async {
                                        if (provider.task.fromTime.isEmpty) {
                                          SnackkBarHelper.showMessge(
                                              message:
                                                  "Please select a start time.");
                                        } else {
                                          String? pickedTime =
                                              await _selectTime(
                                            time: provider.task.toTime.isEmpty
                                                ? provider.task.fromTime
                                                : provider.task.toTime,
                                          );

                                          if (pickedTime != null) {
                                            _toTimeTextEditingController.text =
                                                pickedTime;
                                            provider.updateToTime(
                                                toTime: pickedTime);
                                            provider.isToTimeValid();
                                          } else {
                                            provider.isToTimeValid();
                                          }
                                        }
                                      },
                                    ))
                              ],
                            )
                          ],
                        ),
                        if (provider.fromTimeError.isNotEmpty ||
                            provider.toTimeError.isNotEmpty)
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              provider.fromTimeError.isNotEmpty
                                  ? provider.fromTimeError
                                  : provider.toTimeError,
                              style: StyleUtil.placeholder.merge(TextStyle(
                                  color: ColorUtil.pureRed.withOpacity(.5))),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h, top: 21.h),
                          child: Text(
                            provider.task.image == null
                                ? "Choose Image"
                                : "Selected Image",
                            style: StyleUtil.label,
                          ),
                        ),
                        if (provider.task.image == null)
                          GestureDetector(
                            onTap: () {
                              editBottomSheet(context: context, buttonNames: [
                                "Camera",
                                "Gallery"
                              ], buttonIcon: [
                                Images.cameraIcon,
                                Images.galleryIcon
                              ], onClickFunctions: [
                                () {
                                  provider.pickImageFromCamera();
                                  context.pop();
                                },
                                () {
                                  provider.pickImageFromGallery();
                                  context.pop();
                                }
                              ]);
                            },
                            behavior: HitTestBehavior.translucent,
                            child: Container(
                                height: 42.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(41.r),
                                    border:
                                        Border.all(color: ColorUtil.darkGray)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Insert image",
                                      style: TextStyle(
                                          color: ColorUtil.black,
                                          fontFamily: Fonts.neueMontreal,
                                          height: 1.2.h,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5.w),
                                      child: Image.asset(Images.addBlackIcon,
                                          width: 14.w, height: 14.h),
                                    )
                                  ],
                                )),
                          ),
                        if (provider.task.image != null)
                          Center(
                            child: Container(
                              height: 150.h,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: MemoryImage(
                                        base64Decode(provider.task.image!)),
                                    fit: BoxFit.cover),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.r)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 7.h, right: 7.w),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      provider.deleteImage();
                                    },
                                    behavior: HitTestBehavior.translucent,
                                    child: CircleAvatar(
                                      radius: 15.5.r,
                                      backgroundColor:
                                          ColorUtil.darkGray.withOpacity(.1),
                                      child: Image.asset(Images.crossSmallIcon),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () async {
                  if (widget.taskData == null) {
                    await provider.addTask();
                  } else {
                    await provider.updateTask();
                  }
                  if (mounted &&
                      (provider.titleError.isEmpty &
                              provider.descriptionError.isEmpty &&
                          provider.fromTimeError.isEmpty &&
                          provider.toTimeError.isEmpty)) {
                    // ignore: use_build_context_synchronously
                    context.pop();
                  }
                },
                child: Container(
                  height: 59.h,
                  margin:
                      EdgeInsets.only(bottom: 28.h, right: 37.w, left: 37.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorUtil.black,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: const Offset(0, 4))
                      ],
                      borderRadius: BorderRadius.circular(29.r)),
                  child: Text(
                      widget.taskData == null
                          ? Strings.addTask
                          : Strings.updateTask,
                      style: TextStyle(
                          color: ColorUtil.offWhite,
                          fontSize: 21.sp,
                          height: 1.2.h,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            )),
      );
    });
  }

  Future<String?> _selectTime({required String time}) async {
    try {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: Util.convertStringToTimeOfDay(time),
        helpText: "Select From Time",
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: ColorUtil.black,
                onSurface: ColorUtil.black,
                tertiary: Colors.black,
                onTertiary: Colors.white,
              ),
              dialogBackgroundColor: ColorUtil.white,
              buttonTheme: ButtonThemeData(
                colorScheme: ColorScheme.light(
                  primary: ColorUtil.black,
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null && mounted) {
        return pickedTime.format(context);
      } else {
        return null;
      }
    } catch (ex) {
      ex.logError();
      return null;
    }
  }
}
