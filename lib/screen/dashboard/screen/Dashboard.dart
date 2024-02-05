import 'package:flutter/material.dart';
import 'package:vgtsgithub/config/AppColor.dart';
import 'package:vgtsgithub/widgets/customText.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../config/AssetsConfig.dart';
import '../../../config/commonUtils.dart';
import '../../../routes/appRoutes.dart';
import '../../../widgets/customDrawer.dart';
import '../../../widgets/customImageAsset.dart';

import 'package:provider/provider.dart';

import '../provider/dashboardProvider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> drawerScaffoldkey = GlobalKey<ScaffoldState>();
  late var height, width;

  @override
  void initState() {
    Provider.of<DashboardProvider>(context, listen: false).getUserDetails();
    Provider.of<DashboardProvider>(context, listen: false).getRepository();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Consumer<DashboardProvider>(builder: (context, providerData, _) {
      return providerData.repositoryModelDetails.isEmpty
          ? Container(
             child: Center(child: CustomText(text: "NoData",)),
            )
          : Scaffold(
              key: drawerScaffoldkey,
              drawer: const CustomDrawer(),
              body: Stack(
                children: [
                  Container(
                    height: height,
                    color: AppColor.white,
                  ),
                  Container(
                    color: AppColor.buttonColor,
                    height: height / 4.5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.06),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    child: Icon(
                                      Icons.menu,
                                      color: AppColor.white,
                                    ),
                                    onTap: () {
                                      print('Github');
                                      drawerScaffoldkey.currentState!
                                          .openDrawer();
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                    isBold: true,
                                    text: 'Github',
                                    textColor: AppColor.white,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.notification_add_outlined,
                                    color: AppColor.white,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomText(
                            isBold: true,
                            fontSize: 13,
                            text: '${providerData.name}',
                            textColor: AppColor.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.15, left: 16, right: 16),
                    child: Container(
                      height: 108,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColor.grey,
                                    width: 1,
                                  ),
                                ),
                                child: CustomImageAsset(
                                  images: AssetsConfig.logo,
                                )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Heavenly',
                                fontSize: 12,
                                isBold: true,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppColor.lightBlue,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: CustomText(
                                    text: 'VGTS',
                                    textColor: AppColor.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: height / 3.8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CustomText(
                              fontSize: 14, isBold: true, text: 'Projects'),
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: providerData.repositoryModelDetails[0]
                                            .details ==
                                        "null" ||
                                    providerData.repositoryModelDetails[0]
                                        .details.isEmpty
                                ? Container(
                                    color: Colors.blue,
                                  )
                                : ListView.builder(
                                    itemCount: providerData
                                        .repositoryModelDetails[0]
                                        .details
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                          onTap: () {
                                            Map<String, dynamic> parameter = {
                                              "projectName": providerData
                                                  .repositoryModelDetails[0]
                                                  .details[index]
                                                  .name,
                                              "projectOwnerName": providerData
                                                  .repositoryModelDetails[0]
                                                  .details[index]
                                                  .owner
                                                  .login,
                                              "projectLastUpdatedDate":
                                                  providerData
                                                      .repositoryModelDetails[0]
                                                      .details[index]
                                                      .pushedAt
                                                      .toString(),
                                            };

                                            Navigator.pushNamed(context,
                                                AppRoutes.projectViewPage,
                                                arguments: parameter);
                                          },
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 00),
                                            child: Container(
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: AppColor.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade100,
                                                    spreadRadius: 5,
                                                    blurRadius: 5,
                                                    offset: const Offset(1, 4),
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border:
                                                                  Border.all(
                                                                color: AppColor
                                                                    .grey,
                                                                width: 1,
                                                              ),
                                                            ),
                                                            /* child:CachedNetworkImage(
                                                     imageUrl:   providerData.repositoryModelDetails!.details[index].owner.avatarUrl,
                                                     progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                         SizedBox(
                                                             height: 10,
                                                             width: 10,
                                                             child: CircularProgressIndicator(value: downloadProgress.progress)),
                                                     errorWidget: (context, url, error) => Icon(Icons.error),
                                                   ),*/
                                                            // ),
                                                            child:
                                                                CustomImageAsset(
                                                              height: 10,
                                                              width: 10,
                                                              images:
                                                                  AssetsConfig
                                                                      .logo,
                                                            )),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CustomText(
                                                              text: providerData
                                                                  .repositoryModelDetails[
                                                                      0]
                                                                  .details[
                                                                      index]
                                                                  .name,
                                                              fontSize: 13,
                                                              isBold: true,
                                                            ),
                                                            CustomText(
                                                              text:
                                                              "${CommonUtils.dateFormatEMD(providerData
                                                                  .repositoryModelDetails[
                                                              0]
                                                                  .details[
                                                              index]
                                                                  .pushedAt
                                                                  .toString())} ${CommonUtils.dateFormatTime(providerData
                                                                  .repositoryModelDetails[
                                                              0]
                                                                  .details[
                                                              index]
                                                                  .pushedAt
                                                                  .toString())}",
                                                              fontSize: 11,
                                                              textColor:
                                                                  AppColor
                                                                      .black,
                                                              isBold: false,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Icon(Icons
                                                        .arrow_forward_ios_rounded)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ));
                                    }),
                          ),
                        ],
                      )),
                ],
              ),
            );
    });
  }
}
