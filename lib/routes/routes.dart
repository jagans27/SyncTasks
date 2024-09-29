import 'package:go_router/go_router.dart';
import 'package:sync_tasks/bos/task_bo/task_bo.dart';
import 'package:sync_tasks/routes/pages.dart';
import 'package:sync_tasks/screens/add_task/add_task.dart';
import 'package:sync_tasks/screens/authentication/authentication.dart';
import 'package:sync_tasks/screens/login/login.dart';
import 'package:sync_tasks/screens/root_nav/root_nav.dart';
import 'package:sync_tasks/screens/splash/splash.dart';

class AppRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: Pages.splashScreen,
      builder: (context, state) {
        return const Splash();
      },
    ),
    GoRoute(
      path: Pages.login,
      builder: (context, state) {
        return const Login();
      },
    ),
    GoRoute(
      path: Pages.authenticationScreen,
      builder: (context, state) {
        return const Authentication();
      },
    ),
    GoRoute(
      path: Pages.rootScreen,
      builder: (context, state) {
        return const RootNav();
      },
    ),
    GoRoute(
      path: Pages.addTask,
      builder: (context, state) {
        return AddTask(taskData: state.extra as TaskItem?);
      },
    )
  ]);
}
