abstract class IHiveService {
  Future<void> initBox<T>(String boxName);
  Future<void> addItem<T>(String boxName, String key, T item);
  Future<T?> loadItem<T>(String boxName, String key);
  Future<List<T>> loadAllItems<T>(String boxName);
  Future<void> deleteBox(List<String> boxNamess);
  Future<void> updateItem<T>(String boxName, String key, T item);
  Future<void> deleteItem<T>(String boxName, String key);
  Stream<void> listenToHive<T>(String boxName);
}
