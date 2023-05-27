
import 'package:adat/constant/provider/custom_exception.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/supplier/supplier_model.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

class SupplierController extends GetxController {

  final ApiRepository repository;

  SupplierController({required this.repository}) : assert(repository != null);

  String selectedFirm = "";
  int selectedFirmId = 0;
  List<String> noDataList = ["No Data Found"];
  List<String> supplierNameList = ["Supplier 1","Supplier 2","Supplier 3","Supplier 4","Supplier 5"];
  String selectedSupplier = "";
  DateTime selectedDate = DateTime.now();
  String selectedFromDateToShow = "";
  String selectedToDateToShow = "";
  String selectedSummaryReportFromDateToShow = "";
  String selectedSummaryReportToDateToShow = "";
  bool isViewSelected = false;
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedFirm = GetStorage().read("selectedFirm");
    selectedFirmId = GetStorage().read("selectedFirmId");

    repository.getData();

    callSupplierList();
  }

  updateSelectedSupplier(String value){
    selectedSupplier = value; update();
  }

  List<SupplierListDetails> supplierList = [];

  callSupplierList() async{
    try {
      Utils.dismissKeyboard();
      SupplierListModel? response = (await repository.getSupplierList(selectedFirmId));
      if (response.statusCode==200) {
        supplierList.addAll(response.supplierListDetails!);
        isLoading = false;
        update();
      }
      else {
        isLoading = false;
        update();
      }
    } on CustomException catch (e) {
      isLoading = false;
      update();
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  List<SupplierLedgerReportDetails> supplierLedgerReportList = [];

  callSupplierLedgerReportList() async{
    supplierLedgerReportList.clear();
    try {
      Utils.dismissKeyboard();
      SupplierLedgerReportModel? response = (await repository.getSupplierLedgerReportList(selectedSupplier,
          selectedToDateToShow,selectedFromDateToShow,selectedFirmId));

      if (response.statusCode==200) {
        supplierLedgerReportList.addAll(response.supplierLedgerReportDetails!);
        isLoading = false;
        Get.toNamed(AppRoutes.supplierResult);
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

  List<SupplierLedgerSummaryReportDetails> supplierLedgerSummaryReportList = [];
  callSupplierLedgerSummaryReportList() async{
    supplierLedgerSummaryReportList.clear();
    try {
      Utils.dismissKeyboard();
      SupplierLedgerSummaryReportModel? response = (await repository.getSupplierLedgerSummaryReportList(
          selectedToDateToShow,selectedFromDateToShow,selectedFirmId));

      if (response.statusCode==200) {
        supplierLedgerSummaryReportList.addAll(response.supplierLedgerSummaryReportDetails!);
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
    else if(selection == "summaryReportFromDate"){
      selectedSummaryReportFromDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    else if(selection == "summaryReportToDate"){
      selectedSummaryReportToDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
  }

  backPressNavigation(String screen){
    Get.toNamed(screen);
  }

  showSupplierLedgerReport(){
    isLoading = true; update();
    if(selectedSupplier == ""){
      showToast("Please select supplier!");
      isLoading = false; update();
    }
    else if(selectedFromDateToShow == ""){
      showToast("Please select from date!");
      isLoading = false; update();
    }
    else if(selectedToDateToShow == ""){
      showToast("Please select to date!");
      isLoading = false; update();
    }
    else {
      callSupplierLedgerReportList();
      update();
    }
    update();
  }

  showSupplierLedgerSummaryReport(){
    isLoading = true; update();
    if(selectedFromDateToShow == ""){
      showToast("Please select from date!");
      isLoading = false; update();
    }
    else if(selectedToDateToShow == ""){
      showToast("Please select to date!");
      isLoading = false; update();
    }
    else {
     isViewSelected = true;
     callSupplierLedgerSummaryReportList();
     update();
    }
    update();
  }

  navigateFromReportToHomeScreen(){
    selectedSupplier = "";
    selectedFromDateToShow = ""; selectedToDateToShow = "";
    Get.toNamed(AppRoutes.home);
    update();
  }

  navigateFromSummaryToHomeScreen(){
    selectedFromDateToShow = ""; selectedToDateToShow = "";
    isViewSelected = false;
    Get.toNamed(AppRoutes.home);
    update();
  }

}