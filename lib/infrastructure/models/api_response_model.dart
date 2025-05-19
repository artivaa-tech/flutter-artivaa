class ApiResponseModel<T extends Serializable> {
  int? status;
  String? message;
  T? data;

  ApiResponseModel({this.status, this.message, this.data});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return ApiResponseModel<T>(
      status: json["status"],
      message: json["message"],
      data: json["data"] != null && json["data"].isNotEmpty?create(json['data']):null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}


abstract class Serializable {
  Map<String, dynamic> toJson();
}