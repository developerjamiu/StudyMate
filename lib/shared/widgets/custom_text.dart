import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

enum TextType { headline6, subtitle1, bodyText1 }

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextType textType;

  const CustomText(
    this.text, {
    Key? key,
    this.color,
    required this.textType,
  }) : super(key: key);

  const CustomText.headline6(
    String text, {
    Key? key,
    Color? color,
  }) : this(text, textType: TextType.headline6, color: color);

  const CustomText.subtitle1(
    String text, {
    Key? key,
    Color? color,
  }) : this(text, textType: TextType.subtitle1, color: color);

  const CustomText.bodyText1(
    String text, {
    Key? key,
    Color? color,
  }) : this(text,
            textType: TextType.bodyText1,
            color: color ?? AppColors.onSurfaceColor);

  TextStyle? textStyle(TextType textType, BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (textType) {
      case TextType.headline6:
        return textTheme.headline6;
      case TextType.subtitle1:
        return textTheme.subtitle1;
      case TextType.bodyText1:
        return textTheme.bodyText1;

      default:
        return textTheme.bodyText2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle(textType, context)?.copyWith(
        color: color,
      ),
    );
  }
}
