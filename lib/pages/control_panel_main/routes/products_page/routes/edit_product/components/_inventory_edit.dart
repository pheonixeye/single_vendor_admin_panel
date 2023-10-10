import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/display_product_consumer.dart';

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
                const DisplayProductConsumerTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
