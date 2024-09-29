import 'package:hive/hive.dart';
import 'package:sync_tasks/services/platform/hive_service/ihive_service.dart';
import 'package:sync_tasks/util/extensions.dart';

class HiveService implements IHiveService {
  final Map<String, dynamic> _boxes = {};

  @override
  Future<void> initBox<T>(String boxName) async {
    try {
      if (!_boxes.containsKey(boxName)) {
        _boxes[boxName] = await Hive.openBox<T>(boxName);
      }
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<void> addItem<T>(String boxName, String key, T item) async {
    try {
      await initBox<T>(boxName);
      var box = _boxes[boxName] as Box<T>;
      await box.put(key, item);
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<T?> loadItem<T>(String boxName, String key) async {
    try {
      await initBox<T>(boxName);
      var box = _boxes[boxName] as Box<T>;
      return box.get(key);
    } catch (ex) {
      ex.logError();
      return null;
    }
  }

  @override
  Future<List<T>> loadAllItems<T>(String boxName) async {
    try {
      await initBox<T>(boxName);
      var box = _boxes[boxName] as Box<T>;
      return box.values.toList();
    } catch (ex) {
      ex.logError();
      return [];
    }
  }

  @override
  Future<void> updateItem<T>(String boxName, String key, T item) async {
    try {
      await initBox<T>(boxName);
      var box = _boxes[boxName] as Box<T>;
      if (box.containsKey(key)) {
        await box.put(key, item);
      } else {
        throw Exception('Item with key $key does not exist.');
      }
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<void> deleteItem<T>(String boxName, String key) async {
    try {
      await initBox<T>(boxName);
      var box = _boxes[boxName] as Box<T>;
      await box.delete(key);
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Future<void> deleteBox(List<String> boxNamess) async {
    try {
      for (String box in boxNamess) {
        Hive.deleteBoxFromDisk(box);
        _boxes.remove(box);
      }
    } catch (ex) {
      ex.logError();
    }
  }

  @override
  Stream<void> listenToHive<T>(String boxName) {
    final box = Hive.box<T>(boxName);
    return box.watch().map((event) {
      return;
    });
  }
}
