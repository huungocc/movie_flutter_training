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
import 'package:movie_flutter_training/ui/widgets/list/list_empty_widget.dart';
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
      child: const _ListMovieBody(),
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
      _getData();
    });
  }

  void _getData({bool isRefresh = false}) {
    context.read<ListMovieProvider>().fetchPopularMovies(refresh: isRefresh);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      context.read<ListMovieProvider>().loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      colorAppBar: Colors.transparent,
      hiddenIconBack: true,
      colorBackground: AppColors.movieBackground,
      isLightStatusBar: true,
      title: S.of(context).movie,
      colorTitle: AppColors.textWhite,
      rightWidgets: [
        Selector<AppSettingProvider, Language>(
          selector: (context, provider) => provider.language,
          builder: (context, language, _) {
            return IconButton(
              icon: BaseTextLabel(language.flag, fontSize: 24),
              onPressed: () {
                final newLang = language.toggle;
                context.read<AppSettingProvider>().changeLanguage(newLang);
              },
            );
          },
        ),
      ],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Check Loading State
    return Selector<ListMovieProvider, bool>(
      selector: (context, provider) => provider.isListMovieLoading,
      builder: (context, isLoading, _) {
        if (isLoading) {
          return BaseLoading(size: 50);
        }
        return _buildContent();
      },
    );
  }

  Widget _buildContent() {
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
            onRefresh: () async => _getData(isRefresh: true),
          );
        }

        // Show list when has data
        if (state.hasData) {
          return _buildListMovies(state.movies, state.isLoadingMore);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildListMovies(List<MovieEntity> movies, bool isLoadingMore) {
    return RefreshIndicator(
      onRefresh: () async => _getData(isRefresh: true),
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: movies.length + (isLoadingMore ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          if (index >= movies.length) {
            return _buildLoadingMoreStatus();
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

  Widget _buildLoadingMoreStatus() {
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
