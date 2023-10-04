import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/attribute_editor_dialog.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/product_edit_dialog.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.index, required this.product});
  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Tooltip(
            message:
                "Tap to Edit name and description, Long Press To Edit Category, Price, Images & Inventory.",
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              leading: CircleAvatar(
                child: Text((index + 1).toString()),
              ),
              hoverColor: Colors.amber,
              onTap: () async {
                //todo: edit product
                context.read<PxProduct>().selectProduct(product);
                await showDialog(
                    context: context,
                    builder: (context) {
                      return const ProductEditDialog();
                    });
              },
              title: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Text(product.nameEn),
                  const Text(" | "),
                  Text(product.nameAr),
                ],
              ),
              subtitle: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Text(product.descriptionEn),
                  const Text(" | "),
                  Text(product.descriptionAr),
                ],
              ),
              onLongPress: () async {
                context.read<PxProduct>().selectProduct(product);
                await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return const ProductAttributeEditorDialog();
                    });
              },
              trailing: FloatingActionButton(
                heroTag: product.productId,
                tooltip: "Delete",
                onPressed: () async {
                  //todo: delete product
                  await shellFunction(
                    context,
                    toExecute: () {
                      context.read<PxProduct>().deleteProduct(product);
                    },
                  );
                },
                child: const Icon(Icons.delete),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
