import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/categories/components/category_text_field.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_category.dart';

class CategoryEditDialog extends StatefulWidget {
  const CategoryEditDialog({super.key});

  @override
  State<CategoryEditDialog> createState() => _CategoryEditDialogState();
}

class _CategoryEditDialogState extends State<CategoryEditDialog> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.teal.shade200,
      title: Row(
        children: [
          const Text(
            "Edit Product Category",
            style: TextStyle(
              fontSize: 28,
            ),
          ),
          const SizedBox(width: 50),
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
            const CategoryTextField(
              lang: FieldLang.en,
              type: FieldType.name,
            ),
            const CategoryTextField(
              lang: FieldLang.ar,
              type: FieldType.name,
            ),
            const CategoryTextField(
              lang: FieldLang.en,
              type: FieldType.description,
            ),
            const CategoryTextField(
              lang: FieldLang.ar,
              type: FieldType.description,
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
                    toExecute: () => context
                        .read<PxProductCategory>()
                        .updateProductCategory(),
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
