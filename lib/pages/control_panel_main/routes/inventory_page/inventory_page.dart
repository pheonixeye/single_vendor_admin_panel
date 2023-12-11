import 'package:flutter/material.dart';

//TODO: add/remove items to inventory
//TODO: removing items requires authorization
//TODO: have list of poviders
//TODO: have list of orders from providers
//TODO: have list of buy order request & details
//TODO: have list of sell order requests & details
class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  String? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Card(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Test"),
            ),
          ],
        ),
      ),
    );
  }
}
