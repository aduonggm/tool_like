import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/base_tab_controller.dart';

class HomeController extends BaseTabController {
  final IDataManager dataManager;
  RxInt indexPage = 0.obs;

  HomeController(this.dataManager) : super(dataManager);
}
