import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
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
    // if (mounted) {
    //   print(
    //       'Listed Features of product { ${context.read<PxProduct>().product.nameEn} }');
    // }
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
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpansionTile(
                                  //todo: build editing menu - resort / delete only
                                  leading: CircleAvatar(
                                    child: Text(feat.sort.toString()),
                                  ),
                                  title:
                                      Text('${feat.nameEn} | ${feat.nameAr}'),
                                  initiallyExpanded: false,
                                  maintainState: false,
                                  children: [
                                    ...feat.toJson().entries.map((e) {
                                      if (e.key == 'sort') {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            leading: CircleAvatar(
                                              child: Text(feat.sort.toString()),
                                            ),
                                            title: Row(
                                              children: [
                                                const Text("Sort #"),
                                                const Spacer(),
                                                FloatingActionButton.small(
                                                  heroTag: 'dec-sort-server',
                                                  onPressed: () async {
                                                    f.selectFeature(feat);
                                                    f.setOrUpdateFeature(
                                                      sort: f.productFeature
                                                              .sort -
                                                          1,
                                                    );
                                                    await shellFunction(context,
                                                        toExecute: () async {
                                                      await f.updateFeature();
                                                      await f.listFeatures(
                                                          feat.productId);
                                                    }).then(
                                                        (_) => f.initFeature());
                                                  },
                                                  child: const Text('-'),
                                                ),
                                                const SizedBox(width: 20),
                                                Text(feat.sort.toString()),
                                                const SizedBox(width: 20),
                                                FloatingActionButton.small(
                                                  heroTag: 'inc-sort-server',
                                                  onPressed: () async {
                                                    f.selectFeature(feat);
                                                    f.setOrUpdateFeature(
                                                      sort: f.productFeature
                                                              .sort +
                                                          1,
                                                    );
                                                    await shellFunction(
                                                      context,
                                                      toExecute: () async {
                                                        await f.updateFeature();
                                                        await f.listFeatures(
                                                            feat.productId);
                                                      },
                                                    ).then(
                                                        (_) => f.initFeature());
                                                  },
                                                  child: const Text('+'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Text(e.key),
                                          subtitle: Text(e.value.toString()),
                                        ),
                                      );
                                    }).toList(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          f.selectFeature(feat);
                                          await shellFunction(
                                            context,
                                            toExecute: () async {
                                              await f.deleteFeature();
                                              await f
                                                  .listFeatures(feat.productId);
                                            },
                                          ).then((_) => f.initFeature());
                                        },
                                        icon: const Icon(Icons.delete),
                                        label: const Text("Delete Feature"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
