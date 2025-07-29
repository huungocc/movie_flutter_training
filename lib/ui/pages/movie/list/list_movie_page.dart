import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/network/api_util.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/ui/pages/movie/list/list_movie_view_model.dart';
import 'package:movie_flutter_training/ui/widgets/base_screen.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';
import 'package:movie_flutter_training/ui/widgets/loading/base_loading.dart';
import 'package:movie_flutter_training/ui/widgets/movie/movie_Info_card.dart';
import 'package:provider/provider.dart';

class ListMoviePage extends StatelessWidget {
  const ListMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ListMovieProvider(MovieRepositoryImpl(apiClient: ApiUtil.apiClient))
            ..fetchPopularMovies(),
      child: _ListMovieBody(),
    );
  }
}

class _ListMovieBody extends StatefulWidget {
  const _ListMovieBody();

  @override
  State<_ListMovieBody> createState() => _ListMovieBodyState();
}

class _ListMovieBodyState extends State<_ListMovieBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final provider = context.read<ListMovieProvider>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !provider.isLoadingMore &&
        !provider.isComplete) {
      provider.loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListMovieProvider>();
    final movies = provider.movies;

    return BaseScreen(
      colorAppBar: Colors.transparent,
      hiddenIconBack: true,
      colorBackground: AppColors.movieBackground,
      isLightStatusBar: true,
      title: S.of(context).movie,
      colorTitle: AppColors.textWhite,
      body: RefreshIndicator(
        backgroundColor: AppColors.textWhite,
        color: AppColors.textBlack,
        onRefresh: () => provider.fetchPopularMovies(refresh: true),
        child: provider.isLoading && movies.isEmpty
            ? BaseLoading(size: 50)
            : ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                itemCount:
                    movies.length +
                    (provider.isLoadingMore || !provider.isComplete ? 1 : 0),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  if (index == movies.length) {
                    if (!provider.isRefreshing) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const BaseLoading(size: 25),
                            const SizedBox(width: 10),
                            BaseTextLabel(
                              S.of(context).loading_movies,
                              color: AppColors.textWhite,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }

                  final movie = movies[index];
                  return MovieInfoCard(movie: movie, onTap: () {});
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
