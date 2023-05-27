import 'package:adat/constant/provider/api.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/screens/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController(repository: ApiRepository(apiClient: ApiClient())));
  }
}