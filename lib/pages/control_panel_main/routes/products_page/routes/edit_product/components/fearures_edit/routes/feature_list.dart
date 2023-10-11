import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_features.dart';

class FeatureListPage extends StatefulWidget {
  const FeatureListPage({super.key});

  @override
  State<FeatureListPage> createState() => _FeatureListPageState();
}

class _FeatureListPageState extends State<FeatureListPage>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxProductFeatures>().listFeatures(
          context.read<PxProduct>().product.productId,
        );
    if (mounted) {
      print(
          'Listed Features of product { ${context.read<PxProduct>().product.nameEn} }');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Edit / Delete Feature'),
                  tileColor: Colors.brown.shade200,
                ),
                Expanded(
                  child: Consumer<PxProductFeatures>(
                    builder: (context, f, c) {
                      while (f.features.isEmpty) {
                        return const Center(
                          child: Center(
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("No Features Found..."),
                              ),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: f.features.length,
                        itemBuilder: (context, index) {
                          final feat = f.features[index];
                          return ExpansionTile(
                            //TODO: build editing menu - resort / delete only
                            leading: CircleAvatar(
                              child: Text(feat.sort.toString()),
                            ),
                            title: Text('${feat.nameEn} | ${feat.nameAr}'),
                            subtitle: Text(feat.id!),
                            initiallyExpanded: false,
                            maintainState: false,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
