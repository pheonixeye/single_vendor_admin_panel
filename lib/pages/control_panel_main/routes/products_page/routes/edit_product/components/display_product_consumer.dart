import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/display_product_tile.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';

class DisplayProductConsumerTile extends StatelessWidget {
  const DisplayProductConsumerTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PxProduct>(
      builder: (context, p, c) {
        while (p.product == Product.initial()) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('No Product Selected...'),
                ),
              ),
            ),
          );
        }
        final product = p.product;
        return DisplayOnlyProductTile(product: product);
      },
    );
  }
}
