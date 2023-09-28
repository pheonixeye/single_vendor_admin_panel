import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/components/products_sidebar.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/product_page_builder.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products_nav.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        child: ChangeNotifierProvider(
          create: (context) => PxProductsNavigation(),
          builder: (context, child) {
            return Row(
              children: [
                const ProductsSidebar(),
                Consumer<PxProductsNavigation>(
                  builder: (context, n, c) {
                    return Expanded(
                      child: ProductsPageReference.values[n.index].page,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
