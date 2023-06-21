import 'package:dio/dio.dart';
import 'package:flutter_bilibili/debug/log_tool.dart';
import 'package:flutter_bilibili/http/core/net_adapter.dart';
import 'package:flutter_bilibili/http/core/net_error.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class DioAdapter extends NetAdapter {
  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    var response, option = Options(headers: request.header);

    var error;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: option);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: option);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: option);
      } else if (request.httpMethod() == HttpMethod.PUT) {
        response = await Dio()
            .put(request.url(), data: request.params, options: option);
      } else {
        response = await Dio().get(request.url(), options: option);
      }
    } on DioException catch (e) {
      error = e;
      response = e.response;
    }

    LogManager().logError(response);
    if (error != null) {
      throw NetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  /// 构建返回结果
  Future<NetResponse<T>> buildRes<T>(
      Response response, BaseRequest request) async {
    return Future.value(NetResponse(
        data: response.data,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response));
  }
}
