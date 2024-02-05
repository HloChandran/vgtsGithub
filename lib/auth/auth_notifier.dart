import 'package:flutter/cupertino.dart';
import 'package:vgtsgithub/auth/github_authenticator.dart';

import 'github_authenticator.dart';

typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUrl);

class AuthNotifier {
  static GithubAuthenticator _authenticator = GithubAuthenticator();

  static Future<void> signIn(AuthUriCallback authorizationCallback) async {
    final grant = _authenticator.authorizationCodeGrant;
    print("grant${grant}");
    final redirectUrl =
        await authorizationCallback(_authenticator.getAuthorizationUrl(grant));

    print("failureOrSuccess${redirectUrl}");
    final failureOrSuccess = await _authenticator.handleAuthorizationResponse(
      grant,
      redirectUrl.queryParameters,
    );
    print("failureOrSuccess");
    print("failureOrSuccess${failureOrSuccess}");
    grant.close();
  }
}
