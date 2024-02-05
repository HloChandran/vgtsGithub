import 'package:flutter/material.dart';

import '../../../config/AppColor.dart';
import '../../../config/AssetsConfig.dart';
import '../../../config/commonUtils.dart';
import '../../../widgets/customImageAsset.dart';
import '../../../widgets/customText.dart';
import 'package:provider/provider.dart';

import '../provider/projectviewProvider.dart';

class ProjectViewPage extends StatefulWidget {
  const ProjectViewPage({
    super.key,
  });

  @override
  State<ProjectViewPage> createState() => _ProjectViewPageState();
}

class _ProjectViewPageState extends State<ProjectViewPage> {
  late var height, width;

  int branchSelected = 0;
  var args;
  var projectOwnerName;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context)?.settings.arguments;
      });
      print(args['projectOwnerName'].toString().replaceFirst('login', ''));
      var str = args['projectOwnerName'].toString();
      var parts = str.split('.');
      var prefix = parts[0].trim(); // prefix: "date"
      projectOwnerName = parts.sublist(1).join(':').trim();
      Provider.of<ProjectViewProvider>(context, listen: false)
          .getBranchDetails(projectOwnerName, args['projectName']);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Consumer<ProjectViewProvider>(builder: (context, providerData, _) {
      return providerData.branchDetailsModel.isEmpty
          ? Container(
              child: Center(
                  child: CustomText(
                text: "NoData",
              )),
            )
          : Scaffold(
              body: Stack(
                children: [
                  Container(
                    height: height,
                    color: AppColor.white,
                  ),
                  Container(
                    color: AppColor.buttonColor,
                    height: height / 4,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.07),
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColor.white,
                            ),
                            onTap: () {
                              print('ssd');
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            width: width / 3.5,
                          ),
                          CustomText(
                            isBold: true,
                            text: 'Project',
                            textColor: AppColor.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.13, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(0.0)),
                                ),
                                child: CustomImageAsset(
                                  images: AssetsConfig.logo,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: args['projectName'].toString(),
                                  fontSize: 16,
                                  textColor: AppColor.white,
                                  isBold: true,
                                ),
                                CustomText(
                                  text: projectOwnerName.toString(),
                                  fontSize: 14,
                                  textColor: AppColor.white,
                                  isBold: false,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text:
                              'Last update : ${CommonUtils.dateFormatEMD(args['projectLastUpdatedDate'].toString()).toString() + " " + CommonUtils.dateFormatTime(args['projectLastUpdatedDate'].toString()).toString()}',
                          fontSize: 14,
                          textColor: AppColor.white,
                          isBold: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: height / 3.7, bottom: 10),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: 35,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: providerData
                                  .branchDetailsModel[0].details.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    branchSelected = index;
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                        height: 32,
                                        width: 89,
                                        decoration: BoxDecoration(
                                            color: index == branchSelected
                                                ? AppColor.black
                                                : AppColor.branchColor,
                                            borderRadius:
                                                BorderRadius.circular(42)),
                                        child: Center(
                                            child: CustomText(
                                          text: providerData
                                              .branchDetailsModel[0]
                                              .details[index]
                                              .name,
                                          fontSize: 11,
                                          textColor: index == branchSelected
                                              ? AppColor.white
                                              : AppColor.black,
                                          isTextAlign: TextAlign.center,
                                        ))),
                                  ),
                                );
                              }),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 16, right: 16, top: height / 3.2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: 15,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        height: 80,
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                height: 40,
                                                width: 40,
                                                decoration: const BoxDecoration(
                                                  color: AppColor.frame,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.0),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10.0),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  0.0)),
                                                ),
                                                child: CustomImageAsset(
                                                  height: 10,
                                                  width: 10,
                                                  images: AssetsConfig.folder,
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: 'Login flow',
                                                  fontSize: 13,
                                                  isBold: true,
                                                ),
                                                CustomText(
                                                  text: '17/05/23 09:30AM',
                                                  fontSize: 12,
                                                  textColor: AppColor.black,
                                                  isBold: false,
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .account_circle_outlined,
                                                      color: AppColor.green,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    CustomText(
                                                      text: 'Pravin kumar',
                                                      fontSize: 11,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                      )
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ))
                ],
              ),
            );
    });
  }
}
