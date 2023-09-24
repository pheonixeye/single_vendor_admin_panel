import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/constants/env.dart';
import 'package:single_vendor_admin_panel/core/localization/app_localizations.dart';
import 'package:single_vendor_admin_panel/providers/_px_main.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';

Future main() async {
  await dotenv.load(fileName: ENVIRONMENT.test.path);
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
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
                scaffoldBackgroundColor: Theme.of(context).primaryColor,
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