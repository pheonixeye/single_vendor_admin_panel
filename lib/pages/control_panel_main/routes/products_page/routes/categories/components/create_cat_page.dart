import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/categories/components/category_text_field.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_category.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({super.key});

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final formKey = GlobalKey<FormState>();

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Empty Fields are not Allowed...";
    }
    return null;
  }

  @override
  void initState() {
    context.read<PxProductCategory>().resetCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Create Category'),
                  tileColor: Colors.amber.shade200,
                ),
                CategoryTextField(
                  lang: FieldLang.en,
                  type: FieldType.name,
                  validator: _validator,
                ),
                CategoryTextField(
                  lang: FieldLang.ar,
                  type: FieldType.name,
                  validator: _validator,
                ),
                CategoryTextField(
                  lang: FieldLang.en,
                  type: FieldType.description,
                  validator: _validator,
                ),
                CategoryTextField(
                  lang: FieldLang.ar,
                  type: FieldType.description,
                  validator: _validator,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) {
                        showInfoSnackbar(context, "Invalid Form...");
                        return;
                      }
                      await shellFunction(
                        context,
                        toExecute:
                            context.read<PxProductCategory>().createCategory,
                        sucessMsg: "Product Category Created...",
                      );
                    },
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
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
