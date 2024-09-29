import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sync_tasks/services/device/local_push_notification_service/ilocal_push_notification_service.dart';
import 'package:sync_tasks/util/extensions.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalPushNotificationService extends ILocalPushNotificationService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalPushNotificationService(
      {required this.flutterLocalNotificationsPlugin}) {
    try {
      init();
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<void> init() async {
    try {
      
      _configureLocalTimeZone();

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_logo');

      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsIOS);


      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      _requestAndroidPermissions();
    } catch (ex) {
      ex.logError();
    }
  }

  Future<void> _configureLocalTimeZone() async {
try{
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}catch(ex){
  ex.logError();
}
}

  Future<void> _requestAndroidPermissions() async {
    try {
      final androidImpl =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidImpl != null) {
        await androidImpl.requestNotificationsPermission();
      }
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String description,
      required DateTime time}) async {
    try {
      tz.TZDateTime? scheduledTime = _checkScheduledTime(time);

      if (scheduledTime != null) {
        await flutterLocalNotificationsPlugin.zonedSchedule(
            id,
            title,
            description,
            scheduledTime,
            const NotificationDetails(
                android: AndroidNotificationDetails(
                  'syncTasks_notification',
                  'SyncTasks Notification',
                  channelDescription:
                      'Notifications for important updates and alerts from My App',
                  importance: Importance.high,
                  priority: Priority.high,
                  showWhen: false,
                ),
                iOS: DarwinNotificationDetails()),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
            matchDateTimeComponents: DateTimeComponents.time,
            payload: scheduledTime.toString());
      }
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<void> showNotification({
    required String title,
    required String description,
  }) async {
    try {
      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        description,
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'syncTasks_notification',
              'SyncTasks Notification',
              channelDescription:
                  'Notifications for important updates and alerts from My App',
              importance: Importance.high,
              priority: Priority.high,
              showWhen: false,
            ),
            iOS: DarwinNotificationDetails()),
      );
    } catch (ex) {
      ex.logError();
    }
  }

  tz.TZDateTime? _checkScheduledTime(DateTime scheduledTime) {
    try {
      tz.TZDateTime now = tz.TZDateTime.now(tz.local);
      tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduledTime, tz.local);
      return scheduledDate.isAfter(now) ? scheduledDate : null;
    } catch (ex) {
      ex.logError();
      return null;
    }
  }

  @override
  Future<void> deleteAllNotification() async {
    try {
      flutterLocalNotificationsPlugin.cancelAll();
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<void> deleteNotification({required int id}) async {
    try {
      flutterLocalNotificationsPlugin.cancel(id);
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<void> showPendingNotification() async {
    try {
      final List<PendingNotificationRequest> pendingNotificationRequests =
          await flutterLocalNotificationsPlugin.pendingNotificationRequests();

      print("\n--_PENDING NOTIFICATION_--\n");
      for (PendingNotificationRequest pendingNotificationRequest
          in pendingNotificationRequests) {
        print(
            "${pendingNotificationRequest.payload} | ${pendingNotificationRequest.id} | ${pendingNotificationRequest.title}");
      }
      print("\n--------------------------------\n");
    } catch (ex) {
      ex.logError();
    }
  }
}
