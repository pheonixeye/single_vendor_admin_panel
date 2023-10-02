import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/categories/components/cat_edit_dialog.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_category.dart';

class EditCategoryPage extends StatefulWidget {
  const EditCategoryPage({super.key});

  @override
  State<EditCategoryPage> createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage>
    with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxProductCategory>().listProductCategories();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Edit / Delete Category'),
                  tileColor: Colors.amber.shade200,
                  trailing: FloatingActionButton(
                    mini: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    heroTag: 'refresh-category-items',
                    onPressed: () async {
                      await shellFunction(
                        context,
                        toExecute: context
                            .read<PxProductCategory>()
                            .listProductCategories,
                      );
                    },
                    child: const Icon(Icons.refresh),
                  ),
                ),
                Expanded(
                  child: Consumer<PxProductCategory>(
                    builder: (context, cat, c) {
                      while (cat.categories.isEmpty) {
                        return const Center(
                          child: Text("No Categories Found..."),
                        );
                      }
                      final list = cat.categories;
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (contex, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  leading: CircleAvatar(
                                    child: Text((index + 1).toString()),
                                  ),
                                  hoverColor: Colors.amber,
                                  onTap: () async {
                                    //todo: edit category
                                    context
                                        .read<PxProductCategory>()
                                        .selectCategory(list[index]);
                                    await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const CategoryEditDialog();
                                        });
                                  },
                                  title: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      Text(list[index].nameEn),
                                      const Text(" | "),
                                      Text(list[index].nameAr),
                                    ],
                                  ),
                                  subtitle: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      Text(list[index].descriptionEn),
                                      const Text(" | "),
                                      Text(list[index].descriptionAr),
                                    ],
                                  ),
                                  trailing: FloatingActionButton(
                                    heroTag: list[index].categoryId,
                                    onPressed: () async {
                                      //todo: delete category
                                      await shellFunction(
                                        context,
                                        toExecute: () => context
                                            .read<PxProductCategory>()
                                            .deleteProductCategory(
                                                list[index].categoryId),
                                      );
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
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
