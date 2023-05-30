class CustomResponse {
  bool? status;
  String? message;

  CustomResponse({this.status, this.message});

  CustomResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}
class ApiResponse {
  bool? success;
  String? message;

  ApiResponse({this.success, this.message});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    success = json['Success']??"";
    message = json['Message']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    return data;
  }
}

// class LoginResponse {
//   int? statusCode;
//   String? result;
//
//   LoginResponse({this.statusCode,this.result });
//
//   LoginResponse.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     result = json['result'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['statusCode'] = statusCode;
//     data['result'] = result;
//     return data;
//   }
// }

class LoginResponse {
  int? statusCode;
  List<LoginResponseResult>? loginResponseResult;

  LoginResponse({this.statusCode, this.loginResponseResult});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['result'] != null) {
      loginResponseResult = <LoginResponseResult>[];
      json['result'].forEach((v) {
        loginResponseResult!.add(LoginResponseResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (loginResponseResult != null) {
      data['result'] = loginResponseResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoginResponseResult {
  int? clientID;
  String? token;
  String? message;

  LoginResponseResult({this.clientID, this.token, this.message});

  LoginResponseResult.fromJson(Map<String, dynamic> json) {
    clientID = json['clientID'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clientID'] = clientID;
    data['token'] = token;
    data['message'] = message;
    return data;
  }
}


