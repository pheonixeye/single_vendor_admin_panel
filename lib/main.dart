import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/core/localization/app_localizations.dart';
import 'package:single_vendor_admin_panel/providers/_px_main.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';
import 'package:single_vendor_admin_panel/theme/theme.dart';

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
              //todo: extract away theming into a scope
              theme: mainTheme,
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
