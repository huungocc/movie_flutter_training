import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/models/enums/movie_item_type.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';
import 'package:movie_flutter_training/ui/widgets/image/base_cached_image.dart';
import 'package:movie_flutter_training/ui/widgets/loading/base_loading.dart';
import 'package:movie_flutter_training/ui/widgets/movie/movie_info_item.dart';

class MovieInfoCard extends StatelessWidget {
  final MovieEntity? movie;
  final GestureTapCallback? onTap;

  const MovieInfoCard({super.key, this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BaseCachedImage(
              height: 130,
              width: 100,
              imageUrl: movie!.posterPathUrl,
              placeholder: BaseLoading(size: 30),
              errorWidget: Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseTextLabel(
                  movie?.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textWhite,
                  maxLines: 1,
                ),
                const SizedBox(height: 15),
                MovieInfoItem(
                  type: MovieItemType.star,
                  info: movie?.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                ),
                const SizedBox(height: 5),
                MovieInfoItem(
                    type: MovieItemType.ticket,
                    info: (movie?.genres?.isNotEmpty == true)
                        ? movie!.genres!.first.name ?? 'N/A'
                        : 'N/A'
                ),
                const SizedBox(height: 5),
                MovieInfoItem(
                  type: MovieItemType.calendar,
                  info: movie?.releaseDate?.substring(0, 4) ?? 'N/A',
                ),
                const SizedBox(height: 5),
                MovieInfoItem(
                    type: MovieItemType.clock,
                    info: S.of(context).count_minutes(movie?.runtime ?? '100')
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

