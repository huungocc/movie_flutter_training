// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movie_flutter_training/network/api_client.dart' as _i233;
import 'package:movie_flutter_training/network/api_util.dart' as _i571;
import 'package:movie_flutter_training/repository/movie_repository.dart'
    as _i233;
import 'package:movie_flutter_training/ui/pages/movie/detail/detail_movie_view_model.dart'
    as _i23;
import 'package:movie_flutter_training/ui/pages/movie/list/list_movie_view_model.dart'
    as _i162;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiUtil = _$ApiUtil();
    gh.lazySingleton<_i361.Dio>(() => apiUtil.dio());
    gh.lazySingleton<_i233.ApiClient>(() => apiUtil.apiClient(gh<_i361.Dio>()));
    gh.factory<_i233.MovieRepository>(
      () => _i233.MovieRepositoryImpl(apiClient: gh<_i233.ApiClient>()),
    );
    gh.factory<_i23.DetailMovieProvider>(
      () => _i23.DetailMovieProvider(gh<_i233.MovieRepository>()),
    );
    gh.factory<_i162.ListMovieProvider>(
      () => _i162.ListMovieProvider(gh<_i233.MovieRepository>()),
    );
    return this;
  }
}

class _$ApiUtil extends _i571.ApiUtil {}
