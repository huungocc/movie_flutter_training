import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/models/enums/movie_item_type.dart';
import 'package:movie_flutter_training/network/api_util.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/ui/pages/movie/detail/detail_movie_view_model.dart';
import 'package:movie_flutter_training/ui/widgets/base_screen.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';
import 'package:movie_flutter_training/ui/widgets/image/base_cached_image.dart';
import 'package:movie_flutter_training/ui/widgets/loading/base_loading.dart';
import 'package:movie_flutter_training/ui/widgets/movie/movie_info_item.dart';
import 'package:provider/provider.dart';

class DetailMovieArguments {
  int id;

  DetailMovieArguments({required this.id});
}

class DetailMoviePage extends StatelessWidget {
  final DetailMovieArguments arguments;

  const DetailMoviePage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailMovieProvider(
        MovieRepositoryImpl(apiClient: ApiUtil.apiClient),
      ),
      child: _DetailMovieBody(arguments: arguments),
    );
  }
}

class _DetailMovieBody extends StatefulWidget {
  final DetailMovieArguments arguments;

   const _DetailMovieBody({required this.arguments});

  @override
  State<_DetailMovieBody> createState() => _DetailMovieBodyState();
}

class _DetailMovieBodyState extends State<_DetailMovieBody> {
  bool isMark = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<DetailMovieProvider>();
      provider.loadSingleMovie(widget.arguments.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DetailMovieProvider>();
    final movie = provider.movieEntity;

    return BaseScreen(
      colorAppBar: Colors.transparent,
      iconBackColor: AppColors.textWhite,
      colorBackground: AppColors.movieBackground,
      isLightStatusBar: true,
      title: S.of(context).details,
      colorTitle: AppColors.textWhite,
      rightWidgets: [
        IconButton(
          onPressed: () {
            setState(() {
              isMark = !isMark;
            });
          },
          icon: Icon(
            isMark ? Icons.bookmark : Icons.bookmark_border,
            color: AppColors.textWhite,
          ),
        ),
      ],
      body: provider.isLoading && movie == null
          ? BaseLoading(size: 50)
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: BaseCachedImage(
                    imageUrl:
                        movie!.backdropPathUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: BaseLoading(size: 30),
                    errorWidget: Icon(Icons.error),
                  ),
                ),
                Positioned(
                  bottom: -75,
                  left: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BaseCachedImage(
                      height: 150,
                      width: 120,
                      imageUrl:
                          movie.posterPathUrl,
                      placeholder: BaseLoading(size: 30),
                      errorWidget: Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                          info: movie.voteAverage?.toStringAsFixed(1) ?? 'N/A',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(155, 15, 20, 0),
              child: BaseTextLabel(
                movie.title,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.textWhite,
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MovieInfoItem(
                  type: MovieItemType.calendar,
                  info: movie.releaseDate?.substring(0, 4) ?? 'N/A',
                ),
                Container(
                  width: 2,
                  height: 18,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                MovieInfoItem(
                  type: MovieItemType.clock,
                  info: S.of(
                    context,
                  ).count_minutes(movie.runtime ?? 'N/A'),
                ),
                Container(
                  width: 2,
                  height: 18,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
                MovieInfoItem(
                  type: MovieItemType.ticket,
                  info: (movie.genres?.isNotEmpty == true)
                      ? movie.genres!.first.name ?? 'N/A'
                      : 'N/A',
                ),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BaseTextLabel(movie.overview, color: AppColors.textWhite),
            ),
          ],
        ),
      ),
    );
  }
}
