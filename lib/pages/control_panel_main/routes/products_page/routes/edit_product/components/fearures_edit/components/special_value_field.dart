import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_features.dart';

class SpecialValueTextField extends StatelessWidget {
  const SpecialValueTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxProductFeatures>(
            builder: (context, f, c) {
              return TextFormField(
                decoration: InputDecoration(
                  hintText:
                      "Enter Feature { Special Value } ${f.productFeature.specialValueType.name}",
                  labelText: 'Feature { Special Value }',
                ),
                onChanged: (value) {
                  switch (f.productFeature.specialValueType) {
                    case SpecialValueType.int:
                      f.setOrUpdateFeature(
                        specialValueInt: int.tryParse(value),
                      );
                    case SpecialValueType.bool:
                      f.setOrUpdateFeature(
                        specialValueBool:
                            bool.tryParse(value, caseSensitive: false),
                      );
                    case SpecialValueType.double:
                      f.setOrUpdateFeature(
                        specialValueDouble: double.tryParse(value),
                      );
                    case SpecialValueType.none:
                    default:
                      return;
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
