import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/network/api_util.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/ui/pages/movie/detail/detail_movie_view_model.dart';
import 'package:movie_flutter_training/ui/pages/movie/widgets/detail_movie_content.dart';
import 'package:movie_flutter_training/ui/widgets/base_screen.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  void _getData() {
    context.read<DetailMovieProvider>().loadSingleMovie(widget.arguments.id);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      colorAppBar: Colors.transparent,
      iconBackColor: AppColors.textWhite,
      colorBackground: AppColors.movieBackground,
      isLightStatusBar: true,
      title: S.of(context).details,
      colorTitle: AppColors.textWhite,
      rightWidgets: [
        Selector<DetailMovieProvider, bool>(
          selector: (context, provider) => provider.isMovieMark,
          builder: (context, isMovieMark, _) {
            return IconButton(
              onPressed: () {
                context.read<DetailMovieProvider>().markMovie();
              },
              icon: Icon(
                isMovieMark ? Icons.bookmark : Icons.bookmark_border,
                color: AppColors.textWhite,
              ),
            );
          },
        ),
      ],
      body: DetailMovieContent(
        onRefresh: _getData,
      ),
    );
  }
}