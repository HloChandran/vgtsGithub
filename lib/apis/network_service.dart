import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/AppConstants.dart';
import '../config/appStringConfig.dart';
import '../config/appUrlConfig.dart';
import '../config/commonUtils.dart';
import '../config/shared_preference.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

class NetworkService {
  static final SharedPreference _sharedPreference = SharedPreference();

  static postData(data, apiUrl, {bearerToken = false}) async {
    try {
      String? token = await _sharedPreference.get(AppConstants.bearerToken);
      var fullUrl = Uri.parse(AppUrl.baseUrl + apiUrl);
      print('url${fullUrl}');
      print('url${data}');
      final response = await http.post(fullUrl,
          body: data,
          headers: bearerToken
              ? _headersWithToken(token)
              : _headersWithoutToken(token));
      return _response(response);
    } on SocketException {
      throw AppStringConfig.noInternetConnection;
    } on HandshakeException {
      throw AppStringConfig.certificateVerifyFailed;
    } on TimeoutException {
      throw AppStringConfig.couldNotReachTheServer;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<dynamic> postJobCardCreate(
      Map<String, dynamic> data, apiUrl) async {
    String? token = await _sharedPreference.get(AppConstants.bearerToken);
    var fullUrl = Uri.parse(AppUrl.baseUrl + apiUrl);
    final response =
        await http.post(fullUrl, body: data, headers: _headersPut(token));
    return _response(response);
  }

  static getData(apiUrl, {bearerToken = false}) async {
    String? token = await _sharedPreference.get(AppConstants.bearerToken);
    var fullUrl = Uri.parse(AppUrl.baseUrl + apiUrl);
    print("Full url$fullUrl");

    final response = await http.get(fullUrl,
        headers: bearerToken
            ? _headersWithToken(token)
            : _headersWithoutToken(token));

    return _responseGetData(response);
  }

  static getData1(apiUrl, {bearerToken = false}) async {
    var fullUrl = Uri.parse(AppUrl.baseUrl + apiUrl);
    print("Full url$fullUrl");

    final response = await http.get(fullUrl, headers: headersCATELOG);
    return _responseGetData(response);
  }

  static putDataWithBody(data, apiUrl, {bearerToken = false}) async {
    String? token = await _sharedPreference.get(AppConstants.bearerToken);
    var fullUrl = Uri.parse(AppUrl.baseUrl + apiUrl);
    print("Full url$fullUrl");
    final response = await http.put(fullUrl,
        body: data,
        headers: bearerToken
            ? _headersWithToken(token)
            : _headersWithoutToken(token));

    return _response(response);
  }

  static dynamic _response(http.Response response) {
    return json.decode(response.body.toString());
  }

  static dynamic _responseGetData(http.Response response) {
    dynamic responseJson;
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body.toString());
    } else {
      responseJson = "Unauthorized";
    }
    return responseJson;
  }

  static void showLoader() {
    if (!EasyLoading.isShow) {
      EasyLoading.show();
    }
  }

  static void dismissLoader() {
    if (EasyLoading.isShow) {
      EasyLoading.dismiss();
    }
  }

  static _headersWithToken(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/vnd.github+json',
        'Authorization': 'Bearer ' + token
      };

  static _headersPut(token) => {'Authorization': 'Bearer ' + token};

  static Map<String, String> headersCATELOG = {
    "x-api-key": "API-KEY-PROCUREMENT"
  };

  static _headersWithoutToken(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}


