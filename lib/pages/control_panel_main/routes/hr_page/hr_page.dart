import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';

class HRPage extends StatelessWidget {
  const HRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).goNamed(
                    PageDir.create_app_user_page.name,
                    pathParameters: {
                      'lang':
                          context.read<PxLocalization>().locale.languageCode,
                    },
                  );
                },
                child: const Text("Create New User"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
