import 'package:croco/src/screens/configuration/configuration.dart';
import 'package:croco/src/screens/favorite/favorite.dart';
import 'package:croco/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'settings/settings_controller.dart';
import 'package:flutter/services.dart';

class MyApp extends StatefulWidget {
  MyApp(this.settingsController, {super.key});

  late SettingsController settingsController;
  Widget selectedPage = Home();
  int selectedIndex = 0;
  @override
  State<MyApp> createState() => _MyApp();
}

/// The Widget that configures your application.
class _MyApp extends State<MyApp> {
  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;

      if (index == 0) {
        widget.selectedPage = Home();
      } else if (index == 1) {
        widget.selectedPage = Favorite();
      } else if (index == 2) {
        widget.selectedPage = Configuration();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

    return AnimatedBuilder(
      animation: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
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
          themeMode: widget.settingsController.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                return Scaffold(
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: widget.selectedIndex,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.movie_outlined),
                        label: 'Films',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_outline),
                        label: 'Favoris',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.settings_accessibility_outlined),
                          label: 'Configuration')
                    ],
                    onTap: _onItemTapped, //New
                  ),

                  // return current route
                  body: widget.selectedPage,
                );
              },
            );
          },
        );
      },
    );
  }
}
