import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/units/components/unit_text_field.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products_unit.dart';

class UnitEditDialog extends StatefulWidget {
  const UnitEditDialog({super.key});

  @override
  State<UnitEditDialog> createState() => _UnitEditDialogState();
}

class _UnitEditDialogState extends State<UnitEditDialog> {
  final formKey = GlobalKey<FormState>();

  String? validator(String? value) {
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
            "Edit Product Unit",
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
            UnitsTextField(
              lang: FieldLang.en,
              operation: FieldOperation.update,
              validator: validator,
            ),
            UnitsTextField(
              lang: FieldLang.ar,
              operation: FieldOperation.update,
              validator: validator,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  try {
                    await EasyLoading.show(status: "LOADING...");
                    if (mounted) {
                      await context.read<PxProductUnit>().updateProductUnit();
                    }
                    await EasyLoading.dismiss();
                    if (mounted) {
                      showInfoSnackbar(
                        context,
                        'Update Complete...',
                      );
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    await EasyLoading.dismiss();
                    if (mounted) {
                      showInfoSnackbar(
                        context,
                        e.toString(),
                        Colors.red,
                      );
                      Navigator.pop(context);
                    }
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
