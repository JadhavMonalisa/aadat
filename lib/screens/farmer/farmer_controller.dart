import 'package:adat/constant/provider/custom_exception.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/farmer/farmer_model.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

class FarmerController extends GetxController {

  final ApiRepository repository;

  FarmerController({required this.repository}) : assert(repository != null);

  String selectedFirm = "";
  int selectedFirmId = 0;
  TextEditingController pattiNo = TextEditingController();
  String selectedToDateToShow = "";
  String selectedFromDateToShow = "";
  DateTime selectedDate = DateTime.now();
  bool isViewSelected = false;
  String selectedCustomer = "";
  List<String> customerNameList = ["Customer 1","Customer 2","Customer 3","Customer 4","Customer 5"];
  List<String> noDataList = ["No Data Found"];
  bool cbCustomer = false;
  bool showCustomerList = false;
  List<String> farmerTypeList = ["Regular","Paid","Reprint"];
  String selectedFarmerType = "";
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedFirm = GetStorage().read("selectedFirm");
    selectedFirmId = GetStorage().read("selectedFirmId");

    repository.getData();
  }

  Future<void> selectDate(BuildContext context,String selection) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1700, 1),
        lastDate: DateTime(2100, 1));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }

    if(selection == "fromDate"){
      selectedFromDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    else if(selection == "toDate"){
      selectedToDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }

    if(selectedFromDateToShow == "" || pattiNo.text == ""){

    }
    else{
      showCustomerList = true; update();
    }
  }

  updateSelectedFarmerType(String value){
    selectedFarmerType = value;
    update();
  }

  updatePattiNo(){
    if(selectedFromDateToShow == "" ){
        Utils.showErrorSnackBar("Please select date!"); update();
    }
    if(pattiNo.text == ""){
      Utils.showErrorSnackBar("Please enter patti no!"); update();
    }
    else{
      showCustomerList = true; update();
    }
  }

  updateSelectedCustomer(String value){
    selectedCustomer = value; update();
  }

  showFarmerReceiptResult(){
    if(selectedFarmerType == ""){
      showToast("Please select farmer type!");
    }
    else if(selectedFromDateToShow == ""){
      showToast("Please select date!");
    }
    else if(selectedCustomer == ""){
      showToast("Please select customer!");
    }
    else{
      isViewSelected = true; update();
    }
  }

  List<String> addedCustomer = [];

  updateCustomerCheckBox(bool selectCustomer,String customerName){
    cbCustomer = selectCustomer;

    if(addedCustomer.contains(customerName)){
      addedCustomer.remove(customerName);
    }
    else{
      addedCustomer.add(customerName);
    }

    update();
  }

  navigateFromReceiptToHome(){
    isViewSelected = false; showCustomerList = false;
    pattiNo.clear();
    selectedFromDateToShow ="";
    Get.toNamed(AppRoutes.home);
    update();
  }

  List<FarmerPattiDetails> farmerPattiList = [];

  callFarmerPattiList() async{
    farmerPattiList.clear();
    try {
      Utils.dismissKeyboard();
      FarmerPattiModel? response = (await repository.getFarmerPattiList(
          int.parse(pattiNo.text), selectedToDateToShow,selectedFirmId));
      if (response.statusCode==200) {
        farmerPattiList.addAll(response.farmerPattiDetails!);
        isLoading = false;
        update();
      }
      else {
        isLoading = false;
        update();
      }
      update();
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
    update();
  }
}