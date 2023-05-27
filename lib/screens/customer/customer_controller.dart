import 'package:adat/constant/provider/custom_exception.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

class CustomerController extends GetxController {

  final ApiRepository repository;

  CustomerController({required this.repository}) : assert(repository != null);

  TextEditingController customerName = TextEditingController();
  TextEditingController receiptBillNo = TextEditingController();
  TextEditingController receiptSearchParameter = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String selectedFromDateToShow = "";
  String selectedToDateToShow = "";
  String selectedReceiptBillDateToShow = "";
  String selectedShortReportFromDateToShow = "";
  String selectedShortReportToDateToShow = "";
  String selectedSummaryReportFromDateToShow = "";
  String selectedSummaryReportToDateToShow = "";

  bool isViewSelected = false;
  bool showSelectionCustomerList = false;

  List<String> noDataList = ["No Data Found"];
  List<String> customerNameList = ["Customer 1","Customer 2","Customer 3","Customer 4","Customer 5"];
  String selectedFirm = "";
  int selectedFirmId = 0;
  String selectedCustomer = "";

  bool cbCustomer = false;
  bool showCustomerList = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedFirm = GetStorage().read("selectedFirm");
    selectedFirmId = GetStorage().read("selectedFirmId");

    print("selectedFirm in customer");
    print(selectedFirm);
    repository.getData();
  }

  List<CustomerListDetails> customerList = [];
  bool isLoading = false;

  callCustomerList() async{
    try {
      Utils.dismissKeyboard();
      CustomerListModel? response = (await repository.getCustomerList(selectedFirmId));
      if (response.statusCode==200) {
        customerList.addAll(response.customerListDetails!);
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
  }

  List<WeightListDetails> weightList = [];

  callWeightList() async{
    weightList.clear();
    try {
      Utils.dismissKeyboard();
      WeightListModel? response = (await repository.getWeightList(selectedCustomer,selectedFirmId));
      if (response.statusCode==200) {
        weightList.addAll(response.weightListDetails!);
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

  List<MarkWiseWeightListDetails> markWiseWeightList = [];

  // callMarkWiseWeightList() async{
  //   try {
  //     Utils.dismissKeyboard();
  //     MarkWiseWeightListModel? response = (await repository.getMarkWiseWeightList(selectedCustomer,selectedFirmId));
  //     if (response.statusCode==200) {
  //       markWiseWeightList.addAll(response.markWiseWeightListDetails!);
  //       isLoading = false;
  //       update();
  //     }
  //     else {
  //       isLoading = false;
  //       update();
  //     }
  //     update();
  //   } on CustomException catch (e) {
  //     isLoading = false;
  //     update();
  //   } catch (error) {
  //     isLoading = false;
  //     update();
  //   }
  // }

  List<LedgerShortReportDetails> ledgerShortReportList = [];

  callLedgerShortReportList() async{
    ledgerShortReportList.clear();
    try {
      Utils.dismissKeyboard();
      LedgerShortReportModel? response = (await repository.getCustomerLedgerShortReportList(
          selectedShortReportToDateToShow,selectedShortReportFromDateToShow,selectedFirmId));
      if (response.statusCode==200) {
        ledgerShortReportList.addAll(response.ledgerShortReportDetails!);
        isLoading = false;
        print("ledgerShortReportList.length");
        print(ledgerShortReportList.length);
        Get.toNamed(AppRoutes.customerLedgerShortReportResult);
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

  List<LedgerSummaryReportDetails> ledgerSummaryReportList = [];

  callLedgerSummaryReportList() async{
    ledgerSummaryReportList.clear();
    try {
      Utils.dismissKeyboard();
      LedgerSummaryReport? response = (await repository.getCustomerLedgerSummaryReportList(
          selectedSummaryReportToDateToShow,selectedSummaryReportFromDateToShow,selectedFirmId));
      if (response.statusCode==200) {
        ledgerSummaryReportList.addAll(response.ledgerSummaryReportDetails!);
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

  List<CustomerLedgerReportDetails> ledgerReportList = [];

  callLedgerReportList() async{
    ledgerReportList.clear();
    try {
      Utils.dismissKeyboard();
      CustomerLedgerReportModel? response = (await repository.getCustomerLedgerReportList(
        selectedCustomer, selectedToDateToShow,selectedFromDateToShow,selectedFirmId));
      if (response.statusCode==200) {
        ledgerReportList.addAll(response.customerLedgerReportDetails!);
        isLoading = false;
        print("ledgerReportList");
        print(ledgerReportList.length);
        Get.toNamed(AppRoutes.customerLedgerReportResultScreen,
            arguments: [AppRoutes.customerLedgerReport]);
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

    else if(selection == "receiptDate"){
      selectedReceiptBillDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    else if(selection == "shortReportFromDate"){
      selectedShortReportFromDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    else if(selection == "shortReportToDate"){
      selectedShortReportToDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    else if(selection == "summaryReportFromDate"){
      selectedSummaryReportFromDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }
    else if(selection == "summaryReportToDate"){
      showSelectionCustomerList = true;
      selectedSummaryReportToDateToShow = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      update();
    }

    if(selectedSummaryReportFromDateToShow == "" || selectedSummaryReportToDateToShow == ""){

    }
    else{
      showCustomerList = true; update();
    }
  }

  List<int> addedCustomerIndex = [];

  updateCustomerCheckBox(bool selectCustomer,int customerIndex){
    cbCustomer = selectCustomer;

    if(addedCustomerIndex.contains(customerIndex)){
      addedCustomerIndex.clear();
      addedCustomerIndex.remove(customerIndex);
    }
    else{
      addedCustomerIndex.clear();
      addedCustomerIndex.add(customerIndex);
    }

    print("addedCustomerIndex");
    print(addedCustomerIndex);
    update();
  }

  clearForm(){
    customerName.clear(); selectedFromDateToShow = ""; selectedToDateToShow = "";
    update();
  }

  backPressNavigation(String screen){
    clearForm();
    Get.toNamed(screen);
  }

  backPressFromLedgerReport(){
    isViewSelected = false; selectedCustomer = "";
    selectedFromDateToShow = "" ; selectedToDateToShow = "";
    Get.toNamed(AppRoutes.home);
    update();
  }

  backPressFromShortLedger(){
    isViewSelected = false; selectedShortReportFromDateToShow = ""; selectedShortReportToDateToShow = "";
    Get.toNamed(AppRoutes.home);
    update();
  }

  navigateFromMarkWiseToHome(){
    // selectedFirm = ""; selectedFirmId = 0;
    // GetStorage().remove("selectedFirm");
    // GetStorage().remove("selectedFirmId");
    isViewSelected = false; selectedSummaryReportFromDateToShow = ""; selectedSummaryReportToDateToShow = "";
    addedCustomerIndex.clear(); showCustomerList = false; isViewSelected = false;
    Get.toNamed(AppRoutes.home);
    update();
  }

  onViewSelection(){
    isViewSelected = true; update();
  }

  updateSelectedCustomer(String value){
    selectedCustomer = value; update();
  }

  showCustomerLedgerReport(){
    isLoading = true; update();
    if(selectedCustomer == ""){
      showToast("Please select customer!");
      isLoading = false; update();
    }
    else if(selectedToDateToShow == ""){
      showToast("Please select from date!");
      isLoading = false; update();
     }
    else if(selectedFromDateToShow==""){
      showToast("Please select to date!");
      isLoading = false; update();
    }
    else{
      callLedgerReportList();
    }
  }

  getWeightList(){
    isLoading = true;
    if(selectedCustomer == ""){
      showToast("Please select customer!");
      isLoading = false; update();
    }
    else{
      isViewSelected = true;
      callWeightList();
    }
    update();
  }

  getLedgerShortReport(){
    isLoading = true; update();
    if(selectedShortReportToDateToShow==""){
      showToast("Please select to date!");
      isLoading = false; update();
    }
    else if(selectedShortReportFromDateToShow==""){
      showToast("Please select from date!");
      isLoading = false; update();
    }
    else{
      callLedgerShortReportList();
    }
    update();
  }

  getLedgerShortSummaryReport(){
    if(selectedShortReportToDateToShow==""){
      showToast("Please select to date!");
    }
    else if(selectedShortReportFromDateToShow==""){
      showToast("Please select from date!");
    }
    else{
      isViewSelected = true;
    }
    update();
  }

  getLedgerSummaryReport(){
    if(selectedSummaryReportToDateToShow==""){
      showToast("Please select to date!");
    }
    else if(selectedSummaryReportFromDateToShow==""){
      showToast("Please select from date!");
    }
    else{
      isViewSelected = true;
      callLedgerSummaryReportList();
    }
    update();
  }

  getLedgerMarkWise(){
    if(selectedSummaryReportToDateToShow==""){
      showToast("Please select to date!");
    }
    else if(selectedSummaryReportFromDateToShow==""){
      showToast("Please select from date!");
    }
    else{
      isViewSelected = true;
      update();
    }
    update();
  }

  showReceiptReport(){
    if(receiptBillNo.text == ""){
      showToast("Please enter bill no!");
    }
    else if(receiptSearchParameter.text == ""){
      showToast("Please enter search parameter!");
    }
    else{
      isViewSelected = true; update();
    }
  }

  navigateFromReceiptToHome(){
    receiptBillNo.clear(); receiptSearchParameter.clear(); isViewSelected = false;
    update();
    Get.toNamed(AppRoutes.home);
  }

  navigateFromReportToHome(){
    selectedCustomer = ""; selectedFromDateToShow = ""; selectedToDateToShow = "";
    update();
    Get.toNamed(AppRoutes.home);
  }

  navigateFromWeightListToHome(){
    selectedFirm="";selectedFirmId=0;
    selectedCustomer = ""; isViewSelected = false;
    // GetStorage().remove("selectedFirm");
    // GetStorage().remove("selectedFirmId");
    update();
    Get.toNamed(AppRoutes.home);
  }

  navigateFromShortReportToHome(){
    selectedFromDateToShow = ""; selectedToDateToShow = ""; isViewSelected = false;
    update();
    Get.toNamed(AppRoutes.home);
  }

  navigateFromSummaryToHome(){
    isViewSelected = false; selectedSummaryReportFromDateToShow = ""; selectedSummaryReportToDateToShow = "";
    Get.toNamed(AppRoutes.home);
    update();
  }
}