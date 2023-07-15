import 'dart:io';

import 'package:adat/constant/provider/custom_exception.dart';
import 'package:adat/constant/repository/api_repository.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/customer/bill_report_pdf.dart';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/customer/customer_weight_list_pdf.dart';
import 'package:adat/screens/customer/mark_wise_weight_list_report_result.dart';
import 'package:adat/screens/farmer/farmer_model.dart';
import 'package:adat/screens/home/firm_model.dart';
import 'package:adat/screens/home/save_to_mobile.dart';
import 'package:adat/screens/supplier/supplier_model.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:adat/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart' as path_provider;

class HomeController extends GetxController {

  final ApiRepository repository;

  // ignore: unnecessary_null_comparison
  HomeController({required this.repository}) : assert(repository != null);

  String selectedLang = "Language";
  String selectedFirm = "";
  List<String> langList = ["English","Marathi"];
  List<String> noDataList = ["No Data Found"];
  List<String> customerTypeList = ["WEIGHT LIST ( ROUGH BILL )\n(वजन चिट्ठी)", "MARK WISE WEIGHT LIST REPORT\n(मार्कनुसार वजन चिट्ठी)", "BILL",
    "LEDGER SHORT REPORT", "LEDGER SUMMARY REPORT", "LEDGER REPORT"];
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

    weightListForExport = getWeightListData();
    weightListDataSource = WeightListDataSource(weightListData: weightListForExport);

    markWiseWeightListExport = getMarkWiseWeightListDataForPdf();
    markWiseWeightListDataSource = MarkWiseWeightListDataSource(weightListData: markWiseWeightListExport);

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
    Get.offNamed(AppRoutes.login);
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
    else if(title == "BILL" && fromScreen == "customer"){
      Get.toNamed(AppRoutes.customerBillReportScreen); update();
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
      isLoading = true;
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
      //getFarmerPattiList();
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
  String selectedDateForWeightList = "";
  TextEditingController searchController = TextEditingController();

  navigateFromWeightListToHome(){
    customerByDateList.clear();weightList.clear();
    addedWeightListIndex.clear();
    weightListSelectedCustomerName = ""; isViewSelected = false;selectedDateForWeightList = "";
    loaderForCustomer = false; isBillDateAdded = false;
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
  String selectedBillDateToShow = "";
  bool showSelectionCustomerList = false;
  bool showCustomerList = false;
  bool isBillDateAdded = false;
  TextEditingController customerName = TextEditingController();

  Future<void> selectCustomerDate(BuildContext context,String selection) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1700, 1),
        lastDate: DateTime(2100, 1));

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }

    if (selection == "forWeightList"){
      selectedDateForWeightList = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      selectedDateForWeightList == ""? null: validateCustomerMarkWiseReport(selectedDateForWeightList);

      selectedDateForWeightList == "" ? isBillDateAdded = false : isBillDateAdded = true;
      update();
    }
    else if(selection == "fromDate"){
      selectedFromDateToShow = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      update();
    }
    else if(selection == "toDate"){
      selectedToDateToShow = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      update();
    }
    else if(selection == "receiptDate"){
      selectedReceiptBillDateToShow = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      update();
    }
    else if(selection == "shortReportFromDate"){
      selectedShortReportFromDateToShow = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      update();
    }
    else if(selection == "shortReportToDate"){
      selectedShortReportToDateToShow = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      update();
    }
    else if(selection == "summaryReportFromDate"){
      selectedSummaryReportFromDateToShow = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      update();
    }
    else if(selection == "bill date"){
      billDate = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      update();
    }
    else if(selection == "summaryReportToDate"){
      showSelectionCustomerList = true;
      selectedSummaryReportToDateToShow = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      update();
    }
    else if(selection == "markWiseBillDate"){
      //showSelectionCustomerList = true;
      selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month;

      selectedBillDateToShow = "${selectedDate.day.toString().length == 1 ? "0${selectedDate.day.toString()}" : selectedDate.day}/${selectedDate.month.toString().length == 1 ? "0${selectedDate.month.toString()}" : selectedDate.month}/${selectedDate.year}";
      showCustomerList = true;

      selectedBillDateToShow == ""? null: validateCustomerMarkWiseReport(selectedBillDateToShow);
      update();
    }

    if(selectedSummaryReportFromDateToShow == "" || selectedSummaryReportToDateToShow == "" || selectedBillDateToShow == ""){

    }
    else{
      showCustomerList = true; update();
    }
  }
  callCustomerList() async{
    customerList.clear();
    isLoading=true;
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

  List<CustomerListByDateData> customerByDateList = [];
  bool loaderForCustomer = false;
  bool loaderForWeightList = false;

  validateCustomerMarkWiseReport(String date){
    isLoading=true;
    loaderForCustomer = true;
    callCustomerByDateList(date);
  }
  callCustomerByDateList(String date) async{
    customerByDateList.clear();
    try {
      Utils.dismissKeyboard();
      CustomerListByDateModel? response = (await repository.getCustomerByDateList(date,selectedFirmId!));
      if (response.statusCode==200) {
        customerByDateList.addAll(response.customerListByDateData!);
        isLoading = false;
        loaderForCustomer = false;
        update();
      }
      else {
        isLoading = false;
        loaderForCustomer = false;
        update();
      }
      update();
    } on CustomException catch (e) {
      isLoading = false;
      loaderForCustomer = false;
      update();
    } catch (error) {
      isLoading = false;
      loaderForCustomer = false;
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
    loaderForWeightList = true;
    if(weightListSelectedCustomerName == ""){
      showToast("Please select customer!");
      isLoading = false;
      loaderForWeightList = false;
      update();
    }
    else{
      isViewSelected = true;
      loaderForWeightList = true;
      callWeightList();
    }
    update();
  }

  List<WeightListDetails> getWeightListData() {
    for (var element in weightListForExport) {
      WeightListDetails(
        billDate: element.billDate,
        custAccountName: element.custAccountName,
        qty: element.qty,
        rate: element.rate,
        remark: element.remark,
        suppAccountName: element.suppAccountName,
        weight: element.weight
      );
    }
    return weightListForExport;
  }
  List<MarkWiseWeightListDetails> getMarkWiseWeightListDataForPdf() {
    for (var element in markWiseWeightListExport) {
      MarkWiseWeightListDetails(
        billDate: element.billDate,
        custAccountName: element.custAccountName,
        qty: element.qty,
        weight: element.weight,
        amount: element.amount,
        mark: element.mark
      );
    }
    return markWiseWeightListExport;
  }

  List<MarkWiseWeightListDetails> markWiseWeightList = [];

  getMarkWiseWeightList(){
    if(selectedBillDateToShow == ""){
      showToast("Please select bill date!"); update();
    }
    else if(selectedCustNo == 0){
      showToast("Please select customer!"); update();
    }
    else{
      callMarkWiseWeightListReport();
    }
    update();
  }

  callWeightList() async{
    //Get.toNamed(AppRoutes.customerWeightListExportScreen);
    weightList.clear();
    weightListForExport.clear();
    try {
      Utils.dismissKeyboard();
      WeightListModel? response = (await repository.getWeightList(weightListSelectedCustomerName,selectedFirmId!,selectedDateForWeightList));
      if (response.statusCode==200) {
        weightList.addAll(response.weightListDetails!);
        weightListForExport.addAll(response.weightListDetails!);
        weightListDataSource = WeightListDataSource(weightListData: weightListForExport);
        isLoading = false;
        loaderForWeightList = false;
        update();
      }
      else {
        isLoading = false;
        loaderForWeightList = false;
        update();
      }
      update();
    } on CustomException catch (e) {
      isLoading = false;
      loaderForWeightList = false;
      update();
    } catch (error) {
      isLoading = false;
      loaderForWeightList = false;
      update();
    }
    update();
  }

  callMarkWiseWeightListReport() async{

    markWiseWeightList.clear();
    try {
      Utils.dismissKeyboard();
      MarkWiseWeightList? response = (await repository.getMarkWiseWeightList(selectedCustNo,selectedBillDateToShow,selectedFirmId!));

      if (response.statusCode==200) {
        markWiseWeightList.addAll(response.markWiseWeightListDetails!);
        markWiseWeightListDataSource = MarkWiseWeightListDataSource(weightListData: markWiseWeightList);
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
    Get.toNamed(AppRoutes.markWiseWeightListResultReport);
    update();
  }

  ///customer ledger short report
  //List<LedgerShortReportDetails> ledgerShortReportList = [];
  List<LedgerShortReportDetails> ledgerShortReportList = [];
  List<int> totalCustomerLedgerShortAmtList = [];

  navigateFromShortReportToHome(){
    selectedShortReportFromDateToShow = ""; selectedShortReportToDateToShow = "";
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
      isLoading = true;
      callLedgerShortReportList();
    }
    update();
  }
  backPressNavigation(String screen){
    clearForm();
    totalSupplierLedgerReportDebit=0;
    totalSupplierLedgerReportCredit=0;
    totalCustomerLedgerShortAmtList.clear();
    ledgerShortReportList.clear();
    addedAmt = 0;
    totalAmt = 0;
    editingController.clear();
    update();
    Get.toNamed(screen);
  }
  clearForm(){
    ledgerReportList.clear(); totalPaymentAmt = 0; totalReceiptAmt = 0;
    customerName.clear(); selectedFromDateToShow = ""; selectedToDateToShow = "";
    update();
  }

  int addedAmt = 0;
  List<ShortReportList> shortReportList = [];
  int total = 0;
  int totalAmt = 0;

  callLedgerShortReportList() async{
    ledgerShortReportList.clear();
    shortReportList.clear();
    try {
      Utils.dismissKeyboard();
      LedgerShortReportModel? response = (await repository.getCustomerLedgerShortReportList(
          selectedShortReportToDateToShow,selectedShortReportFromDateToShow,selectedFirmId!));
      if(response.statusCode==200){
        ledgerShortReportList.addAll(response.result!);

        for (var element1 in ledgerShortReportList) {
          total = 0;
          for (var element2 in element1.shortReportList!) {
            String amt = element2.amount! == "-" || element2.amount! == "" ? "0" : element2.amount!;
            total = total + int.parse(amt);
          }
          totalCustomerLedgerShortAmtList.add(total);
        }

        isLoading = false;
        update();
      }
      else{
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
    Get.toNamed(AppRoutes.customerLedgerShortReportResult);
    update();
  }

  TextEditingController editingController = TextEditingController();
  bool noDataFoundForSearch = true;

  void filterSearchResults(String query) {

    // var newList = ledgerShortReportList.where(
    //         (t) => t.accountName!.toLowerCase().contains(query.toLowerCase()) ||
    //             t.accountName!.toUpperCase().contains(query.toLowerCase())
    // ).toList();

    List<LedgerShortReportDetails> resultList = [];
    List<ShortReportList> resultShortList = [];

    var newList = ledgerShortReportList.where(
            (t) => t.shortReportList!.any((element) =>
            element.accountName!.contains(query.toUpperCase()) || element.accountName!.contains(query.toLowerCase())))
        .toList();

    // for (int i =0;i<ledgerShortReportList.length; i++){
    //   for(int j=0; j<ledgerShortReportList[i].shortReportList!.length; j++){
    //     if(ledgerShortReportList[i].shortReportList!.any((element) =>
    //         element.accountName!.contains(query.toUpperCase()))){
    //       print("present");
    //
    //       for (var element in ledgerShortReportList[i].shortReportList!) {
    //         resultShortList.add(
    //             ShortReportList(
    //               acctNo:element.acctNo,
    //               billDate: element.billDate,
    //               accountName: element.accountName,
    //               amount: element.amount
    //             )
    //         );
    //       }
    //
    //       resultList.add(LedgerShortReportDetails(
    //         shortReportList:resultShortList,
    //         acctNo: ledgerShortReportList[i].acctNo,
    //         total: 0
    //       ));
    //
    //       resultList.forEach((element) {
    //        element.shortReportList!.forEach((element2) {
    //          print("element2.accountName");
    //          print(element2.accountName);
    //        });
    //       });
    //
    //         ledgerShortReportList.clear();
    //         noDataFoundForSearch = false;
    //         ledgerShortReportList = resultList;
    //
    //         update();
    //     }
    //     else{
    //       ledgerShortReportList.clear();
    //       print("not present");
    //       update();
    //     }
    //   }
    //   update();
    // }

    //     var newList = ledgerShortReportList.where(
    //         (t) => t.shortReportList!.any((element)
    //         {
    //           bool test = ledgerShortReportList.any((element) =>
    //               element.shortReportList!.any((element2) => element2.accountName=="RM"));
    //           print("test");
    //           print(test);
    //           print(element.accountName  == query.toUpperCase());
    //           return element.accountName  == query.toUpperCase();
    //         })
    // ).toList();

    // print("newList");
    // print(newList.length);
    //
    if(newList.isEmpty){
      ledgerShortReportList.clear();
      totalCustomerLedgerShortAmtList.clear();
      update();
    }
    else{
      ledgerShortReportList.clear();
      totalCustomerLedgerShortAmtList.clear();
      noDataFoundForSearch = false;
      ledgerShortReportList = newList;

      for (var element1 in ledgerShortReportList) {
        total = 0;
        for (var element2 in element1.shortReportList!) {
          total = total + int.parse(element2.amount!);
        }
        totalCustomerLedgerShortAmtList.add(total);
      }

      update();
    }

    update();
  }

  ///customer summary report
  List<LedgerSummaryReportDetails> ledgerSummaryReportList = [];

  navigateFromSummaryToHome(){
    totalCreditForLedgerSummary = 0;
    totalDebitForLedgerSummary = 0;
    isViewSelected = false; selectedSummaryReportFromDateToShow = ""; selectedSummaryReportToDateToShow = "";
    Get.toNamed(AppRoutes.home);
    update();
  }
  getLedgerSummaryReport(){
    isLoading = true;
    if(selectedSummaryReportToDateToShow==""){
      showToast("Please select to date!"); isLoading = false; update();
    }
    else if(selectedSummaryReportFromDateToShow==""){
      showToast("Please select from date!"); isLoading = false; update();
    }
    else{
      isViewSelected = true;
      callLedgerSummaryReportList();
    }
    update();
  }

  int totalCreditForLedgerSummary = 0;
  int totalDebitForLedgerSummary = 0;

  callLedgerSummaryReportList() async{
    ledgerSummaryReportList.clear();
    try {
      Utils.dismissKeyboard();
      LedgerSummaryReport? response = (await repository.getCustomerLedgerSummaryReportList(
          selectedSummaryReportToDateToShow,selectedSummaryReportFromDateToShow,selectedFirmId!));
      if (response.statusCode==200) {
        ledgerSummaryReportList.addAll(response.ledgerSummaryReportDetails!);

        for (var element in ledgerSummaryReportList) {

          String debitAmt  = element.debitAmount == "-" || element.debitAmount == "" ? "0" : element.debitAmount!;
          String creditAmt  = element.creditAmount == "-" || element.creditAmount == ""? "0" : element.creditAmount!;

          totalDebitForLedgerSummary= totalDebitForLedgerSummary + int.parse(debitAmt);
          totalCreditForLedgerSummary= totalCreditForLedgerSummary + int.parse(creditAmt);
        }
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

  int totalReceiptAmt = 0;
  int totalPaymentAmt = 0;

  callLedgerReportList() async{
    ledgerReportList.clear();
    try {
      Utils.dismissKeyboard();
      CustomerLedgerReportModel? response = (await repository.getCustomerLedgerReportList(
          selectedCustomer, selectedToDateToShow,selectedFromDateToShow,selectedFirmId!));
      if (response.statusCode==200) {
        ledgerReportList.addAll(response.customerLedgerReportDetails!);

        for (var element in ledgerReportList) {
          String payAmtToAdd  = element.paymentAmonut == "-" || element.paymentAmonut == "" ? "0" : element.paymentAmonut!;
          String recAmtToAdd  = element.recieptAmount == "-" || element.recieptAmount == "" ? "0" : element.recieptAmount!;

          totalReceiptAmt= totalReceiptAmt + int.parse(recAmtToAdd);
          totalPaymentAmt= totalPaymentAmt + int.parse(payAmtToAdd);
        }
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

  List<BillReportListData> billReportList = [];
  TextEditingController billNo = TextEditingController();
  String billDate = "";
  bool showBillReport = false;

  bool showBillDate = true;
  bool showBillNo = true;

  void onBillDateSelectionChange(BuildContext context){
    showBillDate = true; showBillNo = false; Utils.dismissKeyboard();
    selectCustomerDate(context,"bill date");
    billNo.clear();
    update();
  }
  void onBillNoSelectionChange(){
    showBillDate = false; showBillNo = true;
    billDate="";
    update();
  }


  ///bill report list
  callBillReportList() async{
    billReportList.clear();
    try {
      Utils.dismissKeyboard();
      BillReportModel? response = (await repository.getCustomerBillReportList(
          billNo.text,billDate,selectedFirmId!));

      print(response.statusCode);
      if (response.statusCode==200) {
        billReportList.addAll(response.billReportListData!);
        isLoading = false;
        update();
      }
      else {
        isLoading = false;
        update();
      }
      print("billReportList.length");
      print(billReportList.length);
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

  navigateFromBillReportPdf(){

  }

  showBillResult(){
    // if(billNo.text==""){
    //   Utils.showErrorSnackBar("Please enter bill no");update();
    // }
    // else if(billDate==""){
    //   Utils.showErrorSnackBar("Please enter bill date");update();
    // }
    // else{
    //   showBillReport = true; update();
    //   callBillReportList();
    // }
    isLoading = true;
    showBillReport = true;
    callBillReportList();
    update();
  }

  onBackPressFromBillReport(){
    billReportList.clear();
    billNo.clear(); billDate = ""; showBillReport = false;
    showBillNo= true; showBillDate = true;
    update();
    Get.toNamed(AppRoutes.home);
  }

  ///customer mark wise report
  TextEditingController receiptBillNo = TextEditingController();
  TextEditingController receiptSearchParameter = TextEditingController();

  navigateFromMarkWiseToHome(){
    isViewSelected = false;
    selectedSummaryReportFromDateToShow = ""; selectedSummaryReportToDateToShow = "";
    selectedBillDateToShow = "";
    customerByDateList.clear();
    addedCustomerIndex.clear(); showCustomerList = false; isViewSelected = false;
    selectedDate = DateTime.now();
    Get.toNamed(AppRoutes.home);
    update();
  }

  navigateFromReceiptToHome(){
    receiptBillNo.clear(); receiptSearchParameter.clear(); isViewSelected = false;
    update();
    Get.toNamed(AppRoutes.home);
  }

  navigateFromFarmerReceiptToHome(){
    farmerPattiList.clear();
    isViewSelected = false; showPattiDate = true; showPattiNo = true;
    selectedFromDateToShow=""; pattiNo.clear();
    selectedDate = DateTime.now();
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
  List<int> addedMarkWiseListIndex = [];
  List<int> addedWeightListIndex = [];
  bool cbCustomer = false;
  bool cbMarkWiseCustomer = false;

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
    Utils.dismissKeyboard();
  }

  List<String> supplierNameList = [];
  String searchValue = '';

  callSupplierList() async{
    supplierList.clear(); supplierNameList.clear();
    try {
      Utils.dismissKeyboard();
      SupplierListModel? response = (await repository.getSupplierList(selectedFirmId!));
      if (response.statusCode==200) {
        supplierList.addAll(response.supplierListDetails!);

        for (var element in supplierList) {
          supplierNameList.add(element.suppAccountName!);
          update();
        }
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

  onSearchSelection(String value){
    searchValue = value;update();
  }

  int selectedCustNo = 0;
  String selectedCustomerNameInMarkList = "";
  updateCustomerCheckBox(bool selectCustomer,int customerIndex,int custNo,String custName){
    cbCustomer = selectCustomer;
    selectedCustNo = custNo;
    selectedCustomerNameInMarkList = custName;

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
  updateMarkWiseListCheckBox(bool selectCustomer,int customerIndex){
    cbMarkWiseCustomer = selectCustomer;

    if(addedMarkWiseListIndex.contains(customerIndex)){
      addedMarkWiseListIndex.clear();
      addedMarkWiseListIndex.remove(customerIndex);
    }
    else{
      addedMarkWiseListIndex.clear();
      addedMarkWiseListIndex.add(customerIndex);
    }
    update();
  }

  String weightListSelectedCustomerName = "";
  updateWeightListCheckBox(bool selectCustomer,int customerIndex,String selectedCustomerName){
    //cbMarkWiseCustomer = selectCustomer;
    weightListSelectedCustomerName = selectedCustomerName;
    if(addedWeightListIndex.contains(customerIndex)){
      addedWeightListIndex.clear();
      addedWeightListIndex.remove(customerIndex);
    }
    else{
      addedWeightListIndex.clear();
      addedWeightListIndex.add(customerIndex);
    }
    update();
  }

  ///supplier ledger report
  List<SupplierLedgerReportDetails> supplierLedgerReportList = [];
  int totalSupplierLedgerReportDebit = 0;
  int totalSupplierLedgerReportCredit = 0;

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

        for (var element in response.supplierLedgerReportDetails!) {
          String debitAmt  = element.debitAmt == "-" || element.debitAmt == "" ? "0" : element.debitAmt!;
          String creditAmt  = element.creditAmt == "-" || element.creditAmt == ""? "0" : element.creditAmt!;

          totalSupplierLedgerReportDebit = totalSupplierLedgerReportDebit + int.parse(debitAmt);
          totalSupplierLedgerReportCredit = totalSupplierLedgerReportCredit + int.parse(creditAmt);
        }
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
    Get.toNamed(AppRoutes.supplierResult);
  }

  ///supplier ledger summary report
  List<SupplierLedgerSummaryReportDetails> supplierLedgerSummaryReportList = [];

  backPressNavigationFromResult(String screen){
    clearForm();
    Get.toNamed(screen);
  }
  navigateFromSummaryToHomeScreen(){
    selectedFromDateToShow = ""; selectedToDateToShow = "";
    isViewSelected = false; supplierLedgerSummaryReportList.clear();
    totalSupplierLedgerSummaryReportDebit = 0;
    totalSupplierLedgerSummaryReportCredit = 0;
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

  int totalSupplierLedgerSummaryReportDebit = 0;
  int totalSupplierLedgerSummaryReportCredit= 0;

  callSupplierLedgerSummaryReportList() async{
    supplierLedgerSummaryReportList.clear();
    try {
      Utils.dismissKeyboard();
      SupplierLedgerSummaryReportModel? response = (await repository.getSupplierLedgerSummaryReportList(
          selectedToDateToShow,selectedFromDateToShow,selectedFirmId!));

      if (response.statusCode==200) {
        supplierLedgerSummaryReportList.addAll(response.supplierLedgerSummaryReportDetails!);
        isLoading = false;

        for (var element in response.supplierLedgerSummaryReportDetails!) {
          String debitAmt  = element.debitAmount == "-" || element.debitAmount == "" ? "0" : element.debitAmount!;
          String creditAmt  = element.creditAmount == "-" || element.creditAmount == ""? "0" : element.creditAmount!;

          totalSupplierLedgerSummaryReportDebit = totalSupplierLedgerSummaryReportDebit + int.parse(debitAmt);
          totalSupplierLedgerSummaryReportCredit = totalSupplierLedgerSummaryReportCredit + int.parse(creditAmt);
        }
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

  List<SupplierSearchData> supplierSearchList = [];
  SupplierSearchData pro = SupplierSearchData();

   Future callSupplierSearchList(String searchName) async{
    supplierSearchList.clear();
    try {
      SupplierSearchModel? response = (await repository.getSupplierSearchUrlList(
          searchName,selectedFirmId!));

      if (response.statusCode==200) {
        supplierSearchList.addAll(response.supplierSearchData!);
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
      selectedFromDateToShow = "${selectedDate.day.toString().length==1 ? "0${selectedDate.day}":selectedDate.day}/"
          "${selectedDate.month.toString().length==1?"0${selectedDate.month}":selectedDate.month}/${selectedDate.year}";
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
      //showPattiDate = false;
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

  bool showPattiDate = true;
  bool showPattiNo = true;

  void onPattiDateSelectionChange(BuildContext context){
    showPattiDate = true; showPattiNo = false; Utils.dismissKeyboard();
    selectFarmerDate(context,"fromDate");
    pattiNo.clear();
    update();
  }
  void onPattiNoSelectionChange(){
    showPattiDate = false; showPattiNo = true;
    selectedFromDateToShow="";
    update();
  }

  showFarmerReceiptResult(){
    // // if(selectedFarmerType == ""){
    // //   showToast("Please select farmer type!");
    // // }
    // //else
    // //   if(selectedFromDateToShow == ""){
    // //   showToast("Please select date!");
    // // }
    //  // else
    // if(pattiNo.text.isEmpty){
    //     showToast("Please select patti no!");
    //   }
    // // else if(selectedCustomer == ""){
    // //   showToast("Please select customer!");
    // // }
    // else{
    //   isViewSelected = true;
    //   callFarmerPattiList(); update();
    // }
    isLoading = true;
    isViewSelected = true;
    callFarmerPattiList(); update();
  }

  List<FarmerPattiDetailsList> farmerPattiList = [];

  callFarmerPattiList() async{
    farmerPattiList.clear();
    try {
      Utils.dismissKeyboard();
      FarmerPattiDetailsModel? response = (await repository.getFarmerPattiList(
          pattiNo.text.isEmpty ? 0 : int.parse(pattiNo.text),
          selectedFromDateToShow == "" ? "0" : selectedFromDateToShow,selectedFirmId!));
      if (response.statusCode==200) {
        farmerPattiList.addAll(response.farmerPattiDetailsList!);
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

  navigateToCustomerWeightListExportScreen() {
    //callWeightList();
    Get.toNamed(AppRoutes.customerWeightListExportScreen);
  }

//   getApplicationDocumentsDirectory(){
//     Directory(appDocDirectory.path+'/'+'dir').create(recursive: true)
// // The created directory is returned as a Future.
//         .then((Directory directory) {
//       print('Path of New Dir: '+directory.path);
//     });
//
//   }
  Future<void> downloadPdf() async {
    final pdf = pw.Document();
    Directory appDocDirectory = await path_provider.getApplicationDocumentsDirectory();
    String path = "";

//     Directory('${appDocDirectory.path}/dir').create(recursive: true)
// // The created directory is returned as a Future.
//         .then((Directory directory) {
//           path = directory.path;
//       print('Path of New Dir: ${directory.path}');
//     });

    Directory tempDir = await path_provider.getTemporaryDirectory();
    String tempPath = tempDir.path;


    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hello World!'),
        ),
      ),
    );

    //  Directory('dir/subdir').create(recursive: true)
    // // The created directory is returned as a Future.
    //     .then((Directory directory) {
    //   path = directory.path;
    //   print(directory.path);
    // });

    final file = File(tempPath);
    file.open();
    await file.writeAsBytes(await pdf.save());
  }

  List<WeightListDetails> weightListForExport = <WeightListDetails>[];
  late WeightListDataSource weightListDataSource;

  onExportBackScreen(){
    update();
  }

  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  // Future<void> exportDataGridToPdf() async {
  //   final PdfDocument document =
  //   key.currentState!.exportToPdfDocument(fitAllColumnsInOnePage: true);
  //
  //   final List<int> bytes = document.saveSync();
  //   await saveAndLaunchFile(bytes, 'DataGrid.pdf');
  //
  //   document.dispose();
  // }

  List<MarkWiseWeightListDetails> markWiseWeightListExport = <MarkWiseWeightListDetails>[];
  late MarkWiseWeightListDataSource markWiseWeightListDataSource;

}