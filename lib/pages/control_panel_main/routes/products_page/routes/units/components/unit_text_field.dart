import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products.dart';

enum FieldLang {
  en,
  ar,
}

class UnitsTextField extends StatefulWidget {
  const UnitsTextField({super.key, required this.lang});
  final FieldLang lang;
  @override
  State<UnitsTextField> createState() => _UnitsTextFieldState();
}

class _UnitsTextFieldState extends State<UnitsTextField> {
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
                decoration: InputDecoration(
                  hintText:
                      "Enter Unit { ${widget.lang.name.toUpperCase()} } Name",
                  labelText: 'Unit ${widget.lang.name.toUpperCase()}',
                ),
                validator: (value) {
                  if (p.unit.nameAr.isEmpty || p.unit.nameEn.isEmpty) {
                    return 'Empty Fields are not Allowed...';
                  }
                  return null;
                },
                onChanged: (value) {
                  switch (widget.lang) {
                    case FieldLang.en:
                      p.setUnit(en: value);
                      break;
                    case FieldLang.ar:
                      p.setUnit(ar: value);
                      break;
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
