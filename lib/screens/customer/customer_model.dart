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

class CustomerListByDateModel {
  int? statusCode;
  List<CustomerListByDateData>? customerListByDateData;

  CustomerListByDateModel({this.statusCode, this.customerListByDateData});

  CustomerListByDateModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      customerListByDateData = <CustomerListByDateData>[];
      json['result'].forEach((v) {
        customerListByDateData!.add(CustomerListByDateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (customerListByDateData != null) {
      data['result'] = customerListByDateData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerListByDateData {
  String? mark;
  String? qty;
  String? weight;
  String? amount;
  String? billDate;
  String? custAccountName;
  String? custAccountNo;

  CustomerListByDateData(
      {this.mark,
        this.qty,
        this.weight,
        this.amount,
        this.billDate,
        this.custAccountName,
        this.custAccountNo});

  CustomerListByDateData.fromJson(Map<String, dynamic> json) {
    mark = json['mark'].toString();
    qty = json['qty'].toString();
    weight = json['weight'].toString();
    amount = json['amount'].toString();
    billDate = json['billDate'].toString();
    custAccountName = json['custAccountName'].toString();
    custAccountNo = json['custAccountNo'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mark'] = mark;
    data['qty'] = qty;
    data['weight'] = weight;
    data['amount'] = amount;
    data['billDate'] = billDate;
    data['custAccountName'] = custAccountName;
    data['custAccountNo'] = custAccountNo;
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
  String? qty;
  String? weight;
  String? rate;
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
    billDate = json['billDate'].toString();
    custAccountName = json['custAccountName'].toString();
    remark = json['remark'].toString();
    qty = json['qty'].toString();
    weight = json['weight'].toString();
    rate = json['rate'].toString();
    suppAccountName = json['suppAccountName'].toString();
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

class MarkWiseWeightList {
  int? statusCode;
  List<MarkWiseWeightListDetails>? markWiseWeightListDetails;

  MarkWiseWeightList({this.statusCode, this.markWiseWeightListDetails});

  MarkWiseWeightList.fromJson(Map<String, dynamic> json) {
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
  String? qty;
  String? weight;
  String? amount;
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
    mark = json['mark'].toString();
    qty = json['qty'].toString();
    weight = json['weight'].toString();
    amount = json['amount'].toString();
    billDate = json['billDate'].toString();
    custAccountName = json['custAccountName'].toString();
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
//
// class LedgerShortReportModel {
//   int? statusCode;
//   List<LedgerShortReportDetails>? ledgerShortReportDetails;
//
//   LedgerShortReportModel({this.statusCode, this.ledgerShortReportDetails});
//
//   LedgerShortReportModel.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     if (json['result'] != null) {
//       ledgerShortReportDetails = <LedgerShortReportDetails>[];
//       json['result'].forEach((v) {
//         ledgerShortReportDetails!.add(LedgerShortReportDetails.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['statusCode'] = statusCode;
//     if (ledgerShortReportDetails != null) {
//       data['result'] = ledgerShortReportDetails!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class LedgerShortReportDetails {
//   String? amount;
//   String? billDate;
//   String? accountName;
//   String? acctNo;
//
//   LedgerShortReportDetails({this.amount, this.billDate, this.accountName, this.acctNo});
//
//   LedgerShortReportDetails.fromJson(Map<String, dynamic> json) {
//     amount = json['amount'].toString();
//     billDate = json['billDate'].toString();
//     accountName = json['accountName'].toString();
//     acctNo = json['acctNo'].toString();
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['amount'] = amount;
//     data['billDate'] = billDate;
//     data['accountName'] = accountName;
//     data['acctNo'] = acctNo;
//     return data;
//   }
// }

class LedgerShortReportModel {
  int? statusCode;
  List<LedgerShortReportDetails>? result;

  LedgerShortReportModel({this.statusCode, this.result});

  LedgerShortReportModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      result = <LedgerShortReportDetails>[];
      json['result'].forEach((v) {
        result!.add(LedgerShortReportDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LedgerShortReportDetails {
  String? acctNo;
  int? total;
  List<ShortReportList>? shortReportList;

  LedgerShortReportDetails({this.acctNo, this.total, this.shortReportList});

  LedgerShortReportDetails.fromJson(Map<String, dynamic> json) {
    acctNo = json['acctNo'];
    if (json['shortReportList'] != null) {
      shortReportList = <ShortReportList>[];
      json['shortReportList'].forEach((v) {
        shortReportList!.add(ShortReportList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acctNo'] = acctNo;
    if (shortReportList != null) {
      data['shortReportList'] =
          shortReportList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShortReportList {
  String? amount;
  String? billDate;
  String? accountName;
  String? acctNo;

  ShortReportList({this.amount, this.billDate, this.accountName, this.acctNo});

  ShortReportList.fromJson(Map<String, dynamic> json) {
    amount = json['amount'].toString();
    billDate = json['billDate'].toString();
    accountName = json['accountName'].toString();
    acctNo = json['acctNo'].toString();
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
    final Map<String, dynamic> data = <String, dynamic>{};
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

class BillReportModel {
  int? statusCode;
  List<BillReportListData>? billReportListData;

  BillReportModel({this.statusCode, this.billReportListData});

  BillReportModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      billReportListData = <BillReportListData>[];
      json['result'].forEach((v) {
        billReportListData!.add(BillReportListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (billReportListData != null) {
      data['result'] = billReportListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BillReportListData {
  String? engFirmName;
  String? firmAddress;
  String? mobileNo;
  String? billNo;
  String? billDate;
  String? custAccountName;
  String? city;
  String? prodName;
  String? lotNo;
  String? qty;
  String? weight;
  String? rate;
  String? amount;
  String? totQty;
  String? totWeight;
  String? totAmount;
  String? adat;
  String? mcess;
  String? custHamali;
  String? netAmount;

  BillReportListData(
      {this.engFirmName,
        this.firmAddress,
        this.mobileNo,
        this.billNo,
        this.billDate,
        this.custAccountName,
        this.city,
        this.prodName,
        this.lotNo,
        this.qty,
        this.weight,
        this.rate,
        this.amount,
        this.totQty,
        this.totWeight,
        this.totAmount,
        this.adat,
        this.mcess,
        this.custHamali,
        this.netAmount});

  BillReportListData.fromJson(Map<String, dynamic> json) {
    engFirmName = json['engFirmName'].toString();
    firmAddress = json['firmAddress'].toString();
    mobileNo = json['mobileNo'].toString();
    billNo = json['billNo'].toString();
    billDate = json['billDate'].toString();
    custAccountName = json['custAccountName'].toString();
    city = json['city'].toString();
    prodName = json['prod_name'].toString();
    lotNo = json['lotNo'].toString();
    qty = json['qty'].toString();
    weight = json['weight'].toString();
    rate = json['rate'].toString();
    amount = json['amount'].toString();
    totQty = json['totQty'].toString();
    totWeight = json['totWeight'].toString();
    totAmount = json['totAmount'].toString();
    adat = json['adat'].toString();
    mcess = json['mcess'].toString();
    custHamali = json['custHamali'].toString();
    netAmount = json['netAmount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['engFirmName'] = engFirmName;
    data['firmAddress'] = firmAddress;
    data['mobileNo'] = mobileNo;
    data['billNo'] = billNo;
    data['billDate'] = billDate;
    data['custAccountName'] = custAccountName;
    data['city'] = city;
    data['prod_name'] = prodName;
    data['lotNo'] = lotNo;
    data['qty'] = qty;
    data['weight'] = weight;
    data['rate'] = rate;
    data['amount'] = amount;
    data['totQty'] = totQty;
    data['totWeight'] = totWeight;
    data['totAmount'] = totAmount;
    data['adat'] = adat;
    data['mcess'] = mcess;
    data['custHamali'] = custHamali;
    data['netAmount'] = netAmount;
    return data;
  }
}