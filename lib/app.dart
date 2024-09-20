import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sync_tasks/routes/routes.dart';
import 'package:sync_tasks/util/snackbar_helper.dart';
import 'package:sync_tasks/util/strings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 840),
      splitScreenMode: true,
      minTextAdapt: true,
      child: MaterialApp.router(
        scaffoldMessengerKey: SnackkBarHelper.snackBarKey,
      // child: MaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        // home: const Splash(),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
