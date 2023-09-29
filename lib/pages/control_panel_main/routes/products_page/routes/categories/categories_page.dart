import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/categories/components/category_text_field.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: const [
                ListTile(
                  title: Text('Categories Page'),
                ),
                CategoryTextField(
                  lang: FieldLang.en,
                  type: FieldType.name,
                ),
                CategoryTextField(
                  lang: FieldLang.ar,
                  type: FieldType.name,
                ),
                CategoryTextField(
                  lang: FieldLang.en,
                  type: FieldType.description,
                ),
                CategoryTextField(
                  lang: FieldLang.ar,
                  type: FieldType.description,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
