import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/AppColor.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color buttonTextColor;
  final Color borderColor;
  final double height;
  final double width;

  const CustomButton({
    Key? key,
    required this.text,
    this.backgroundColor = AppColor.buttonColor,
    this.buttonTextColor = AppColor.white,
    this.borderColor = AppColor.white,
    this.height = 45,
    this.width = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
          border: Border.all(color: borderColor, width: 0.5)),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,

          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            letterSpacing: 0.0,
            color: buttonTextColor,
          ),


        ),
      ),
    );
  }
}
