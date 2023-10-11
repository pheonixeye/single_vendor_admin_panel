import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_features.dart';

class FeatureSortCounter extends StatelessWidget {
  const FeatureSortCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxProductFeatures>(
            builder: (context, f, c) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Text("#"),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sort #"),
                    const Spacer(),
                    FloatingActionButton.small(
                      heroTag: 'dec-sort',
                      onPressed: () {
                        f.setOrUpdateFeature(
                          sort: f.productFeature.sort - 1,
                        );
                      },
                      child: const Text('-'),
                    ),
                    const SizedBox(width: 20),
                    Text(f.productFeature.sort.toString()),
                    const SizedBox(width: 20),
                    FloatingActionButton.small(
                      heroTag: 'inc-sort',
                      onPressed: () {
                        f.setOrUpdateFeature(
                          sort: f.productFeature.sort + 1,
                        );
                      },
                      child: const Text('+'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
