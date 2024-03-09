// To parse this JSON data, do
//
//     final responseApi = responseApiFromJson(jsonString);

import 'dart:convert';

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  String? message;
  String? error;
  bool? success;
  dynamic data;

  ResponseApi({
    required this.message,
    required this.error,
    required this.success,
  });

  ResponseApi.fromJson(Map<String?, dynamic> json) {
    message = json["message"];
    error = json["error"];
    success = json["success"];
    try {
      data = json['data'];
    } catch (e) {
      print('exception data $e');
    }
  }

  Map<String, dynamic> toJson() =>
      {"message": message, "error": error, "success": success, "data": data};
}
