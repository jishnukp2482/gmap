// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

FormResponse responseFromJson(String str) => FormResponse.fromJson(json.decode(str));

String responseToJson(FormResponse data) => json.encode(data.toJson());

class FormResponse {
  String status;
  String message;
  List<Datum> data;

  FormResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FormResponse.fromJson(Map<String, dynamic> json) => FormResponse(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String statusMessage;
  int id;
  String companyName;

  Datum({
    required this.statusMessage,
    required this.id,
    required this.companyName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        statusMessage: json["statusMessage"],
        id: json["id"],
        companyName: json["companyName"],
      );

  Map<String, dynamic> toJson() => {
        "statusMessage": statusMessage,
        "id": id,
        "companyName": companyName,
      };
}
