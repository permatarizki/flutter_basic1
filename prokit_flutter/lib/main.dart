//region imports
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:prokit_flutter/main/screens/AppSplashScreen.dart';
import 'package:prokit_flutter/main/store/AppStore.dart';
import 'package:prokit_flutter/main/utils/AppTheme.dart';
import 'package:prokit_flutter/routes.dart';
import 'package:prokit_flutter/webApps/portfolios/portfolio1/Portfolio1Screen.dart';
import 'package:prokit_flutter/webApps/portfolios/portfolio2/Portfolio2Screen.dart';
import 'package:prokit_flutter/webApps/portfolios/portfolio3/Portfolio3Screen.dart';

import 'main/utils/AppConstant.dart';
import 'muvi/utils/flix_app_localizations.dart';
//endregion

/// This variable is used to get dynamic colors when theme mode is changed
AppStore appStore = AppStore();

void main() async {
  //region Entry Point
  WidgetsFlutterBinding.ensureInitialized();

  appStore.toggleDarkMode(value: await getBool(isDarkModeOnPref));

  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runApp(MyApp());
  //endregion
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [MuviAppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate],
        localeResolutionCallback: (locale, supportedLocales) => Locale(appStore.selectedLanguage),
        locale: Locale(appStore.selectedLanguage),
        supportedLocales: [Locale('en', '')],
        routes: routes(),
        title: '$mainAppName${!isMobile ? ' ${platformName()}' : ''}',
        home: AppSplashScreen(),
        theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
        builder: scrollBehaviour(),
      ),
    );
  }
}
