
import 'package:flutter_bilibili/debug/log_tool.dart';
import 'package:flutter_bilibili/http/core/dio_daapter.dart';
import 'package:flutter_bilibili/http/core/mock_adapter.dart';
import 'package:flutter_bilibili/http/core/net_adapter.dart';
import 'package:flutter_bilibili/http/core/net_error.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class NetTool {
  NetTool._();
  static NetTool _instance = NetTool._();
  static NetTool getInstance() {
    _instance ??= NetTool._();
    return _instance;
  }

  Future fire(BaseRequest request) async {

    NetResponse? response;
    var error;


    try {
      response = await send(request);
    } on NetError catch (e) {
      error = e;
      response = e.data;
    } catch(e) {
      error = e;
      response?.statusMessage =  "未知错误,${error}";

    }


    if(response == null){
      LogManager().logDebug("响应为空: $error ----$response");
    }

    var out = response?.data;


    var statusCode = response?.statusCode;


    switch(statusCode){
      case 200:
        return out;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(out.toString(),data: out);
      default:
        throw NetError(statusCode ?? -1, out.toString(), data: out);
    }

  }

  Future<dynamic> send<T>(BaseRequest request) async {
    MockAdapter mockAdapter = MockAdapter();
    NetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print("net_tool:${log.toString()}");
  }

  // static NetTool get instance => _instance ??= NetTool._();
}
