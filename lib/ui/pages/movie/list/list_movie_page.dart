import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/global_view_model/setting/app_setting_view_model.dart';
import 'package:movie_flutter_training/models/entities/movie/movie_entity.dart';
import 'package:movie_flutter_training/models/enums/language.dart';
import 'package:movie_flutter_training/network/api_util.dart';
import 'package:movie_flutter_training/repository/movie_repository.dart';
import 'package:movie_flutter_training/ui/pages/movie/list/list_movie_navigator.dart';
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
          ListMovieProvider(MovieRepositoryImpl(apiClient: ApiUtil.apiClient)),
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ListMovieProvider>();
      provider.fetchPopularMovies();
    });
  }

  void _onScroll() {
    final provider = context.read<ListMovieProvider>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100 &&
        provider.canLoadMore) {
      provider.loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ListMovieProvider>();
    final movies = provider.movies;

    final setting = context.watch<AppSettingProvider>();
    final currentLang = setting.language;

    return BaseScreen(
      colorAppBar: Colors.transparent,
      hiddenIconBack: true,
      colorBackground: AppColors.movieBackground,
      isLightStatusBar: true,
      title: S.of(context).movie,
      colorTitle: AppColors.textWhite,
      rightWidgets: [
        IconButton(
          icon: BaseTextLabel(currentLang.flag, fontSize: 24),
          onPressed: () {
            final newLang = currentLang.toggle;
            context.read<AppSettingProvider>().changeLanguage(newLang);
          },
        ),
      ],
      body: RefreshIndicator(
        backgroundColor: AppColors.textWhite,
        color: AppColors.textBlack,
        onRefresh: () => provider.fetchPopularMovies(refresh: true),
        child: _buildContent(provider, movies),
      ),
    );
  }

  Widget _buildContent(ListMovieProvider provider, List<MovieEntity> movies) {
    if (provider.isLoading && !provider.hasData) {
      return const Center(
        child: BaseLoading(size: 50),
      );
    }

    // Content
    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      itemCount: movies.length + _getFooterItemCount(provider),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        if (index >= movies.length) {
          return _buildFooterItem(provider);
        }

        final movie = movies[index];
        return MovieInfoCard(
          movie: movie,
          onTap: () {
            ListMovieNavigator(
              context: context,
            ).navigateToDetail(movie.id!);
          },
        );
      },
    );
  }

  int _getFooterItemCount(ListMovieProvider provider) {
    if (provider.isLoadingMore) return 1;
    if (provider.isError && provider.hasData) return 1;
    if (provider.hasData && provider.isComplete) return 1;
    return 0;
  }

  Widget _buildFooterItem(ListMovieProvider provider) {
    if (provider.isRefreshing) {
      return const SizedBox.shrink();
    }

    if (provider.isLoadingMore) {
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
    }
    return const SizedBox.shrink();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}