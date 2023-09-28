import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/units/components/unit_text_field.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products.dart';

class UnitsPage extends StatelessWidget {
  const UnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const ListTile(
                  title: Text("Create Product Units"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const UnitsTextField(
                            lang: FieldLang.en,
                          ),
                          const UnitsTextField(
                            lang: FieldLang.ar,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  await EasyLoading.show(status: "LOADING...");
                                  if (context.mounted) {
                                    await context
                                        .read<PxProductUnit>()
                                        .createProductUnit();
                                  }
                                  await EasyLoading.dismiss();
                                  if (context.mounted) {
                                    showInfoSnackbar(
                                        context, 'Unit Created...');
                                  }
                                } catch (e) {
                                  await EasyLoading.dismiss();
                                  if (context.mounted) {
                                    showInfoSnackbar(
                                      context,
                                      e.toString(),
                                      Colors.red,
                                    );
                                  }
                                }
                              },
                              child: const Text("Save Unit"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  title: Text("Edit Product Units"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Consumer<PxProductUnit>(
                        builder: (context, p, c) {
                          while (p.units.isEmpty) {
                            return const Center(
                              child: Text('No Units Found...'),
                            );
                          }

                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 5,
                            ),
                            shrinkWrap: true,
                            itemCount: p.units.length,
                            itemBuilder: (context, index) {
                              final unit = p.units[index];
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text((index + 1).toString()),
                                  ),
                                  title: Text(unit.nameEn),
                                  subtitle: Text(unit.nameAr),
                                  trailing: FloatingActionButton(
                                    heroTag: unit.unitId,
                                    onPressed: () async {
                                      try {
                                        await EasyLoading.show(
                                            status: "LOADING...");
                                        if (context.mounted) {
                                          await context
                                              .read<PxProductUnit>()
                                              .removeProductUnit(unit.unitId);
                                        }
                                        await EasyLoading.dismiss();
                                        if (context.mounted) {
                                          showInfoSnackbar(
                                              context, 'Unit Deleted...');
                                        }
                                      } catch (e) {
                                        await EasyLoading.dismiss();
                                        if (context.mounted) {
                                          showInfoSnackbar(
                                            context,
                                            e.toString(),
                                            Colors.red,
                                          );
                                        }
                                      }
                                    },
                                    child: const Icon(Icons.delete),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
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
