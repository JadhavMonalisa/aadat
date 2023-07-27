class SupplierListModel {
  int? statusCode;
  List<SupplierListDetails>? supplierListDetails;

  SupplierListModel({this.statusCode, this.supplierListDetails});

  SupplierListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      supplierListDetails = <SupplierListDetails>[];
      json['result'].forEach((v) {
        supplierListDetails!.add(SupplierListDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (supplierListDetails != null) {
      data['result'] = supplierListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierListDetails {
  int? suppAccountNo;
  String? suppAccountName;
  String? city;

  SupplierListDetails({this.suppAccountNo, this.suppAccountName, this.city});

  SupplierListDetails.fromJson(Map<String, dynamic> json) {
    suppAccountNo = json['suppAccountNo'];
    suppAccountName = json['suppAccountName'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suppAccountNo'] = suppAccountNo;
    data['suppAccountName'] = suppAccountName;
    data['city'] = city;
    return data;
  }
}

class SupplierLedgerReportModel {
  int? statusCode;
  List<SupplierLedgerReportDetails>? supplierLedgerReportDetails;

  SupplierLedgerReportModel({this.statusCode, this.supplierLedgerReportDetails});

  SupplierLedgerReportModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      supplierLedgerReportDetails = <SupplierLedgerReportDetails>[];
      json['result'].forEach((v) {
        supplierLedgerReportDetails!.add(SupplierLedgerReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (supplierLedgerReportDetails != null) {
      data['result'] = supplierLedgerReportDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierLedgerReportDetails {
  String? suppAccountName;
  String? tranDate;
  String? ledgerName;
  String? narration;
  String? creditAmt;
  String? debitAmt;

  SupplierLedgerReportDetails(
      {this.suppAccountName,
        this.tranDate,
        this.ledgerName,
        this.narration,
        this.creditAmt,
        this.debitAmt});

  SupplierLedgerReportDetails.fromJson(Map<String, dynamic> json) {
    suppAccountName = json['suppAccountName'].toString();
    tranDate = json['tran_date'].toString();
    ledgerName = json['ledgerName'].toString();
    narration = json['narration'].toString();
    creditAmt = json['creditAmt'].toString();
    debitAmt = json['debitAmt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suppAccountName'] = suppAccountName;
    data['tran_date'] = tranDate;
    data['ledgerName'] = ledgerName;
    data['narration'] = narration;
    data['creditAmt'] = creditAmt;
    data['debitAmt'] = debitAmt;
    return data;
  }
}

class SupplierLedgerSummaryReportModel {
  int? statusCode;
  List<SupplierLedgerSummaryReportDetails>? supplierLedgerSummaryReportDetails;

  SupplierLedgerSummaryReportModel({this.statusCode, this.supplierLedgerSummaryReportDetails});

  SupplierLedgerSummaryReportModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      supplierLedgerSummaryReportDetails = <SupplierLedgerSummaryReportDetails>[];
      json['result'].forEach((v) {
        supplierLedgerSummaryReportDetails!.add(SupplierLedgerSummaryReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (supplierLedgerSummaryReportDetails != null) {
      data['result'] = supplierLedgerSummaryReportDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierLedgerSummaryReportDetails {
  String? acctNO;
  String? suppAccountName;
  String? debitAmount;
  String? creditAmount;
  String? mobile;

  SupplierLedgerSummaryReportDetails(
      {this.acctNO,
        this.suppAccountName,
        this.debitAmount,
        this.creditAmount,
        this.mobile});

  SupplierLedgerSummaryReportDetails.fromJson(Map<String, dynamic> json) {
    acctNO = json['acctNO'].toString();
    suppAccountName = json['suppAccountName'].toString();
    debitAmount = json['debitAmount']==0 ? "0":json['debitAmount'].toString();
    creditAmount = json['creditAmount']==0 ? "0":json['creditAmount'].toString();
    // creditAmount = json['creditAmount'].toString();
    mobile = json['mobile'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acctNO'] = acctNO;
    data['suppAccountName'] = suppAccountName;
    data['debitAmount'] = debitAmount;
    data['creditAmount'] = creditAmount;
    data['mobile'] = mobile;
    return data;
  }
}

class SupplierSearchModel {
  int? statusCode;
  List<SupplierSearchData>? supplierSearchData;

  SupplierSearchModel({this.statusCode, this.supplierSearchData});

  SupplierSearchModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      supplierSearchData = <SupplierSearchData>[];
      json['result'].forEach((v) {
        supplierSearchData!.add(SupplierSearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (supplierSearchData != null) {
      data['result'] = supplierSearchData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierSearchData {
  String? suppAccountNo;
  String? suppAccountName;
  String? city;

  SupplierSearchData({this.suppAccountNo, this.suppAccountName, this.city});

  SupplierSearchData.fromJson(Map<String, dynamic> json) {
    suppAccountNo = json['suppAccountNo']==null?"":json['suppAccountNo'].toString();
    suppAccountName = json['suppAccountName']==null?"":json['suppAccountName'].toString();
    city = json['city']==null ?"" :json['city'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suppAccountNo'] = suppAccountNo;
    data['suppAccountName'] = suppAccountName;
    data['city'] = city;
    return data;
  }
}