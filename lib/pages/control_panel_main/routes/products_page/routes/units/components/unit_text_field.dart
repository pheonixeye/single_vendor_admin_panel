import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products_unit.dart';

enum FieldOperation {
  set,
  update,
}

class UnitsTextField extends StatelessWidget {
  const UnitsTextField({
    super.key,
    required this.lang,
    this.validator,
    this.operation = FieldOperation.set,
  });
  final FieldOperation operation;
  final FieldLang lang;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxProductUnit>(
            builder: (context, p, c) {
              return TextFormField(
                initialValue: switch (lang) {
                  FieldLang.en => p.unit.nameEn,
                  FieldLang.ar => p.unit.nameAr,
                },
                decoration: InputDecoration(
                  hintText: "Enter Unit { ${lang.name.toUpperCase()} } Name",
                  labelText: 'Unit ${lang.name.toUpperCase()}',
                ),
                validator: validator,
                onChanged: (value) {
                  switch (operation) {
                    case FieldOperation.set:
                      switch (lang) {
                        case FieldLang.en:
                          p.setUnit(en: value);
                          break;
                        case FieldLang.ar:
                          p.setUnit(ar: value);
                          break;
                      }
                    case FieldOperation.update:
                      switch (lang) {
                        case FieldLang.en:
                          p.updateUnit(
                            en: value,
                          );
                          break;
                        case FieldLang.ar:
                          p.updateUnit(
                            ar: value,
                          );

                          break;
                      }
                  }

                  // print(p.unit.toJson());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
