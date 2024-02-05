import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart';

import '../config/AppConstants.dart';
import '../config/shared_preference.dart';
typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUrl);


class GithubAuthenticator {

/*  final Dio _dio;*/

  GithubAuthenticator();
  final SharedPreference sharedPreference = SharedPreference();
  static const scopes = ['read:user', 'repo'];
  static final authorizationEndpoint =
  Uri.parse('https://github.com/login/oauth/authorize');
  static final tokenEndpoint =
  Uri.parse('https://github.com/login/oauth/access_token');
  static final redirectUrl = Uri.parse('http://localhost:3000/callback');
  static final revocationEndpoint = Uri.parse(
      'https://api.github.com/applications/${"Iv1.6c1e60d3e8518179"}/token');

  /*Future<Credentials?> getSignedInCredentials() async {
    try {
      final storedCredentials = await _credentialsStorage.read();
      if (storedCredentials != null) {
        if (storedCredentials.canRefresh && storedCredentials.isExpired) {
          final failureOrCredentials = await refresh(storedCredentials);
          return failureOrCredentials.fold(
                  (l) => null, (credentials) => credentials);
        }
      }
      return storedCredentials;
    } catch(e){
      return null;
    }
  }*/

  /*Future<bool> isSignedIn() =>
      getSignedInCredentials().then((credentials) => credentials != null);*/

  AuthorizationCodeGrant get authorizationCodeGrant => AuthorizationCodeGrant(
    "Iv1.6c1e60d3e8518179",
    authorizationEndpoint,
    tokenEndpoint,
    httpClient: GithubOAuthHttpClient(),
    secret: "86f4deb0aa29d539a0ae80d38c93b02aa55c5e46",
  );

  Uri getAuthorizationUrl(AuthorizationCodeGrant grant) =>
      grant.getAuthorizationUrl(
        redirectUrl,
        scopes: scopes,
      );

  Future handleAuthorizationResponse(
      AuthorizationCodeGrant grant,
      Map<String, String> queryParams,
      ) async {
    try {
      final httpClient = await grant.handleAuthorizationResponse(queryParams);
      // _credentialsStorage.save(httpClient.credentials);
      print('Access Token: ${httpClient.credentials.accessToken}');
      sharedPreference.save(AppConstants.bearerToken, httpClient.credentials.accessToken);
      return httpClient.credentials;
    } on FormatException {
      return print("const AuthFailure.server()");
    } on AuthorizationException catch (e) {
      return print("AuthFailure.server('${e.error}: ${e.description}");
    }
  }


  Future refresh(
      Credentials credentials,
      ) async {
    try {
      final refreshedCredentials = await credentials.refresh(
        identifier: "Iv1.6c1e60d3e8518179",
        secret:"86f4deb0aa29d539a0ae80d38c93b02aa55c5e46",
        httpClient: GithubOAuthHttpClient(),
      );
      // await _credentialsStorage.save(refreshedCredentials);
      return refreshedCredentials;
    } on FormatException {
      return print("const AuthFailure.server()");
    } on AuthorizationException catch (e) {
      return print("AuthFailure.server");
    }
  }
}


class GithubOAuthHttpClient extends http.BaseClient {
  final httpClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Accept'] = 'application/json';
    return httpClient.send(request);
  }
}




abstract class CredentialsStorage {
  Future<Credentials?> read();

  Future<void> save(Credentials credentials);

  Future<void> clear();
}
