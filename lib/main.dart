import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vgtsgithub/routes/appRoutes.dart';
import 'package:vgtsgithub/screen/dashboard/provider/dashboardProvider.dart';
import 'package:vgtsgithub/screen/dashboard/screen/Dashboard.dart';
import 'package:vgtsgithub/screen/login/screen/LoginScreen.dart';
import 'package:vgtsgithub/screen/projectviewpage/provider/projectviewProvider.dart';
import 'package:vgtsgithub/screen/projectviewpage/screen/Projectviewpage.dart';
import 'package:vgtsgithub/screen/splashScreen/provider/splashProvider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vgtsgithub/screen/splashScreen/screen/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vgtsgithub/widgets/customText.dart';

import 'config/AppColor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black, // status bar color
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DashboardProvider()),
    ChangeNotifierProvider(create: (context) => SplashProvider()),
    ChangeNotifierProvider(create: (context) => ProjectViewProvider()),
  ], child: const MyApp()));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        AppRoutes.splashScreen: (context) => const SplashScreen(),
        AppRoutes.dashbord: (context) => const Dashboard(),
        AppRoutes.projectViewPage: (context) => const ProjectViewPage(),
        AppRoutes.loginScreen: (context) => const LoginScreen(),
      },
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorWidget = SizedBox(
      width: 180,
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              color: AppColor.blue,
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          CustomText(
            text: 'Please Wait',
            fontSize: 12,
            isBold: true,
          )
        ],
      ),
    )
    ..maskType = EasyLoadingMaskType.black
    ..boxShadow = List<BoxShadow>.empty(growable: false)
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
