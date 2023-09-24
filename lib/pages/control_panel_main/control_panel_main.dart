import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';

class ControlPanelMain extends StatelessWidget {
  const ControlPanelMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<PxAppUsers>(
            builder: (context, s, c) {
              while (s.userSession == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Text(
                s.userSession.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
