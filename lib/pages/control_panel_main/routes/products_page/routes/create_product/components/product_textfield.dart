import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';

class ProductTextField extends StatelessWidget {
  const ProductTextField({
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
          child: Consumer<PxProduct>(
            builder: (context, p, c) {
              final selected = p.product;
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
                      "Enter Product { ${lang.name.toUpperCase()} } { ${type.name.toUpperCase()} }",
                  labelText:
                      'Product { ${type.name.toUpperCase()} } ${lang.name.toUpperCase()}',
                ),
                validator: validator,
                onChanged: (value) {
                  switch (lang) {
                    case FieldLang.en:
                      switch (type) {
                        case FieldType.name:
                          p.setOrUpdateProduct(
                            nameEn: value,
                          );
                          break;
                        case FieldType.description:
                          p.setOrUpdateProduct(
                            descriptionEn: value,
                          );
                          break;
                      }
                      break;
                    case FieldLang.ar:
                      switch (type) {
                        case FieldType.name:
                          p.setOrUpdateProduct(
                            nameAr: value,
                          );
                          break;
                        case FieldType.description:
                          p.setOrUpdateProduct(
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
