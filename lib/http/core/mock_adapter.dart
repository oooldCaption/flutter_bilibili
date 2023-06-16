import 'package:flutter_bilibili/http/core/net_adapter.dart';

import '../request/base_request.dart';
import 'dart:core';

class MockAdapter extends NetAdapter{

  @override
  Future<NetResponse<T>> send<T>(BaseRequest request) async {
    return Future<NetResponse<T>>.delayed(
        Duration(milliseconds: 1000),
            () {
      return NetResponse<T>(
        data: {"code": 0, "message": "success"},
        statusCode: 200,
      );
    });
  }

}