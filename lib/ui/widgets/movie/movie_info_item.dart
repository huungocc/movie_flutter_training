import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/gen/assets.gen.dart';
import 'package:movie_flutter_training/models/enums/movie_item_type.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';

class MovieInfoItem extends StatelessWidget {
  final MovieItemType type;
  final String info;

  const MovieInfoItem({
    super.key,
    required this.type,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    Widget icon;
    Color color = AppColors.textWhite;
    FontWeight fontWeight = FontWeight.normal;

    switch (type) {
      case MovieItemType.star:
        icon = Assets.vectors.icStar.svg();
        color = AppColors.movieYellowStar;
        fontWeight = FontWeight.w600;
        break;
      case MovieItemType.ticket:
        icon = Assets.vectors.icTicket.svg();
        break;
      case MovieItemType.calendar:
        icon = Assets.vectors.icCalendar.svg();
        break;
      case MovieItemType.clock:
        icon = Assets.vectors.icClock.svg();
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 5),
        BaseTextLabel(
          info,
          color: color,
          fontWeight: fontWeight,
        ),
      ],
    );
  }
}

