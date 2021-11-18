import 'package:flutter/material.dart';
import 'package:tharawatSeas/homePage.dart';
import 'package:tharawatSeas/scanqr.dart';
import 'generated/locale_keys.g.dart';
import 'pageRoutes.dart';
import 'profile.dart';
import 'addAasl.dart';
import 'gaard.dart';
import 'mainScreen.dart';
import 'splashscreen.dart';
import 'constant.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        useOnlyLangCode: true,
        saveLocale: true,
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: LocaleKeys.AppName.tr(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: EasyLocalization.of(context)!.delegates,
      supportedLocales: EasyLocalization.of(context)!.supportedLocales,
      locale: EasyLocalization.of(context)!.locale,
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        PageRoutes.home: (context) => MainScreen(),
        PageRoutes.profile: (context) => Profile(),
        PageRoutes.gaard: (context) => Gaard(),
        PageRoutes.addAsal: (context) => AddAasl(),
        PageRoutes.scanqr: (context) => ScanScreen(),
        PageRoutes.homepage: (context) => HomePage()
      },
      home: SplashScreen(),
    );
  }
}
