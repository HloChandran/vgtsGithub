import 'package:flutter/material.dart';


class CustomImageAsset extends StatefulWidget {
  final String images;
  final double? height;
  final double? width;

  const CustomImageAsset(
      {Key? key,
      required this.images,
       this.height=30,
       this.width=30})
      : super(key: key);

  @override
  State<CustomImageAsset> createState() => _CustomImageAssetState();
}

class _CustomImageAssetState extends State<CustomImageAsset> {
  @override
  Widget build(BuildContext context) {
    return  Image.asset(
        widget.images,
        height: widget.height,
        width: widget.width,
    );
  }
}
