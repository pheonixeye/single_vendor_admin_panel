import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_features.dart';

class FeatureSpecialValueTypeDropdown extends StatelessWidget {
  const FeatureSpecialValueTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxProductFeatures>(
            builder: (context, f, c) {
              return DropdownButton<SpecialValueType>(
                alignment: Alignment.center,
                items: SpecialValueType.values.map((e) {
                  return DropdownMenuItem<SpecialValueType>(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(e.name),
                  );
                }).toList(),
                isExpanded: true,
                dropdownColor: Colors.white,
                onChanged: (val) {
                  if (val == SpecialValueType.none) {
                    showInfoSnackbar(
                      context,
                      "Cannot Select 'none' as a Special Value...",
                      Colors.red,
                    );
                  } else {
                    f.setOrUpdateFeature(
                      specialValueType: val,
                    );
                  }
                },
                value: f.productFeature.specialValueType,
              );
            },
          ),
        ),
      ),
    );
  }
}
