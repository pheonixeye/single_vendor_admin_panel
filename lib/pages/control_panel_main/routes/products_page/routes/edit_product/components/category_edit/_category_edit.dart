import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/providers/cat_to_prods/px_cat_to_prods.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';

class CategoryEditComponent extends StatefulWidget {
  const CategoryEditComponent({super.key});

  @override
  State<CategoryEditComponent> createState() => _CategoryEditComponentState();
}

class _CategoryEditComponentState extends State<CategoryEditComponent>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxCategoryToProducts>().listCTP();
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
                  title: const Text('Edit Category'),
                  tileColor: Colors.amber.shade200,
                ),
                Expanded(
                  child: Consumer<PxCategoryToProducts>(
                    builder: (context, ctp, c) {
                      while (ctp.ctpList.isEmpty) {
                        return const Center(
                          child: Card(
                            child: Center(
                              child: Text('No Categories Found...'),
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                        itemCount: ctp.ctpList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 100,
                        ),
                        itemBuilder: (context, index) {
                          final cat = ctp.ctpList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CheckboxListTile(
                                  title: Text('${cat.nameEn} | ${cat.nameAr}'),
                                  onChanged: (value) async {
                                    ctp.selectCTP(cat);
                                    final prod = context
                                        .read<PxProduct>()
                                        .product
                                        .productId;
                                    bool isIncluded = cat.products.contains(
                                        context
                                            .read<PxProduct>()
                                            .product
                                            .productId);
                                    await shellFunction(
                                      context,
                                      toExecute: () {
                                        isIncluded
                                            ? ctp.removeProduct(prod)
                                            : ctp.addProduct(prod);
                                      },
                                    );
                                  },
                                  value: ctp.ctpList[index].products.contains(
                                      context
                                          .read<PxProduct>()
                                          .product
                                          .productId),
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
