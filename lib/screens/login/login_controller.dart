import 'package:adat/constant/provider/custom_exception.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/utils/custom_response.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final ApiRepository repository;

  LoginController({required this.repository}) : assert(repository != null);

  TextEditingController loginNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController forgotPassLoginNameController = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  checkLoginValidation(BuildContext context){
    isLoading = true;
    if(loginNameController.text == "" || loginPasswordController.text == ""){
      Utils.showErrorSnackBar("Please enter all details!");
      isLoading = false;
      update();
    }
    else{
      callLoginApi(context);
    }
    update();
  }

  void callLoginApi(BuildContext context) async {
    try {
      LoginResponse? response = (await repository.doLogin(
          loginNameController.text, loginPasswordController.text
      ));

      if (response.statusCode==200) {

        if(response.loginResponseResult![0].message=="Login Successsfully" ||
            response.loginResponseResult![0].message=="Login Successfully"){
          GetStorage().erase();
          GetStorage().write('clientId', response.loginResponseResult![0].clientID);
          GetStorage().write('clientToken', response.loginResponseResult![0].token);
          loginNameController.clear();loginPasswordController.clear();
          Utils.showSuccessSnackBar(response.loginResponseResult![0].message);

          isLoading = false;
          Get.toNamed(AppRoutes.home);
        }
        else if(response.loginResponseResult![0].message=="Invalid Credentials"){
          Utils.showErrorSnackBar(response.loginResponseResult![0].message);
          isLoading = false; update();
        }
        else{
          Utils.showErrorSnackBar(response.loginResponseResult![0].message);
          isLoading = false; update();
        }
        update();
      } else {
        isLoading = false;
        Utils.showErrorSnackBar(response.loginResponseResult![0].message); update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      Utils.showErrorSnackBar("Something went wrong. Please try again later!");update();
    } catch (error) {
      isLoading = false;
      Utils.showErrorSnackBar("Invalid username or password"); update();
    }
  }

}