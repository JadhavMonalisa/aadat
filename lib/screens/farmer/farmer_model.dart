class FarmerPattiModel {
  int? statusCode;
  List<FarmerPattiDetails>? farmerPattiDetails;

  FarmerPattiModel({this.statusCode, this.farmerPattiDetails});

  FarmerPattiModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      farmerPattiDetails = <FarmerPattiDetails>[];
      json['result'].forEach((v) {
        farmerPattiDetails!.add(FarmerPattiDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (farmerPattiDetails != null) {
      data['result'] = farmerPattiDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pattiNo'] = pattiNo;
    data['pattiDate'] = pattiDate;
    data['accountName'] = accountName;
    data['city'] = city;
    data['mEng_name'] = mEngName;
    data['qty'] = qty;
    data['weight'] = weight;
    data['rate'] = rate;
    data['amount'] = amount;
    data['hamali'] = hamali;
    data['mapai'] = mapai;
    data['bharai'] = bharai;
    data['leavy'] = leavy;
    data['mcess'] = mcess;
    data['mFee'] = mFee;
    data['varai'] = varai;
    data['comm'] = comm;
    data['other'] = other;
    data['actPatti'] = actPatti;
    data['amttoword'] = amttoword;
    data['motorRent'] = motorRent;
    data['engFirmName'] = engFirmName;
    return data;
  }
}