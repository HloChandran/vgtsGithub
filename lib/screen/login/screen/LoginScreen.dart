import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vgtsgithub/widgets/customText.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/auth_notifier.dart';
import '../../../auth/authorization_page.dart';
import '../../../config/AppConstants.dart';
import '../../../config/assetsConfig.dart';

import '../../../config/shared_preference.dart';
import '../../../routes/appRoutes.dart';
import '../../../widgets/customButton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late var height, width;
  static final SharedPreference _sharedPreference = SharedPreference();

  @override
  void initState() {

    super.initState();
  }

  getData() async {
    String? token = await _sharedPreference.get(AppConstants.bearerToken);
    print("token");
    print("token${token}");
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(58.0),
                  child: Image.asset(
                    AssetsConfig.githubLog,
                    height: 100,
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Image.asset(
                    AssetsConfig.splashImage,
                    height: 100,
                  )),
              const SizedBox(
                height: 15,
              ),
              const CustomText(
                isBold: true,
                fontSize: 20,
                text: 'Lets built from here ...',
              ),
              const SizedBox(
                height: 5,
              ),
              const CustomText(
                isBold: false,
                fontSize: 16,
                isTextAlign: TextAlign.center,
                text:
                    'Our platform drives innovation with tools that boost developer velocity',
              ),
              SizedBox(
                height: height / 5.4,
              ),
              InkWell(
                onTap: () {
                  print("objecasast");
                  // Test().signIn;

                  AuthNotifier.signIn((authorizationUrl) {
                    final completer = Completer<Uri>();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AuthorizationPage(
                              authorizationUrl: authorizationUrl,
                              onAuthorizationCodeRedirectAttempt:
                                  (redirectedUrl) =>
                                      completer.complete(redirectedUrl))),
                    );
                    return completer.future;
                  },context);
                },
                child: CustomButton(
                  text: 'Sign in with Github',
                  width: width - 50.0,
                ),
              ),
            ],
          ),
        ),
      ));
  }

}
