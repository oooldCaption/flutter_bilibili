import 'package:flutter_bilibili/http/request/base_request.dart';
import 'dart:convert';

abstract class NetAdapter {
  Future<NetResponse<T>> send<T>(BaseRequest request);
}


class NetResponse<T> {
  NetResponse({
    this.data,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;


  @override
  String toString() {
    if (data == null) {
      return "null";
    // } else if (data is Map) {
    //   return json.encode(data);
    } else {
      return data.toString();
    }
  }
}
