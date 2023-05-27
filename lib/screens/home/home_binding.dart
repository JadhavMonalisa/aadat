import 'package:adat/constant/provider/api.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(repository: ApiRepository(apiClient: ApiClient())));
  }
}