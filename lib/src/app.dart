import 'package:findmyrestaurant/src/enums/app_routes_enum.dart';
import 'package:findmyrestaurant/src/services/app_launch_service.dart';
import 'package:findmyrestaurant/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  Widget _determineHomeView(){
    final AppLaunchService appLaunchService = AppLaunchService.instance; 
    return appLaunchService.isUserEmailConfirmed ? AppRoutes.survey.view : AppRoutes.onboarding.view;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      initialRoute: AppRoutes.onboarding.route,
      routes: {        
        AppRoutes.survey.route: (context) => AppRoutes.survey.view,
      },
      home: _determineHomeView(),
    );
  }
}
