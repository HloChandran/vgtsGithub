import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';

import '../../../apis/network_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../config/appUrlConfig.dart';
import '../../../models/branchDetailsModel.dart';
import '../../../models/branchcommitDetailsModel.dart';

class ProjectViewProvider extends ChangeNotifier {
  List<BranchDetailsModel> branchDetailsModel=[];
  BranchcommitDetailsModel? branchcommitDetailsModel;

  Future getBranchDetails(projectOwnerName, projectName) async {
    try {
      print("objectsdcsdsd}");
      EasyLoading.show();

      BranchDetailsModel data = BranchDetailsModel.fromJson(
          await NetworkService.getData(
              '${AppUrl.branches}${projectOwnerName+'/'+projectName}/branches',
              bearerToken: true));
      branchDetailsModel.add(data);
      await getBranchFullDetails(branchDetailsModel[0].details[0].commit.sha.toString(),projectOwnerName,projectName);

      print("getAttendanceModel${data.details.length}");

      notifyListeners();
      EasyLoading.dismiss();

    } catch (e) {
      EasyLoading.dismiss();
      print("objectukuikuk}");
    }
  }

  Future getBranchFullDetails(String shaValue, projectOwnerName, projectName) async {
    try {
      print("objectsdcsdsd}");
      print(shaValue);
      EasyLoading.show();

      BranchcommitDetailsModel data = BranchcommitDetailsModel.fromJson(
          await NetworkService.getData(
              '${AppUrl.branches}${projectOwnerName+'/'+projectName}/commits/${shaValue}',
              bearerToken: true));


      print("getAttendancsdsdeModelasas");

      notifyListeners();
      EasyLoading.dismiss();

    } catch (e) {
      EasyLoading.dismiss();
      print("objectukuikuk}${e}");
    }
  }




}