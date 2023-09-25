import 'package:flutter/material.dart';

class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({super.key});
  static const Icon icon = Icon(Icons.home);
  @override
  Widget build(BuildContext context) {
    //TODO: follow product removal requests from inventory
    //TODO: follow product insertion into inventory
    //TODO: follow salaries for appUsers
    //TODO: follow HR reports
    //TODO: follow sales reports
    //TODO: follow appUsers attendance reports
    //TODO: follow monthly reports
    return const Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Text('Admin Panel Page'),
      ),
    );
  }
}
