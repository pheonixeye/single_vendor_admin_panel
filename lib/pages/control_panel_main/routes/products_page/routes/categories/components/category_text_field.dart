import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_category.dart';

class CategoryTextField extends StatelessWidget {
  const CategoryTextField({
    super.key,
    required this.lang,
    required this.type,
    this.validator,
  });
  final FieldLang lang;
  final FieldType type;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxProductCategory>(
            builder: (context, cat, c) {
              final selected = cat.category;
              return TextFormField(
                initialValue: switch (type) {
                  FieldType.name => switch (lang) {
                      FieldLang.en => selected.nameEn,
                      FieldLang.ar => selected.nameAr,
                    },
                  FieldType.description => switch (lang) {
                      FieldLang.en => selected.descriptionEn,
                      FieldLang.ar => selected.descriptionAr,
                    },
                },
                decoration: InputDecoration(
                  hintText:
                      "Enter Category { ${lang.name.toUpperCase()} } { ${type.name.toUpperCase()} }",
                  labelText:
                      'Category { ${type.name.toUpperCase()} } ${lang.name.toUpperCase()}',
                ),
                validator: validator,
                onChanged: (value) {
                  switch (lang) {
                    case FieldLang.en:
                      switch (type) {
                        case FieldType.name:
                          cat.setOrUpdateCategory(
                            nameEn: value,
                          );
                          break;
                        case FieldType.description:
                          cat.setOrUpdateCategory(
                            descriptionEn: value,
                          );
                          break;
                      }
                      break;
                    case FieldLang.ar:
                      switch (type) {
                        case FieldType.name:
                          cat.setOrUpdateCategory(
                            nameAr: value,
                          );
                          break;
                        case FieldType.description:
                          cat.setOrUpdateCategory(
                            descriptionAr: value,
                          );
                          break;
                      }
                      break;
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
