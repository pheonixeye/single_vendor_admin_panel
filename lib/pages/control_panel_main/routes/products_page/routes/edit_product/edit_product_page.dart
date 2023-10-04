import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/product_tile.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/search_textfield.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_list.dart';

class EditProductPage extends StatelessWidget {
  const EditProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Edit Product'),
                  tileColor: Colors.amber.shade200,
                  trailing: FloatingActionButton.small(
                    tooltip: "Refresh",
                    heroTag: 'refresh-products',
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () async {
                      await shellFunction(
                        context,
                        toExecute: context.read<PxProductList>().listProducts,
                      );
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ),
                const ProductSearchTextField(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<PxProductList>(
                      builder: (context, l, c) {
                        while (l.filteredProducts.isEmpty) {
                          return const Center(
                            child: Card(
                              child: Center(
                                child: Text('No Products Found...'),
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: l.filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = l.filteredProducts[index];
                            return ProductTile(
                              index: index,
                              product: product,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
