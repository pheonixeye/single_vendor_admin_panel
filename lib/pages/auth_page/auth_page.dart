import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_appbar.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(
        leading: SizedBox(),
        title: Text('Authentication Page'),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //TODO: user
          //TODO: password
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Authenticate"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(
                  PageDir.create_app_user_page.name,
                  pathParameters: {
                    'lang': context.read<PxLocalization>().locale.languageCode,
                  },
                );
              },
              child: const Text("Create New User"),
            ),
          ),
        ],
      ),
    );
  }
}
