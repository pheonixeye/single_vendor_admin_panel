import 'package:flutter/material.dart';

class InventoryEditComponent extends StatelessWidget {
  const InventoryEditComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Edit Inventory'),
                  tileColor: Colors.red.shade200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
