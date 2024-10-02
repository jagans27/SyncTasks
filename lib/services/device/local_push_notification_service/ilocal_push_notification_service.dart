abstract class ILocalPushNotificationService {
  Future<void> init();
  Future<void> scheduleNotification(
      {required int id,
      required String title,
      required String description,
      required DateTime time,
      required String? image});
  Future<void> showNotification(
      {required String title, required String description, String? image});
  Future<void> deleteNotification({required int id});
  Future<void> deleteAllNotification();
  Future<void> showPendingNotification();
}
