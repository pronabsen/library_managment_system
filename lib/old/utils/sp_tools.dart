import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class SPTools extends GetxController {
  final box = GetStorage();

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  void store(var key, var value) {
    box.write(key, value);
  }

  readData(var key) {
    final map = box.read(key);
    return map;
  }
}
