import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/common/app_demens.dart';

class BaseTextLabel extends StatelessWidget {
  final dynamic title;
  final double? fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final Color color;
  final TextAlign textAlign;
  final int maxLines;
  final double? fontHeight;
  final bool isRequired;

  const BaseTextLabel(this.title,
      {super.key,
        this.fontSize,
        this.fontWeight = FontWeight.normal,
        this.fontStyle = FontStyle.normal,
        this.decoration,
        this.decorationColor,
        this.color = Colors.black,
        this.textAlign = TextAlign.start,
        this.maxLines = 50,
        this.fontHeight,
        this.isRequired = false});

  @override
  Widget build(BuildContext context) {
    if (isRequired == true) {
      return Row(
        children: [
          renderContent(),
          SizedBox(width: 3),
          Text(
            "*",
            textAlign: textAlign,
            overflow: TextOverflow.ellipsis,
            maxLines: maxLines,
            style: TextStyle(
              height: fontHeight,
              fontSize: fontSize ?? AppDimens.fontNormal,
              fontWeight: fontWeight,
              color: AppColors.error,
              fontStyle: fontStyle,
              decoration: decoration,
              decorationColor: decorationColor,
            ),
          )
        ],
      );
    }

    return renderContent();
  }

  Widget renderContent() {
    final textWidget = Text(
        title?.toString() ?? "",
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        style: TextStyle(
          height: fontHeight ?? 22.27 / 19,
          fontSize: fontSize ?? AppDimens.fontNormal,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          decoration: decoration,
          decorationColor: decorationColor,
          color: color,
        ),
      softWrap: true,
    );

    return textWidget;
  }
}