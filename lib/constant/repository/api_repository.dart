
import 'dart:convert';
import 'dart:io';

import 'package:adat/constant/api_endpoint.dart';
import 'package:adat/constant/provider/api.dart';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/farmer/farmer_model.dart';
import 'package:adat/screens/home/firm_model.dart';
import 'package:adat/screens/supplier/supplier_model.dart';
import 'package:adat/utils/custom_response.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({required this.apiClient});

  int? clientId;
  String? token;

  Map<String, String> multipartHeaders = { "Content-Type": "multipart/form-data"};

  getData(){
    clientId = GetStorage().read("clientId");
    token = GetStorage().read("clientToken")??"";
  }

  ///login api
  Future<LoginResponse> doLogin(String? username,String? password,) async {
    Map<String, String> headers = { "Content-Type": "application/json"};
    var params = {"Name":username,"Password":password,};
    final response = await apiClient.post(
      ApiEndpoint.loginUrl,body: params, headers: headers,
    );
    return LoginResponse.fromJson(response);
  }
  ///firm list api
  Future<FirmModel> getFirmList() async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.firmListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"clientID": clientId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return FirmModel.fromJson(jsonBody);
  }
  ///customer list api
  Future<CustomerListModel> getCustomerList(int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.customerListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"clientID": clientId,"firmID":firmId};
    request.body = jsonEncode(params);

    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return CustomerListModel.fromJson(jsonBody);
  }
  ///weight list api
  Future<WeightListModel> getWeightList(String custName,int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.weightListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"CustomerName":custName,"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return WeightListModel.fromJson(jsonBody);
  }
  ///mark wise weight list--inprocess
  Future<MarkWiseWeightListModel> getMarkWiseWeightList(String custNo,String billDate,int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.markWiseWeightListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"CustNo":custNo,"BillDate":billDate,"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return MarkWiseWeightListModel.fromJson(jsonBody);
  }
  ///ledger short report
  Future<LedgerShortReportModel> getCustomerLedgerShortReportList(String toDate,String fromDate,int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.customerLedgerShortReportListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"toDate":toDate,"fromDate":fromDate,"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LedgerShortReportModel.fromJson(jsonBody);
  }
  ///ledger summary report
  Future<LedgerSummaryReport> getCustomerLedgerSummaryReportList(String toDate,String fromDate,int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.customerLedgerSummaryReportListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"ToDate":toDate,"FromDate":fromDate,"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return LedgerSummaryReport.fromJson(jsonBody);
  }
  ///ledger report
  Future<CustomerLedgerReportModel> getCustomerLedgerReportList(String custName,String toDate,String fromDate,int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.customerLedgerReportListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"CustomerName":custName,"Todate":toDate,"Fromdate":fromDate,"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return CustomerLedgerReportModel.fromJson(jsonBody);
  }
  ///supplier list
  Future<SupplierListModel> getSupplierList(int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.supplierListUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return SupplierListModel.fromJson(jsonBody);
  }
  ///supplier ledger report
  Future<SupplierLedgerReportModel> getSupplierLedgerReportList(String supplierName,String toDate,String fromDate,int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.supplierLedgerReportUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"SupplierName":supplierName,"Fromdate":fromDate,"Todate":toDate,"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return SupplierLedgerReportModel.fromJson(jsonBody);
  }
  ///supplier ledger summary report
  Future<SupplierLedgerSummaryReportModel> getSupplierLedgerSummaryReportList(String toDate,String fromDate,int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.supplierLedgerSummaryReportUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"FromDate":fromDate,"ToDate":toDate,"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return SupplierLedgerSummaryReportModel.fromJson(jsonBody);
  }
  ///farmer receipt
  Future<FarmerPattiModel> getFarmerPattiList(int pattiNo,String pattiDate,int firmId) async {
    var request = http.Request(
      'GET', Uri.parse(ApiEndpoint.farmerPattiUrl),
    )..headers.addAll({
      "Authorization": 'Bearer $token',
      HttpHeaders.contentTypeHeader: "application/json",
    });

    var params = {"PattiNo":pattiNo,"PattiDate":pattiDate,"ClientID": clientId,"FirmID":firmId};
    request.body = jsonEncode(params);
    http.StreamedResponse response = await request.send();
    final responsebody = await response.stream.bytesToString();

    Map<String, dynamic> jsonBody = json.decode(responsebody);
    return FarmerPattiModel.fromJson(jsonBody);
  }

}