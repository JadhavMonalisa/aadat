import 'package:adat/constant/provider/api.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/screens/supplier/supplier_controller.dart';
import 'package:get/get.dart';

class SupplierBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(SupplierController(repository: ApiRepository(apiClient: ApiClient())));
  }
}