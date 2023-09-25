import 'package:flutter/material.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: add/remove items to inventory only
    //TODO: removing items requires authorization
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Text('Inventory Page'),
      ),
    );
  }
}
