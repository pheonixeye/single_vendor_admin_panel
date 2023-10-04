import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/create_product/components/product_textfield.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';

class ProductEditDialog extends StatefulWidget {
  const ProductEditDialog({super.key});

  @override
  State<ProductEditDialog> createState() => _ProductEditDialogState();
}

class _ProductEditDialogState extends State<ProductEditDialog> {
  final formKey = GlobalKey<FormState>();
  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Empty Fields are not Allowed...";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.teal.shade200,
      title: Row(
        children: [
          const Text(
            "Edit Product",
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
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProductTextField(
              lang: FieldLang.en,
              type: FieldType.name,
              validator: _validator,
            ),
            ProductTextField(
              lang: FieldLang.ar,
              type: FieldType.name,
              validator: _validator,
            ),
            ProductTextField(
              lang: FieldLang.en,
              type: FieldType.description,
              validator: _validator,
            ),
            ProductTextField(
              lang: FieldLang.ar,
              type: FieldType.description,
              validator: _validator,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  await shellFunction(
                    context,
                    toExecute: () => context.read<PxProduct>().updateProduct(),
                  );
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
