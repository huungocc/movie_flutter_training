import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/models/enums/movie_item_type.dart';
import 'package:movie_flutter_training/ui/pages/movie/detail/detail_movie_view_model.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';
import 'package:movie_flutter_training/ui/widgets/image/base_cached_image.dart';
import 'package:movie_flutter_training/ui/widgets/list/list_empty_widget.dart';
import 'package:movie_flutter_training/ui/widgets/loading/base_loading.dart';
import 'package:movie_flutter_training/ui/widgets/movie/movie_info_item.dart';
import 'package:provider/provider.dart';

class DetailMovieContent extends StatelessWidget {
  final VoidCallback onRefresh;

  const DetailMovieContent({
    super.key,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<DetailMovieProvider>(
      builder: (context, provider, _) {
        if (provider.isMovieDetailLoading) {
          return BaseLoading(size: 50);
        }

        if (provider.isMovieDetailLoaded) {
          if (!provider.hasData) {
            return ListEmptyWidget(
              text: S.of(context).empty_movies,
              onRefresh: () async => onRefresh(),
            );
          } else {
            final movie = provider.movieEntity;
            return _buildMovieContent(movie, context);
          }
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMovieContent(MovieEntity? movie, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Content: Banner + Poster + Rating + title
          _buildHeaderContent(movie, context),

          const SizedBox(height: 100),

          /// Movie Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MovieInfoItem(
                type: MovieItemType.calendar,
                info: (movie?.releaseDate?.length ?? 0) >= 4
                    ? movie!.releaseDate!.substring(0, 4)
                    : S.of(context).n_a,
              ),
              _buildDivider(),
              MovieInfoItem(
                type: MovieItemType.clock,
                info: S.of(context).count_minutes(movie?.runtime ?? '100'),
              ),
              _buildDivider(),
              MovieInfoItem(
                type: MovieItemType.ticket,
                info: (movie?.genres?.isNotEmpty == true)
                    ? movie!.genres!.first.name ?? S.of(context).n_a
                    : S.of(context).n_a,
              ),
            ],
          ),

          const SizedBox(height: 30),

          /// Overview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BaseTextLabel(
              movie?.overview ?? S.of(context).n_a,
              color: AppColors.textWhite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderContent(MovieEntity? movie, BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        /// Backdrop
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: BaseCachedImage(
            imageUrl: movie?.backdropPathUrl ?? '',
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: const BaseLoading(size: 30),
            errorWidget: const Icon(Icons.error),
          ),
        ),

        Positioned(
          bottom: -75,
          left: 20,
          right: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BaseCachedImage(
                  height: 150,
                  width: 120,
                  imageUrl: movie?.posterPathUrl ?? '',
                  placeholder: const BaseLoading(size: 30),
                  errorWidget: const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),

              /// Title
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: BaseTextLabel(
                    movie?.title ?? S.of(context).n_a,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.textWhite,
                    maxLines: 2,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// Rating
        Positioned(
          bottom: 10,
          right: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 10,
                ),
                child: MovieInfoItem(
                  type: MovieItemType.star,
                  info: movie?.voteAverage?.toStringAsFixed(1) ?? S.of(context).n_a,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 2,
      height: 18,
      color: AppColors.gray1,
      margin: const EdgeInsets.symmetric(horizontal: 10),
    );
  }
}