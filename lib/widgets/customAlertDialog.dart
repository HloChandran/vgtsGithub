

import 'package:flutter/material.dart';
import 'package:vgtsgithub/config/AppColor.dart';
import 'package:vgtsgithub/widgets/customButton.dart';

import 'customText.dart';


class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String msg;
  final Function()? onPressCancel;
  final Function()? onPressOk;

  const CustomAlertDialog(
      {super.key,
      required this.title,
      required this.msg,
      this.onPressCancel,
      this.onPressOk});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  CustomText(text: title),
                  const SizedBox(height: 15),
                  CustomText(
                    text: msg,
                    fontSize: 12,
                  ),

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onPressCancel,
                            child: CustomButton(text: 'Cancel',backgroundColor: AppColor.grey,)),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: GestureDetector(
                            onTap: onPressOk,
                            child: CustomButton(text: 'Logout')),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
