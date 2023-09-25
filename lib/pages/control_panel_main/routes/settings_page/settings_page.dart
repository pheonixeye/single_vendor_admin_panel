import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  _switchLanguage(BuildContext context) {
    final location =
        GoRouter.of(context).routeInformationProvider.value.uri.path;
    final paths = location.split(RegExp('/'));
    paths.removeAt(0);
    paths.removeAt(0);
    final whereToGo = paths.join('/');
    if (context.read<PxLocalization>().locale.languageCode == 'en') {
      GoRouter.of(context).go('/ar/$whereToGo');
    } else {
      GoRouter.of(context).go('/en/$whereToGo');
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: theme
    //TODO: language
    //TODO: find other settings
    return Scaffold(
      backgroundColor: Colors.pink,
      body: const Center(
        child: Text('Settings Page'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "lang-btn",
        onPressed: () {
          _switchLanguage(context);
        },
        child: Text(context.watch<PxLocalization>().locale.languageCode),
      ),
    );
  }
}
