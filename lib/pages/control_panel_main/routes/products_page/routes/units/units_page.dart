import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/units/components/unit_text_field.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/units/components/unit_tile.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products_unit.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({super.key});

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  final formKey = GlobalKey<FormState>();
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
                ListTile(
                  title: const Text("Create Product Units"),
                  tileColor: Colors.amber.shade200,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            UnitsTextField(
                              lang: FieldLang.en,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Empty Fields are not Allowed...";
                                }
                                return null;
                              },
                            ),
                            UnitsTextField(
                              lang: FieldLang.ar,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Empty Fields are not Allowed...";
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  try {
                                    await EasyLoading.show(
                                        status: "LOADING...");
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
                ),
                ListTile(
                  title: const Text("Edit Product Units"),
                  tileColor: Colors.amber.shade200,
                  trailing: FloatingActionButton(
                    mini: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    heroTag: 'refresh-unit-items',
                    onPressed: () async {
                      try {
                        await EasyLoading.show(status: "LOADING...");
                        if (mounted) {
                          await context
                              .read<PxProductUnit>()
                              .fetchProductUnitList();
                        }
                        await EasyLoading.dismiss();
                        if (mounted) {
                          showInfoSnackbar(
                              context, 'Refreshed Product Units...');
                        }
                      } catch (e) {
                        await EasyLoading.dismiss();
                        if (mounted) {
                          showInfoSnackbar(
                            context,
                            e.toString(),
                            Colors.red,
                          );
                        }
                      }
                    },
                    child: const Icon(Icons.refresh),
                  ),
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
                              return UnitTile(
                                unit: unit,
                                index: index,
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
