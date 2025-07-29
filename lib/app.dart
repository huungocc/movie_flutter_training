import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movie_flutter_training/configs/app_configs.dart';
import 'package:movie_flutter_training/generated/l10n.dart';
import 'package:movie_flutter_training/global_view_model/setting/app_setting_view_model.dart';
import 'package:movie_flutter_training/router/router_config.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ChangeNotifierProvider(
      create: (_) => AppSettingProvider()..getInitialSetting(),
      child: Consumer<AppSettingProvider>(
        builder: (context, settingProvider, _) {
          return GestureDetector(
            onTap: () {
              _hideKeyboard(context);
            },
            child: _buildMaterialApp(locale: settingProvider.locale),
          );
        },
      ),
    );
  }

  Widget _buildMaterialApp({required Locale locale}) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConfigs.appName,
      themeMode: ThemeMode.dark,
      routerConfig: AppRouter.router,
      locale: locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
