class SupplierListModel {
  int? statusCode;
  List<SupplierListDetails>? supplierListDetails;

  SupplierListModel({this.statusCode, this.supplierListDetails});

  SupplierListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      supplierListDetails = <SupplierListDetails>[];
      json['result'].forEach((v) {
        supplierListDetails!.add(new SupplierListDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.supplierListDetails != null) {
      data['result'] = this.supplierListDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suppAccountNo'] = this.suppAccountNo;
    data['suppAccountName'] = this.suppAccountName;
    data['city'] = this.city;
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
        supplierLedgerReportDetails!.add(new SupplierLedgerReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.supplierLedgerReportDetails != null) {
      data['result'] = this.supplierLedgerReportDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierLedgerReportDetails {
  String? pattiDate;
  String? totQty;
  String? debitBalance;
  String? creditBalance;
  String? accountName;

  SupplierLedgerReportDetails(
      {this.pattiDate,
        this.totQty,
        this.debitBalance,
        this.creditBalance,
        this.accountName});

  SupplierLedgerReportDetails.fromJson(Map<String, dynamic> json) {
    pattiDate = json['pattiDate'].toString();
    totQty = json['totQty'].toString();
    debitBalance = json['debitBalance'].toString();
    creditBalance = json['creditBalance'].toString();
    accountName = json['accountName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pattiDate'] = this.pattiDate;
    data['totQty'] = this.totQty;
    data['debitBalance'] = this.debitBalance;
    data['creditBalance'] = this.creditBalance;
    data['accountName'] = this.accountName;
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
        supplierLedgerSummaryReportDetails!.add(new SupplierLedgerSummaryReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.supplierLedgerSummaryReportDetails != null) {
      data['result'] = this.supplierLedgerSummaryReportDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupplierLedgerSummaryReportDetails {
  int? acctNO;
  String? suppAccountName;
  int? debitAmount;
  int? creditAmount;
  String? mobile;

  SupplierLedgerSummaryReportDetails(
      {this.acctNO,
        this.suppAccountName,
        this.debitAmount,
        this.creditAmount,
        this.mobile});

  SupplierLedgerSummaryReportDetails.fromJson(Map<String, dynamic> json) {
    acctNO = json['acctNO'];
    suppAccountName = json['suppAccountName'];
    debitAmount = json['debitAmount'];
    creditAmount = json['creditAmount'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acctNO'] = this.acctNO;
    data['suppAccountName'] = this.suppAccountName;
    data['debitAmount'] = this.debitAmount;
    data['creditAmount'] = this.creditAmount;
    data['mobile'] = this.mobile;
    return data;
  }
}