abstract class ILocalPushNotificationService {
  Future<void> init();
  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String description,
      required DateTime time});
  Future<void> showNotification(
      {required String title, required String description});
  Future<void> deleteNotification({required int id});
  Future<void> deleteAllNotification();
  Future<void> showPendingNotification();
}
