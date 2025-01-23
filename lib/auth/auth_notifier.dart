import 'package:flutter/cupertino.dart';
import 'package:vgtsgithub/auth/github_authenticator.dart';
import '../../../config/shared_preference.dart';
import '../routes/appRoutes.dart';
import 'github_authenticator.dart';

typedef AuthUriCallback = Future<Uri> Function(Uri authorizationUrl);

class AuthNotifier {
  static GithubAuthenticator _authenticator = GithubAuthenticator();

  static Future<void> signIn(AuthUriCallback authorizationCallback,BuildContext context) async {

    final grant = _authenticator.authorizationCodeGrant;
    print("grant${grant}");
    final redirectUrl =
        await authorizationCallback(_authenticator.getAuthorizationUrl(grant));

    print("failureOrSuccess${redirectUrl}");
    final failureOrSuccess = await _authenticator.handleAuthorizationResponse(
      grant,
      redirectUrl.queryParameters,
    );
    if(failureOrSuccess!=""){
     Navigator.pushNamed(context, AppRoutes.dashbord);
    }else{  Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
    }
    print("failureOrSuccess");
    print("failureOrSuccess${failureOrSuccess}");


    grant.close();
  }


}
