import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/ui/widgets/base_screen.dart';

class ListMoviePage extends StatelessWidget {
  const ListMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListMovieBody();
  }
}

class ListMovieBody extends StatefulWidget {
  const ListMovieBody({super.key});

  @override
  State<ListMovieBody> createState() => _ListMovieBodyState();
}

class _ListMovieBodyState extends State<ListMovieBody> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      colorAppBar: Colors.transparent,
      hiddenIconBack: true,
      colorBackground: AppColors.movieBackground,
      isLightStatusBar: true,
      title: 'Movies',
      colorTitle: AppColors.textWhite,
      // body: RefreshIndicator(
      //   backgroundColor: AppColors.textWhite,
      //   color: AppColors.textBlack,
      //   onRefresh: () async {
      //     //
      //   },
      //   child: BlocBuilder<SimpleMovieCubit, MovieState>(
      //     builder: (context, state) {
      //       if (state is MovieLoading) {
      //         return Center(
      //           child: SpinKitCircle(size: 50, color: AppColors.white),
      //         );
      //       }
      //
      //       if (state is MovieLoaded) {
      //         final movies = state.movies;
      //         return Container(
      //           margin: const EdgeInsets.symmetric(horizontal: 20),
      //           child: ListView.separated(
      //             controller: _scrollController,
      //             itemCount: movies.length + (state.isLoadingMore || !state.isComplete ? 1 : 0),
      //             separatorBuilder: (context, index) => const SizedBox(height: 20),
      //             itemBuilder: (context, index) {
      //               if (index == movies.length) {
      //                 return Padding(
      //                   padding: const EdgeInsets.all(16.0),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       SpinKitCircle(size: 25, color: AppColors.white),
      //                       const SizedBox(width: 10),
      //                       BaseTextLabel(
      //                         AppLocalizations.of(context)!.loading_movies,
      //                         color: AppColors.white,
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               }
      //
      //               final movie = movies[index];
      //               return MovieInfoCard(
      //                 movie: movie,
      //                 onTap: () {
      //                   Navigator.pushNamed(
      //                     context,
      //                     Routes.simpleDetailMovieScreen,
      //                     arguments: movie.id,
      //                   );
      //                 },
      //               );
      //             },
      //           ),
      //         );
      //       }
      //
      //       return const SizedBox.shrink();
      //     },
      //   ),
      // ),
    );
  }
}



