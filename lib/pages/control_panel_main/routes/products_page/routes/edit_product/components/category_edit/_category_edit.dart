import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/cat_to_prods/px_cat_to_prods.dart';

class CategoryEditComponent extends StatelessWidget {
  const CategoryEditComponent({super.key});

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
                                  onChanged: (value) {},
                                  value: true,
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
