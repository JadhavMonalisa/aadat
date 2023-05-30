import 'dart:io';

import 'package:adat/constant/provider/custom_exception.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/home/firm_model.dart';
import 'package:adat/screens/supplier/supplier_model.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';

class HomeController extends GetxController {

  final ApiRepository repository;

  HomeController({required this.repository}) : assert(repository != null);

  String selectedLang = "Language";
  String selectedFirm = "";
  List<String> langList = ["English","Marathi"];
  List<String> noDataList = ["No Data Found"];
  List<String> customerTypeList = ["WEIGHT LIST ( ROUGH BILL )\n(वजन चिट्ठी)", "MARK WISE WEIGHT LIST REPORT\n(मार्कनुसार वजन चिट्ठी)", "BILL",
    "LEDGER SHORT REPORT", "LEDGER SUMMARY REPORT", "LEDGER REPORT", "LEDGER - IN DETAILS"];
  List<String> supplierTypeList = ["LEDGER REPORT", "LEDGER SUMMARY RECEIPT"];
  List<String> farmerList = ["PATTI"];
  bool isLoading = false;
  String token = "";

  @override
  void onInit() {
    super.onInit();
    token = GetStorage().read("clientToken")??"";
    repository.getData();
    callFirmList();
  }

  ///common
  changeLanguage(String value){
    selectedLang = value; update();
  }

  closeAppDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: buildTextBoldWidget('Close App', blackColor, context, 15.0),
          content: buildTextRegularWidget('Are you sure you want to close an App?', blackColor, context, 15.0),
          actions: [
            TextButton(
              child: buildTextBoldWidget('No', blackColor, context, 15.0),
              onPressed: () {
                Navigator.of(context).pop();
                update();
              },
            ),
            TextButton(
              child: buildTextBoldWidget('Yes', blackColor, context, 15.0),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },);
  }

  callLogout(BuildContext context){
    selectedFirm = "";
    selectedFirmId = 0;
    GetStorage().erase();
    GetStorage().remove("selectedFirm");
    GetStorage().remove("selectedFirmId");
    Navigator.of(context).pop();
    Get.toNamed(AppRoutes.login);
    update();
  }

  int? selectedFirmId;

  updateSelectedFirmId(String valueName,int valueId){
    selectedFirmId = valueId;
    selectedFirm = valueName;
    GetStorage().write("selectedFirm", valueName);
    GetStorage().write("selectedFirmId", valueId);
    isLoading = true;
    update();
    callCustomerList();
    callSupplierList();
    update();
  }

  updateSelectedFirm(String value){
    selectedFirm = value;
    GetStorage().write("selectedFirm", value);
    callCustomerList();
    callSupplierList();
    update();
  }

  navigateToSelected(String title,String fromScreen){
    if(selectedFirm == ""){
      showToast("Please select firm!"); update();
    }
    else if(title == "LEDGER REPORT" && fromScreen == "customer"){
      callCustomerList();
      Get.toNamed(AppRoutes.customerLedgerReport); update();
    }
    else if(title == "RECEIPT" && fromScreen == "customer"){
      callCustomerList();
      Get.toNamed(AppRoutes.customerReceipt); update();
    }
    else if(title == "WEIGHT LIST ( ROUGH BILL )\n(वजन चिट्ठी)" && fromScreen == "customer"){
      callCustomerList();
      Get.toNamed(AppRoutes.customerWightListScreen,); update();
    }
    else if(title == "LEDGER SHORT REPORT" && fromScreen == "customer"){
      callCustomerList();
      Get.toNamed(AppRoutes.customerLedgerShortReport); update();
    }
    else if(title == "LEDGER SUMMARY REPORT" && fromScreen == "customer"){
      callCustomerList();
      Get.toNamed(AppRoutes.customerLedgerSummaryReport); update();
    }
    else if(title == "MARK WISE WEIGHT LIST REPORT\n(मार्कनुसार वजन चिट्ठी)" && fromScreen == "customer"){
      callCustomerList();
      Get.toNamed(AppRoutes.customerMarkWiseWeightListReportScreen); update();
    }
    else if(title == "LEDGER REPORT" && fromScreen == "supplier"){
      callSupplierList();
      update();
      Get.toNamed(AppRoutes.supplierLedgerReport); update();
    }
    else if(title == "LEDGER SUMMARY RECEIPT" && fromScreen == "supplier"){
      callSupplierList();
      update();
      Get.toNamed(AppRoutes.supplierLedgerSummaryReport); update();
    }
    else if(title == "PATTI" && fromScreen == "farmer"){
      Get.toNamed(AppRoutes.farmerReceipt); update();
    }
    update();
  }

  bool isCustomerSelected = true;
  bool isSupplierSelected = false;
  bool isFarmerSelected = false;

  checkChoice(bool customerFromScreen, bool supplierFromScreen, bool farmerFromScreen){
    isCustomerSelected = customerFromScreen;
    isSupplierSelected = supplierFromScreen;
    isFarmerSelected = farmerFromScreen;
    update();
  }

  List<FirmDetails> firmList = [];

  callFirmList() async{
    try {
      Utils.dismissKeyboard();
      FirmModel? response = (await repository.getFirmList());
      if (response.statusCode==200) {
        firmList.addAll(response.firmDetails!);
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

  bool isViewSelected = false;
  String selectedCustomer = "";

  navigateFromWeightListToHome(){
    selectedCustomer = ""; isViewSelected = false;
    update();
    Get.toNamed(AppRoutes.home);
  }

  ///-------------Customer------------------///
  ///customer common
  List<CustomerListDetails> customerList = [];
  String selectedFromDateToShow = "";
  String selectedToDateToShow = "";
  DateTime selectedDate = DateTime.now();
  String selectedReceiptBillDateToShow = "";
  String selectedShortReportFromDateToShow = "";
  String selectedShortReportToDateToShow = "";
  String selectedSummaryReportFromDateToShow = "";
  String selectedSummaryReportToDateToShow = "";
  bool showSelectionCustomerList = false;
  bool showCustomerList = false;
  TextEditingController customerName = TextEditingController();

  Future<void> selectCustomerDate(BuildContext context,String selection) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selection == "shortReportToDate" || selection == "summaryReportToDate"
            || selection == "toDate" || selection == "summaryReportToDate"
            ? selectedDate : DateTime(1700, 1),
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
  callCustomerList() async{
    customerList.clear();
    try {
      Utils.dismissKeyboard();
      CustomerListModel? response = (await repository.getCustomerList(selectedFirmId!));
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
  updateSelectedCustomer(String value){
    selectedCustomer = value; update();
  }

  ///weight list
  List<WeightListDetails> weightList = [];
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
  callWeightList() async{
    weightList.clear();
    try {
      Utils.dismissKeyboard();
      WeightListModel? response = (await repository.getWeightList(selectedCustomer,selectedFirmId!));
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

  ///customer ledger short report
  List<LedgerShortReportDetails> ledgerShortReportList = [];

  navigateFromShortReportToHome(){
    selectedFromDateToShow = ""; selectedToDateToShow = ""; isViewSelected = false;
    update();
    Get.toNamed(AppRoutes.home);
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
  backPressNavigation(String screen){
    clearForm();
    Get.toNamed(screen);
  }
  clearForm(){
    customerName.clear(); selectedFromDateToShow = ""; selectedToDateToShow = "";
    update();
  }
  callLedgerShortReportList() async{
    ledgerShortReportList.clear();
    try {
      Utils.dismissKeyboard();
      LedgerShortReportModel? response = (await repository.getCustomerLedgerShortReportList(
          selectedShortReportToDateToShow,selectedShortReportFromDateToShow,selectedFirmId!));
      if (response.statusCode==200) {
        ledgerShortReportList.addAll(response.ledgerShortReportDetails!);
        isLoading = false;
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

  ///customer summary report
  List<LedgerSummaryReportDetails> ledgerSummaryReportList = [];

  navigateFromSummaryToHome(){
    isViewSelected = false; selectedSummaryReportFromDateToShow = ""; selectedSummaryReportToDateToShow = "";
    Get.toNamed(AppRoutes.home);
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
  callLedgerSummaryReportList() async{
    ledgerSummaryReportList.clear();
    try {
      Utils.dismissKeyboard();
      LedgerSummaryReport? response = (await repository.getCustomerLedgerSummaryReportList(
          selectedSummaryReportToDateToShow,selectedSummaryReportFromDateToShow,selectedFirmId!));
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

  ///customer ledger report
  List<CustomerLedgerReportDetails> ledgerReportList = [];

  navigateFromReportToHome(){
    selectedCustomer = ""; selectedFromDateToShow = ""; selectedToDateToShow = "";
    update();
    Get.toNamed(AppRoutes.home);
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
  callLedgerReportList() async{
    ledgerReportList.clear();
    try {
      Utils.dismissKeyboard();
      CustomerLedgerReportModel? response = (await repository.getCustomerLedgerReportList(
          selectedCustomer, selectedToDateToShow,selectedFromDateToShow,selectedFirmId!));
      if (response.statusCode==200) {
        ledgerReportList.addAll(response.customerLedgerReportDetails!);
        isLoading = false;
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

  ///customer mark wise report
  TextEditingController receiptBillNo = TextEditingController();
  TextEditingController receiptSearchParameter = TextEditingController();

  navigateFromMarkWiseToHome(){
    isViewSelected = false; selectedSummaryReportFromDateToShow = ""; selectedSummaryReportToDateToShow = "";
    addedCustomerIndex.clear(); showCustomerList = false; isViewSelected = false;
    Get.toNamed(AppRoutes.home);
    update();
  }
  navigateFromReceiptToHome(){
    receiptBillNo.clear(); receiptSearchParameter.clear(); isViewSelected = false;
    update();
    Get.toNamed(AppRoutes.home);
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

  ///-------------Supplier------------------///
  String selectedSupplier = "";
  List<SupplierListDetails> supplierList = [];
  List<int> addedCustomerIndex = [];
  bool cbCustomer = false;

  ///supplier common
  Future<void> selectSupplierDate(BuildContext context,String selection) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selection == "toDate" || selection == "summaryReportToDate"
            ? selectedDate: DateTime(1700, 1),
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
  callSupplierList() async{
    supplierList.clear();
    try {
      Utils.dismissKeyboard();
      SupplierListModel? response = (await repository.getSupplierList(selectedFirmId!));
      if (response.statusCode==200) {
        supplierList.addAll(response.supplierListDetails!);
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
    update();
  }

  ///supplier ledger report
  List<SupplierLedgerReportDetails> supplierLedgerReportList = [];

  navigateFromReportToHomeScreen(){
    selectedSupplier = "";
    selectedFromDateToShow = ""; selectedToDateToShow = "";
    Get.toNamed(AppRoutes.home);
    update();
  }
  updateSelectedSupplier(String value){
    selectedSupplier = value; update();
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
  callSupplierLedgerReportList() async{
    supplierLedgerReportList.clear();
    try {
      Utils.dismissKeyboard();
      SupplierLedgerReportModel? response = (await repository.getSupplierLedgerReportList(selectedSupplier,
          selectedToDateToShow,selectedFromDateToShow,selectedFirmId!));

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

  ///supplier ledger summary report
  List<SupplierLedgerSummaryReportDetails> supplierLedgerSummaryReportList = [];

  backPressNavigationFromResult(String screen){
    clearForm();
    Get.toNamed(screen);
  }
  navigateFromSummaryToHomeScreen(){
    selectedFromDateToShow = ""; selectedToDateToShow = "";
    isViewSelected = false;
    Get.toNamed(AppRoutes.home);
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
  callSupplierLedgerSummaryReportList() async{
    supplierLedgerSummaryReportList.clear();
    try {
      Utils.dismissKeyboard();
      SupplierLedgerSummaryReportModel? response = (await repository.getSupplierLedgerSummaryReportList(
          selectedToDateToShow,selectedFromDateToShow,selectedFirmId!));

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

///-------------Farmer------------------///
///farmer common
  List<String> farmerTypeList = ["Regular","Paid","Reprint"];
  String selectedFarmerType = "";

  Future<void> selectFarmerDate(BuildContext context,String selection) async {
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


  ///farmer receipt
  TextEditingController pattiNo = TextEditingController();

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
  updateCustomerCheckBoxFromFarmer(bool selectCustomer,int customerIndex){
    cbCustomer = selectCustomer;

    if(addedCustomerIndex.contains(customerIndex)){
      addedCustomerIndex.remove(customerIndex);
    }
    else{
      addedCustomerIndex.add(customerIndex);
    }
    update();
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

}