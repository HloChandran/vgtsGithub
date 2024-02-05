import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/AppColor.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final bool isBold;
  final TextAlign? isTextAlign;
  final bool isLanguage;
  final Color textColor;

  const CustomText(
      {Key? key,
      required this.text,
      this.fontSize = 18,
      this.isBold = false,
      this.isTextAlign,
      this.isLanguage = true,
      this.textColor = AppColor.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
           text,
      textAlign:isTextAlign,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: textColor,
        ),
      ),
    );
  }
}
