class FarmerPattiDetailsModel {
  int? statusCode;
  List<FarmerPattiDetailsList>? farmerPattiDetailsList;

  FarmerPattiDetailsModel({this.statusCode, this.farmerPattiDetailsList});

  FarmerPattiDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      farmerPattiDetailsList = <FarmerPattiDetailsList>[];
      json['result'].forEach((v) {
        farmerPattiDetailsList!.add(FarmerPattiDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (farmerPattiDetailsList != null) {
      data['result'] = farmerPattiDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerPattiDetailsList {
  String? pattiNo;
  String? pattiDate;
  String? accountName;
  String? city;
  String? mEngName;
  String? qty;
  String? weight;
  String? rate;
  String? amount;
  String? hamali;
  String? mapai;
  String? bharai;
  String? leavy;
  String? mcess;
  String? mFee;
  String? varai;
  String? comm;
  String? other;
  String? actPatti;
  String? amttoword;
  String? motorRent;
  String? engFirmName;

  FarmerPattiDetailsList(
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

  FarmerPattiDetailsList.fromJson(Map<String, dynamic> json) {
    pattiNo = json['pattiNo'].toString();
    pattiDate = json['pattiDate'].toString();
    accountName = json['accountName'].toString();
    city = json['city'].toString();
    mEngName = json['mEng_name'].toString();
    qty = json['qty'].toString();
    weight = json['weight'].toString();
    rate = json['rate'].toString();
    amount = json['amount'].toString();
    hamali = json['hamali'].toString();
    mapai = json['mapai'].toString();
    bharai = json['bharai'].toString();
    leavy = json['leavy'].toString();
    mcess = json['mcess'].toString();
    mFee = json['mFee'].toString();
    varai = json['varai'].toString();
    comm = json['comm'].toString();
    other = json['other'].toString();
    actPatti = json['actPatti'].toString();
    amttoword = json['amttoword'].toString();
    motorRent = json['motorRent'].toString();
    engFirmName = json['engFirmName'].toString();
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