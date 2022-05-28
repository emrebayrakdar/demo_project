import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:demo_project/base/enums/http_request_enum.dart';
import 'package:demo_project/base/model/base_model.dart';
import 'package:demo_project/base/model/response_model.dart';
import 'package:demo_project/base/network/network_extension.dart';
import 'package:dio/dio.dart';

class CoreDio {
  static CoreDio? _instance;
  static Dio? _client;

  static CoreDio getInstance(BaseOptions baseOptions) {
    _instance ??= CoreDio._internal(baseOptions);
    return _instance!;
  }

  CoreDio._internal(BaseOptions baseOptions) {
    if (_client == null) {
      _client = Dio(baseOptions);
      _client!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // print("▐▐▐▐  İstek Atılıyor..[${options.path}] ▐▐▐▐ ${Random().nextInt(99).toString()}");
        return handler.next(options); //continue
      }, onResponse: (response, handler) {
        print("▐▐▐▐  [Calling WS.. ${response.requestOptions.path}] ▐▐▐▐ ${Random().nextInt(99).toString()}");
        print("▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐ RESPONSE START ▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐");
        print(jsonEncode(response.data));
        print("▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐ RESPONSE END ▐▐▐▐▐▐▐▐▐▐▐▐▐▐▐");
        return handler.next(response); // continue
      }, onError: (DioError e, handler) {
        //  print("▐▐▐▐  [onError] ▐▐▐▐ ");
        // // print('ERROR[${e.response?.statusCode}] => PATH: ${e.request.path}');
        //  print("▐▐▐▐  [onError] ▐▐▐▐ ");
        return handler.next(e); //continue
      }));
    }
  }

  Dio get client => _client!;

  Future<IResponseModel<R>> send<R, T extends BaseModel>(String path,
      {required HttpTypes type,
      required T parseModel,
      String? bodyStr,
      Map<String, dynamic>? queryParameters,
      void Function(int, int)? onReceiveProgress,
      Map<String, dynamic>? headers}) async {
    try {
      final dynamic response;
      if (headers != null && headers.isNotEmpty) {
        response = await _client!.post(path, data: bodyStr, queryParameters: queryParameters, options: Options(method: type.rawValue, headers: headers));
      } else {
        response = await _client!.post(path, data: bodyStr, queryParameters: queryParameters, options: Options(method: type.rawValue));
      }

      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.accepted:
          final model = _parseBody<R, T>(parseModel, response.data);
          return ResponseModel<R>(data: model);
        default:
          return ResponseModel(error: ErrorModel(description: "Beklenmeyen bir sorun oluştu. Lütfen tekrar deneyiniz!"));
      }
    } on DioError catch (e) {
      final errorResponse = e.response;
      var errorModel = ErrorModel(description: e.message, statusCode: errorResponse != null ? errorResponse.statusCode : HttpStatus.internalServerError);
      errorModel.response = errorResponse!.data;
      if (errorModel.response != null && errorModel.response != "") errorModel.model = parseModel.fromJson(errorModel.response);
      return ResponseModel<R>(error: errorModel);
    } catch (error) {
      return ResponseModel(error: ErrorModel(description: error.toString()));
    }
  }

  R _parseBody<R, T>(BaseModel model, dynamic responseBody) {
    if (responseBody is List) {
      return responseBody.map((data) => model.fromJson(data)).cast<T>().toList() as R;
    } else if (responseBody is Map<String, dynamic>) {
      return model.fromJson(responseBody) as R;
    }
    return model as R;
  }

//#endregion
}
