import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/api_helper.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/data/db_helper.dart';
import 'package:tool_tang_tuong_tac/data/preference_helper.dart';


class AppBinding extends Bindings {
  final IPreferenceHelper preferenceHelper;
  final IDbHelper dbHelper;

  AppBinding({required this.preferenceHelper, required this.dbHelper});

  @override
  void dependencies() {
    Get.lazyPut<IPreferenceHelper>(() => preferenceHelper);
    Get.lazyPut<IDbHelper>(() => dbHelper);
    Get.lazyPut<IApiHelper>(() => ApiHelper());
    Get.put<IDataManager>(DataManager(preferenceHelper: Get.find(), apiHelper: Get.find(), dbHelper: Get.find()));
  }
}
