import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/base_tab_controller.dart';

class HomeController extends BaseTabController {
  final IDataManager dataManager;
  RxInt indexPage = 0.obs;
  String cookie = 'PHPSESSID=pf7hbgu4ee780j680249lsl726';


  HomeController(this.dataManager) : super(dataManager);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
