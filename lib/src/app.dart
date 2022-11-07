import 'package:croco/src/screens/home/home.dart';
import 'package:croco/src/services/synchronizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({super.key, required this.settingsController}) {}

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.light(),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                return Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: 0,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.movie_outlined),
                        label: 'Films',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.heart_broken_outlined),
                        label: 'Favoris',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings_accessibility_outlined),
                          label: 'Configuration')
                    ],
                  ),

                  // return current route
                  body: routeSettings.name == "Films" ? Home() : Home(),
                );
              },
            );
          },
        );
      },
    );
  }
}
