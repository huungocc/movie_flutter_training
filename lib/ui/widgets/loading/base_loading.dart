import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';

class BaseLoading extends StatelessWidget {
  final Color valueColor;
  final Color backgroundColor;
  final double size;

  const BaseLoading({
    super.key,
    this.valueColor = const Color(0xFFC90003),
    this.backgroundColor = AppColors.textWhite,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          backgroundColor: backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(valueColor),
          strokeWidth: 2,
        ),
      ),
    );
  }
}
