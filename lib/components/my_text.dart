import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? containerPadding;
  final Alignment? containerAlignment;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const MyText({
    Key? key,
    required this.text,
    this.fontSize,
    this.color,
    this.textStyle,
    this.fontWeight,
    this.containerPadding,
    this.containerAlignment,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: containerAlignment ?? Alignment.center,
      padding: containerPadding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: color ?? Colors.black,
              fontWeight: fontWeight,
              fontSize: fontSize,
              fontFamily: 'Metropolis',
            ),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }
}
