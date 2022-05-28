import 'package:demo_project/base/model/base_model.dart';

class RegisterResponseModel extends BaseModel<RegisterResponseModel> {
  RegisterResponseModel({
    this.result,
    this.returnObject,
    this.totalCount,
  });

  Result? result;
  ReturnObject? returnObject;
  int? totalCount;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) => RegisterResponseModel(
        result: json["Result"] == null ? null : Result.fromJson(json["Result"]),
        returnObject: json["ReturnObject"] == null ? null : ReturnObject.fromJson(json["ReturnObject"]),
        totalCount: json["TotalCount"],
      );

  Map<String, dynamic> toJson() => {
        "Result": result == null ? null : result!.toJson(),
        "ReturnObject": returnObject == null ? null : returnObject!.toJson(),
        "TotalCount": totalCount,
      };

  @override
  RegisterResponseModel fromJson(Map<String, dynamic> json) => RegisterResponseModel.fromJson(json);
}

class Result  extends BaseModel<Result>{
  Result({
    this.resultCode,
    this.resultMessage,
  });

  int? resultCode;
  String? resultMessage;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        resultCode: json["ResultCode"],
        resultMessage: json["ResultMessage"],
      );

  Map<String, dynamic> toJson() => {
        "ResultCode": resultCode,
        "ResultMessage": resultMessage,
      };

  @override
  Result fromJson(Map<String, dynamic> json) => Result.fromJson(json);
}

class ReturnObject {
  ReturnObject({
    this.token,
    this.expiresDate,
  });

  String? token;
  String? expiresDate;

  factory ReturnObject.fromJson(Map<String, dynamic> json) => ReturnObject(
        token: json["Token"],
        expiresDate: json["ExpiresDate"],
      );

  Map<String, dynamic> toJson() => {
        "Token": token,
        "ExpiresDate": expiresDate,
      };
}
