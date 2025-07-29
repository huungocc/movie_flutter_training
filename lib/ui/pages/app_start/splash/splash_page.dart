import 'package:flutter/material.dart';
import 'package:movie_flutter_training/common/app_colors.dart';
import 'package:movie_flutter_training/ui/pages/app_start/splash/splash_navigator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToListMovie(context);
  }

  void _navigateToListMovie(context) {
    Future.delayed(const Duration(seconds: 2), () {
      SplashNavigator(context: context).openListMovie();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: AppColors.primary)),
        ],
      ),
    );
  }
}
