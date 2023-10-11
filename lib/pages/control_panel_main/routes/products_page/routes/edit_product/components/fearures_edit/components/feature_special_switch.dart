import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_features.dart';

class FeatureSpecialValueSwitch extends StatelessWidget {
  const FeatureSpecialValueSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxProductFeatures>(
            builder: (context, f, c) {
              return SwitchListTile(
                secondary: const CircleAvatar(
                  child: Text("#"),
                ),
                title: const Text("Has Special Value"),
                value: f.productFeature.hasSpecialValue,
                onChanged: (val) {
                  f.setOrUpdateFeature(
                    hasSpecialValue: val,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
