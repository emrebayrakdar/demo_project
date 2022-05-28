import 'base_model.dart';

abstract class IResponseModel<T> {
  T? data;
  IErrorModel? error;
}

// abstract class IErrorModel<T> {
//   int? statusCode;
//   String? message;
//   BaseModel? model;
// }

abstract class IErrorModel<T> {
  int? statusCode;
  String? description;
  BaseModel? model;
  dynamic response;
}

class ErrorModel<T> implements IErrorModel {
  @override
  int? statusCode;

  @override
  String? description;

  ErrorModel({this.statusCode, this.description, this.model, this.response});

  @override
  BaseModel? model;

  // Generic Response from Service
  @override
  dynamic response;
}

class ResponseModel<T> extends IResponseModel<T> {
  @override
  T? data;
  @override
  IErrorModel? error;

  ResponseModel({this.data, this.error});
}
