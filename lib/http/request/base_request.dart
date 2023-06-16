enum HttpMethod { GET, POST, PUT, DELETE, PATCH }
/// 封装基础请求

abstract class BaseRequest {
  // String baseUrl = "https://api.devio.org/uapi";
  String authority() {
    return "api.devio.org";
  }

  var pathParams;

  var useHttps = true;

  HttpMethod httpMethod();

  String path();

  String url(){ 
    Uri uri;
    var pathStr = path();

    // 拼接path参数
    if(pathParams != null){
      if(path().endsWith("/")){
        pathStr = "${path()}$pathParams";
      }else{
        pathStr = "${path()}/$pathParams";
      }
    }
    // http or https
    if(useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    }else{
      uri = Uri.http(authority(), pathStr, params);
    }
    return uri.toString();
  }
  /// 是否需要登录
  bool needLogin();

  Map<String,String> params = Map();

  // 添加参数
  BaseRequest add(String k, Object v){
    params[k] = v.toString();
    return this;
  }
  Map<String, dynamic>header = Map();

  // 添加header
  BaseRequest addHeader(String k, Object v){
    header[k] = v.toString();
    return this;
  }




}