import 'package:flutter/material.dart';

class BaseNavigationPage extends StatefulWidget {
  const BaseNavigationPage({super.key});

  @override
  State<BaseNavigationPage> createState() => _BaseNavigationPageState();
}

class _BaseNavigationPageState extends State<BaseNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
