import 'package:flutter/material.dart';
import 'package:vgtsgithub/routes/appRoutes.dart';
import 'package:vgtsgithub/widgets/customText.dart';

import '../config/AppColor.dart';
import '../config/AppConstants.dart';
import '../config/AssetsConfig.dart';
import '../config/shared_preference.dart';
import '../screen/splashScreen/screen/SplashScreen.dart';
import 'customAlertDialog.dart';
import 'customImageAsset.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late var height, width;
  int postion = 0;
  final SharedPreference _sharedPreference = SharedPreference();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Container(
      width: 310,
      color: AppColor.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 35),
        child: Column(
          children: [
            Container(
              height: 93,
              decoration: BoxDecoration(
                color: AppColor.grey1,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColor.grey,
                            width: 1,
                          ),
                        ),
                        child: const CustomImageAsset(
                          images: AssetsConfig.profile,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        const CustomText(
                          text: 'Santhosh kumar',
                          fontSize: 12,
                          isBold: true,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColor.secondary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(2),
                            child: CustomText(
                              text: 'SanthoshVGTS',
                              textColor: AppColor.white,
                              fontSize: 10,
                              isBold: true,
                              isTextAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 380,
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        postion = index;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          color: index == postion
                              ? AppColor.menuColor
                              : AppColor.white,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColor.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: index == postion
                                            ? AppColor.white
                                            : AppColor.grey,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: CustomImageAsset(
                                      images: AssetsConfig.logo,
                                    )),
                              ),
                              CustomText(
                                text: 'VGTS',
                                fontSize: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (ctx) => StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return CustomAlertDialog(
                            title: 'Logout',
                            msg: 'Are you sure,do you want to logout?',
                            onPressCancel: () {
                              Navigator.of(context).pop();
                            },
                            onPressOk: () {
                              _sharedPreference.remove(AppConstants.bearerToken);
                              Navigator.of(context).pop();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (BuildContext context) => SplashScreen()),
                                  ModalRoute.withName('/') // Replace this with your root screen's route name (usually '/')
                              );

                            },
                          );
                        }));
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColor.grey,
                            width: 1,
                          ),
                        ),
                        child: Icon(Icons.login)),
                  ),
                  CustomText(
                    text: 'Logout',
                    fontSize: 16,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
