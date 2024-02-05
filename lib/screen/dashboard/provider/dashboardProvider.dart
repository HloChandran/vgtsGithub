import 'package:flutter/material.dart';

import '../../../apis/network_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../config/appUrlConfig.dart';
import '../../../models/repositoryModel.dart';
import '../../../models/userDetailsModel.dart';
class DashboardProvider extends ChangeNotifier {

  String  name="";
  List<RepositoryListModel> repositoryModelDetails=[];

  Future getUserDetails() async {
    try {
      print("objectsdcsdsd}");
      EasyLoading.show();

      UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(
          await NetworkService.getData(
              '${AppUrl.getUserDetails}',
              bearerToken: true));

      print("getAttendanceModel${userDetailsModel.name}");
   
     
      name=userDetailsModel.name;
      notifyListeners();
      EasyLoading.dismiss();
    /*  if (getAttendanceModel.success &&
          getAttendanceModel.data.attendance.isNotEmpty) {

        EasyLoading.dismiss();
        notifyListeners();
      } else {
        EasyLoading.dismiss();

        // CustomDisplays.showSnackBar(message: getAttendanceModel.message);
      }*/
    } catch (e) {
      EasyLoading.dismiss();
      print("objectukuikuk}");
    }
  }

  Future getRepository() async {
    try {
      print("objectsdcsdsd}");
      EasyLoading.show();

      RepositoryListModel repositoryModel = RepositoryListModel.fromJson(
          await NetworkService.getData(
              '${AppUrl.repos}',
              bearerToken: true));
      repositoryModelDetails.add(repositoryModel);
      print("getAttendanceModel${repositoryModel.details.length}");

      notifyListeners();
      EasyLoading.dismiss();

    } catch (e) {
      EasyLoading.dismiss();
      print("objectukuikuk}");
    }
  }


}