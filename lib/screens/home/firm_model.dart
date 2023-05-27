class FirmModel {
  int? statusCode;
  List<FirmDetails>? firmDetails;

  FirmModel({this.statusCode, this.firmDetails});

  FirmModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      firmDetails = <FirmDetails>[];
      json['result'].forEach((v) {
        firmDetails!.add(new FirmDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.firmDetails != null) {
      data['result'] = this.firmDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FirmDetails {
  int? firmId;
  String? engFirmName;
  String? address;

  FirmDetails({this.firmId, this.engFirmName, this.address});

  FirmDetails.fromJson(Map<String, dynamic> json) {
    firmId = json['firmId'];
    engFirmName = json['engFirmName'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firmId'] = this.firmId;
    data['engFirmName'] = this.engFirmName;
    data['address'] = this.address;
    return data;
  }
}