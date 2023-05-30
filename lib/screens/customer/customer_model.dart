class CustomerListModel {
  int? statusCode;
  List<CustomerListDetails>? customerListDetails;

  CustomerListModel({this.statusCode, this.customerListDetails});

  CustomerListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      customerListDetails = <CustomerListDetails>[];
      json['result'].forEach((v) {
        customerListDetails!.add(CustomerListDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (customerListDetails != null) {
      data['result'] = customerListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerListDetails {
  int? custAccountNo;
  String? custAccountName;
  String? city;

  CustomerListDetails({this.custAccountNo, this.custAccountName, this.city});

  CustomerListDetails.fromJson(Map<String, dynamic> json) {
    custAccountNo = json['custAccountNo'];
    custAccountName = json['custAccountName'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['custAccountNo'] = custAccountNo;
    data['custAccountName'] = custAccountName;
    data['city'] = city;
    return data;
  }
}

class WeightListModel {
  int? statusCode;
  List<WeightListDetails>? weightListDetails;

  WeightListModel({this.statusCode, this.weightListDetails});

  WeightListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      weightListDetails = <WeightListDetails>[];
      json['result'].forEach((v) {
        weightListDetails!.add(WeightListDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (weightListDetails != null) {
      data['result'] = weightListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeightListDetails {
  String? billDate;
  String? custAccountName;
  String? remark;
  int? qty;
  int? weight;
  int? rate;
  String? suppAccountName;

  WeightListDetails(
      {this.billDate,
        this.custAccountName,
        this.remark,
        this.qty,
        this.weight,
        this.rate,
        this.suppAccountName});

  WeightListDetails.fromJson(Map<String, dynamic> json) {
    billDate = json['billDate'];
    custAccountName = json['custAccountName'];
    remark = json['remark'];
    qty = json['qty'];
    weight = json['weight'];
    rate = json['rate'];
    suppAccountName = json['suppAccountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billDate'] = billDate;
    data['custAccountName'] = custAccountName;
    data['remark'] = remark;
    data['qty'] = qty;
    data['weight'] = weight;
    data['rate'] = rate;
    data['suppAccountName'] = suppAccountName;
    return data;
  }
}

class MarkWiseWeightListModel {
  int? statusCode;
  List<MarkWiseWeightListDetails>? markWiseWeightListDetails;

  MarkWiseWeightListModel({this.statusCode, this.markWiseWeightListDetails});

  MarkWiseWeightListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      markWiseWeightListDetails = <MarkWiseWeightListDetails>[];
      json['result'].forEach((v) {
        markWiseWeightListDetails!.add(MarkWiseWeightListDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (markWiseWeightListDetails != null) {
      data['result'] = markWiseWeightListDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MarkWiseWeightListDetails {
  String? mark;
  int? qty;
  int? weight;
  int? amount;
  String? billDate;
  String? custAccountName;

  MarkWiseWeightListDetails(
      {this.mark,
        this.qty,
        this.weight,
        this.amount,
        this.billDate,
        this.custAccountName});

  MarkWiseWeightListDetails.fromJson(Map<String, dynamic> json) {
    mark = json['mark'];
    qty = json['qty'];
    weight = json['weight'];
    amount = json['amount'];
    billDate = json['billDate'];
    custAccountName = json['custAccountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mark'] = mark;
    data['qty'] = qty;
    data['weight'] = weight;
    data['amount'] = amount;
    data['billDate'] = billDate;
    data['custAccountName'] = custAccountName;
    return data;
  }
}

class LedgerShortReportModel {
  int? statusCode;
  List<LedgerShortReportDetails>? ledgerShortReportDetails;

  LedgerShortReportModel({this.statusCode, this.ledgerShortReportDetails});

  LedgerShortReportModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      ledgerShortReportDetails = <LedgerShortReportDetails>[];
      json['result'].forEach((v) {
        ledgerShortReportDetails!.add(LedgerShortReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (ledgerShortReportDetails != null) {
      data['result'] = ledgerShortReportDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LedgerShortReportDetails {
  int? amount;
  String? billDate;
  String? accountName;
  int? acctNo;

  LedgerShortReportDetails({this.amount, this.billDate, this.accountName, this.acctNo});

  LedgerShortReportDetails.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    billDate = json['billDate'];
    accountName = json['accountName'];
    acctNo = json['acctNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['billDate'] = billDate;
    data['accountName'] = accountName;
    data['acctNo'] = acctNo;
    return data;
  }
}

class LedgerSummaryReport {
  int? statusCode;
  List<LedgerSummaryReportDetails>? ledgerSummaryReportDetails;

  LedgerSummaryReport({this.statusCode, this.ledgerSummaryReportDetails});

  LedgerSummaryReport.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      ledgerSummaryReportDetails = <LedgerSummaryReportDetails>[];
      json['result'].forEach((v) {
        ledgerSummaryReportDetails!.add(LedgerSummaryReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (ledgerSummaryReportDetails != null) {
      data['result'] = ledgerSummaryReportDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LedgerSummaryReportDetails {
  int? acctNO;
  String? custAccountName;
  int? debitAmount;
  int? creditAmount;
  String? mobile;

  LedgerSummaryReportDetails(
      {this.acctNO,
        this.custAccountName,
        this.debitAmount,
        this.creditAmount,
        this.mobile});

  LedgerSummaryReportDetails.fromJson(Map<String, dynamic> json) {
    acctNO = json['acctNO'];
    custAccountName = json['custAccountName'];
    debitAmount = json['debitAmount'];
    creditAmount = json['creditAmount'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acctNO'] = acctNO;
    data['custAccountName'] = custAccountName;
    data['debitAmount'] = debitAmount;
    data['creditAmount'] = creditAmount;
    data['mobile'] = mobile;
    return data;
  }
}

class CustomerLedgerReportModel {
  int? statusCode;
  List<CustomerLedgerReportDetails>? customerLedgerReportDetails;

  CustomerLedgerReportModel({this.statusCode, this.customerLedgerReportDetails});

  CustomerLedgerReportModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      customerLedgerReportDetails = <CustomerLedgerReportDetails>[];
      json['result'].forEach((v) {
        customerLedgerReportDetails!.add(CustomerLedgerReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (customerLedgerReportDetails != null) {
      data['result'] = customerLedgerReportDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerLedgerReportDetails {
  int? srNo;
  String? recieptDate;
  String? recieptNarration;
  String? recieptAmount;
  String? paymentDate;
  String? paymentNarration;
  String? paymentAmonut;

  CustomerLedgerReportDetails(
      {this.srNo,
        this.recieptDate,
        this.recieptNarration,
        this.recieptAmount,
        this.paymentDate,
        this.paymentNarration,
        this.paymentAmonut});

  CustomerLedgerReportDetails.fromJson(Map<String, dynamic> json) {
    srNo = json['srNo'];
    recieptDate = json['recieptDate'];
    recieptNarration = json['recieptNarration'];
    recieptAmount = json['recieptAmount'];
    paymentDate = json['paymentDate'];
    paymentNarration = json['paymentNarration'];
    paymentAmonut = json['paymentAmonut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['srNo'] = srNo;
    data['recieptDate'] = recieptDate;
    data['recieptNarration'] = recieptNarration;
    data['recieptAmount'] = recieptAmount;
    data['paymentDate'] = paymentDate;
    data['paymentNarration'] = paymentNarration;
    data['paymentAmonut'] = paymentAmonut;
    return data;
  }
}