import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vgtsgithub/widgets/customText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../../auth/auth_notifier.dart';
import '../../../auth/authorization_page.dart';
import '../../../config/AppConstants.dart';
import '../../../config/assetsConfig.dart';

import '../../../config/shared_preference.dart';
import '../../../routes/appRoutes.dart';
import '../../../widgets/customButton.dart';
import '../provider/splashProvider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late var height, width;
  static final SharedPreference _sharedPreference = SharedPreference();

  @override
  void initState() {
    userInfo();
   // Provider.of<SplashProvider>(context, listen: false).userInfo();
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
    return Consumer<SplashProvider>(builder: (context, providerData, _) {
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
                    AssetsConfig.logo,
                    height: 100,
                  )),

            ],
          ),
        ),
      ));
    });
  }
  Future<void> userInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Object? token = await sharedPreferences.get(AppConstants.bearerToken);
    print('userRole$token');
    token == "" || token == null
        ? Navigator.pushReplacementNamed(context, AppRoutes.loginScreen)
        : Navigator.pushNamed(context, AppRoutes.dashbord);
    print('userRole$token');
  }
}
