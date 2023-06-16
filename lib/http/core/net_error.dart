const int loginErrCode = 401;
const int authErrCode = 403;

class NetError implements Exception {
  /// 定义错误状态码
  final int code;

  /// 定义错误信息
  final String message;

  /// 定义错误数据
  final dynamic data;
  NetError(this.code, this.message, {this.data});
}

/// 授权错误
class NeedLogin extends NetError {
  NeedLogin() : super(loginErrCode, "请先登录", data: "need login");
}

/// 授权错误
class NeedAuth extends NetError {
  NeedAuth(String message, {data}) : super(authErrCode, message, data: data);
}
