import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/global_view_model/setting/app_setting_view_model.dart';
import 'package:movie_flutter_training/models/enums/language.dart';
import 'package:movie_flutter_training/ui/pages/movie/list/list_movie_view_model.dart';
import 'package:movie_flutter_training/ui/pages/movie/widgets/list_movie_content.dart';
import 'package:movie_flutter_training/ui/widgets/base_screen.dart';
import 'package:movie_flutter_training/ui/widgets/base_text_label.dart';
import 'package:movie_flutter_training/utils/injection.dart';
import 'package:provider/provider.dart';

class ListMoviePage extends StatelessWidget {
  const ListMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ListMovieProvider>(),
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

  void _getData() {
    context.read<ListMovieProvider>().fetchPopularMovies();
  }

  void _onRefresh() {
    context.read<ListMovieProvider>().fetchPopularMovies(refresh: true);
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
      body: ListMovieContent(
        scrollController: _scrollController,
        onRefresh: _onRefresh,
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}