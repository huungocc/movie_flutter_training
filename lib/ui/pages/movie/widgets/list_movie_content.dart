import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/ui/pages/movie/list/list_movie_navigator.dart';
import 'package:movie_flutter_training/ui/pages/movie/list/list_movie_view_model.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';
import 'package:movie_flutter_training/ui/widgets/list/list_empty_widget.dart';
import 'package:movie_flutter_training/ui/widgets/loading/base_loading.dart';
import 'package:movie_flutter_training/ui/widgets/movie/movie_Info_card.dart';
import 'package:provider/provider.dart';

class ListMovieContent extends StatelessWidget {
  final ScrollController scrollController;
  final VoidCallback onRefresh;

  const ListMovieContent({
    super.key,
    required this.scrollController,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    // Check Loading State
    return Selector<ListMovieProvider, bool>(
      selector: (context, provider) => provider.isListMovieLoading,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return BaseLoading(size: 50);
        }
        return _buildContent(context);
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Selector<
        ListMovieProvider,
        ({
        bool isListMovieFailure,
        bool hasData,
        List<MovieEntity> movies,
        bool isLoadingMore,
        })
    >(
      selector: (context, provider) => (
      isListMovieFailure: provider.isListMovieFailure,
      hasData: provider.hasData,
      movies: provider.movies,
      isLoadingMore: provider.isLoadingMore,
      ),
      builder: (context, state, _) {
        // Error: First Fetch Data && Empty Data
        if (state.isListMovieFailure && !state.hasData) {
          return ListEmptyWidget(
            text: S.of(context).empty_movies,
            onRefresh: () async => onRefresh(),
          );
        }

        // Show list when has data
        if (state.hasData) {
          return _buildListMovies(context, state.movies, state.isLoadingMore);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildListMovies(BuildContext context, List<MovieEntity> movies, bool isLoadingMore) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: movies.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return _buildLoadingMoreStatus(context);
          }

          final movie = movies[index];
          return MovieInfoCard(
            movie: movie,
            onTap: () {
              ListMovieNavigator(context: context).navigateToDetail(movie.id!);
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingMoreStatus(BuildContext context) {
    return SafeArea(
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
  }
}