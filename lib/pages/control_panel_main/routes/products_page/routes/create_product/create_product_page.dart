import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/create_product/components/product_textfield.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final formKey = GlobalKey<FormState>();

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Empty Fields are not Allowed...";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Create Product'),
                    tileColor: Colors.amber.shade200,
                  ),
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
                        //TODO: clear textFields after submit
                        if (!formKey.currentState!.validate()) {
                          return;
                        }
                        await shellFunction(
                          context,
                          toExecute: context.read<PxProduct>().createProduct,
                          sucessMsg: "Product Created...",
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
