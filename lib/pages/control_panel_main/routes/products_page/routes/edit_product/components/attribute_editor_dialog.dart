import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/_category_edit.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/_images_edit.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/_inventory_edit.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/_price_edit.dart';

class ProductAttributeEditorDialog extends StatefulWidget {
  const ProductAttributeEditorDialog({super.key});

  @override
  State<ProductAttributeEditorDialog> createState() =>
      _ProductAttributeEditorDialogState();
}

class _ProductAttributeEditorDialogState
    extends State<ProductAttributeEditorDialog> {
  int _selectedIndex = 0;

  final List<Widget> list = [
    const CategoryEditComponent(),
    const PriceEditComponent(),
    const InventoryEditComponent(),
    const ImagesEditComponent(),
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.teal.shade50,
      title: Row(
        children: [
          const Text(
            "Edit Product Attributes",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          const Spacer(),
          IconButton.filled(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width - 100,
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: list[_selectedIndex],
              ),
            ),
            BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (value) {
                setState(() {
                  _selectedIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.category),
                  label: 'Category',
                  tooltip: 'Category',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.price_change),
                  label: 'Price',
                  tooltip: 'Price',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory),
                  label: 'Inventory',
                  tooltip: 'Inventory',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.image),
                  label: 'Images',
                  tooltip: 'Images',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
