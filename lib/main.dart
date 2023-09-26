import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/core/localization/app_localizations.dart';
import 'package:single_vendor_admin_panel/providers/_px_main.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';
import 'package:single_vendor_admin_panel/theme/sidebar_x_theme.dart';

Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return Consumer<PxLocalization>(
          builder: (context, l, c) {
            return MaterialApp.router(
              title: 'Single Vendor Admin Panel',
              //TODO: extract away theming into a scope
              theme: ThemeData(
                primaryColor: primaryColor,
                scaffoldBackgroundColor: scaffoldBackgroundColor,
                canvasColor: canvasColor,
                textTheme: const TextTheme(
                  headlineSmall: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                useMaterial3: true,
                cardTheme: CardTheme(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 8.0,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.amber,
                ),
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: RoutingLogic.router,
              builder: (context, child) {
                child = EasyLoading.init()(context, child);
                return child;
              },
              locale: l.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
