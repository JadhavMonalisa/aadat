class FirmModel {
  int? statusCode;
  List<FirmDetails>? firmDetails;

  FirmModel({this.statusCode, this.firmDetails});

  FirmModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      firmDetails = <FirmDetails>[];
      json['result'].forEach((v) {
        firmDetails!.add(FirmDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (firmDetails != null) {
      data['result'] = firmDetails!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firmId'] = firmId;
    data['engFirmName'] = engFirmName;
    data['address'] = address;
    return data;
  }
}