class FarmerPattiModel {
  int? statusCode;
  List<FarmerPattiDetails>? farmerPattiDetails;

  FarmerPattiModel({this.statusCode, this.farmerPattiDetails});

  FarmerPattiModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      farmerPattiDetails = <FarmerPattiDetails>[];
      json['result'].forEach((v) {
        farmerPattiDetails!.add(new FarmerPattiDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.farmerPattiDetails != null) {
      data['result'] = this.farmerPattiDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerPattiDetails {
  int? pattiNo;
  String? pattiDate;
  String? accountName;
  String? city;
  String? mEngName;
  int? qty;
  int? weight;
  int? rate;
  int? amount;
  double? hamali;
  double? mapai;
  int? bharai;
  int? leavy;
  int? mcess;
  double? mFee;
  int? varai;
  int? comm;
  int? other;
  int? actPatti;
  String? amttoword;
  int? motorRent;
  String? engFirmName;

  FarmerPattiDetails(
      {this.pattiNo,
        this.pattiDate,
        this.accountName,
        this.city,
        this.mEngName,
        this.qty,
        this.weight,
        this.rate,
        this.amount,
        this.hamali,
        this.mapai,
        this.bharai,
        this.leavy,
        this.mcess,
        this.mFee,
        this.varai,
        this.comm,
        this.other,
        this.actPatti,
        this.amttoword,
        this.motorRent,
        this.engFirmName});

  FarmerPattiDetails.fromJson(Map<String, dynamic> json) {
    pattiNo = json['pattiNo'];
    pattiDate = json['pattiDate'];
    accountName = json['accountName'];
    city = json['city'];
    mEngName = json['mEng_name'];
    qty = json['qty'];
    weight = json['weight'];
    rate = json['rate'];
    amount = json['amount'];
    hamali = json['hamali'];
    mapai = json['mapai'];
    bharai = json['bharai'];
    leavy = json['leavy'];
    mcess = json['mcess'];
    mFee = json['mFee'];
    varai = json['varai'];
    comm = json['comm'];
    other = json['other'];
    actPatti = json['actPatti'];
    amttoword = json['amttoword'];
    motorRent = json['motorRent'];
    engFirmName = json['engFirmName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pattiNo'] = this.pattiNo;
    data['pattiDate'] = this.pattiDate;
    data['accountName'] = this.accountName;
    data['city'] = this.city;
    data['mEng_name'] = this.mEngName;
    data['qty'] = this.qty;
    data['weight'] = this.weight;
    data['rate'] = this.rate;
    data['amount'] = this.amount;
    data['hamali'] = this.hamali;
    data['mapai'] = this.mapai;
    data['bharai'] = this.bharai;
    data['leavy'] = this.leavy;
    data['mcess'] = this.mcess;
    data['mFee'] = this.mFee;
    data['varai'] = this.varai;
    data['comm'] = this.comm;
    data['other'] = this.other;
    data['actPatti'] = this.actPatti;
    data['amttoword'] = this.amttoword;
    data['motorRent'] = this.motorRent;
    data['engFirmName'] = this.engFirmName;
    return data;
  }
}