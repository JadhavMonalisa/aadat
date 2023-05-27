import 'package:adat/constant/provider/api.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/screens/farmer/farmer_controller.dart';
import 'package:get/get.dart';

class FarmerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FarmerController(repository: ApiRepository(apiClient: ApiClient())));
  }
}