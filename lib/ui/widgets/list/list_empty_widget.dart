import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';

class ListEmptyWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  final RefreshCallback? onRefresh;

  const ListEmptyWidget({
    super.key,
    this.text = 'Empty Data',
    this.textColor,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh ?? _onRefreshData,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Center(
            child: BaseTextLabel(
              text,
              color: textColor ?? AppColors.textWhite,
            ),
          );
        },
        itemCount: 1,
      ),
    );
  }

  Future<void> _onRefreshData() async {}
}
