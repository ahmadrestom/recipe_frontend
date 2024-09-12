class BaseAPI {
  static String base = "http://10.0.2.2:8080";
  static var secureAPI = "$base/api/v2";
  static var publicAPI = "$base/api/v1";
  var authAPI = "$publicAPI/auth/authenticate";
  var registerAPI = "$publicAPI/auth/register";

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
}