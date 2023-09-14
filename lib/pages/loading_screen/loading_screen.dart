import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    context.read<PxLocalization>().setLocale();
    Future.delayed(const Duration(seconds: 3)).whenComplete(() {
      GoRouter.of(context).go(
        '/${context.read<PxLocalization>().locale.languageCode}/${PageDir.server_selection_page.name}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            //TODO: change per vendor
            Expanded(
              child: Image.asset("assets/images/logo3.png"),
            ),
            const SizedBox(
              height: 20,
            ),
            //TODO: change per vendor
            const Text(
              'Brand Logo Name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            //TODO: change per version
            const Text('Admin Panel V 0.1'),

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 32.0,
              ),
              child: Text('Designed by Dr. Kareem Zaher'),
            ),
          ],
        ),
      ),
    );
  }
}
