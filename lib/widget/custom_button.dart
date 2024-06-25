// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/constant/style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback fun;
  final double? textSize;
  final bool? isLoading;
  final Color? color;
  final double? width;
  final double? height;
  final BorderSide? borderSide;
  final double? strokeWidt;
  final double? borderCircular;
  TextStyle? style;

  CustomButton(
      {super.key,
      required this.text,
      required this.fun,
      this.color,
      this.strokeWidt,
      this.height,
      this.style,
      this.width,
      this.borderCircular,
      this.textSize,
      this.borderSide,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SizedBox(
        width: width ?? MySize.getScaledSizeWidth(158),
        height: height ?? MySize.getScaledSizeHeight(54),
        child: ElevatedButton(
          onPressed: isLoading!
              ? () {
                  debugPrint("loading");
                }
              : fun,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderCircular ?? 15),
              side: borderSide ?? BorderSide.none,
            ),
            enableFeedback: true,
            padding: EdgeInsets.zero,
            backgroundColor: color ?? primary,
          ),
          child: isLoading == true
              ? Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: strokeWidt ?? 4,
                  ),
                )
              : Text(
                  text,
                  style: style ?? Styles.boldWhite716,
                ),
        ));
  }
}
