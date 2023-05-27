import 'package:adat/constant/provider/api.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/screens/customer/customer_controller.dart';
import 'package:get/get.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CustomerController(repository: ApiRepository(apiClient: ApiClient())));
  }
}