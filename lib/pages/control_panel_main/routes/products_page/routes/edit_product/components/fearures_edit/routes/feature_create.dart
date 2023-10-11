import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/fearures_edit/components/feature_field.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/fearures_edit/components/feature_sort_counter.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/fearures_edit/components/feature_sp_val_type_dropdown.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/fearures_edit/components/feature_special_switch.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/fearures_edit/components/special_value_field.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_features.dart';

class FeatureCreatePage extends StatefulWidget {
  const FeatureCreatePage({super.key});

  @override
  State<FeatureCreatePage> createState() => _FeatureCreatePageState();
}

class _FeatureCreatePageState extends State<FeatureCreatePage> {
  final formKey = GlobalKey<FormState>();
  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Empty Fields are not Allowed...";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Create Feature'),
                    tileColor: Colors.brown.shade200,
                  ),
                  ProductFeatureTextField(
                    lang: FieldLang.en,
                    type: FieldType.name,
                    validator: _validator,
                  ),
                  ProductFeatureTextField(
                    lang: FieldLang.ar,
                    type: FieldType.name,
                    validator: _validator,
                  ),
                  ProductFeatureTextField(
                    lang: FieldLang.en,
                    type: FieldType.description,
                    validator: _validator,
                  ),
                  ProductFeatureTextField(
                    lang: FieldLang.ar,
                    type: FieldType.description,
                    validator: _validator,
                  ),
                  const FeatureSortCounter(),
                  const FeatureSpecialValueSwitch(),
                  if (context
                      .watch<PxProductFeatures>()
                      .productFeature
                      .hasSpecialValue) ...[
                    const Row(
                      children: [
                        Expanded(child: FeatureSpecialValueTypeDropdown()),
                        Expanded(child: SpecialValueTextField()),
                      ],
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Consumer<PxProductFeatures>(
                      builder: (context, f, c) {
                        return ElevatedButton.icon(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            if (f.productFeature.hasSpecialValue) {
                              switch (f.productFeature.specialValueType) {
                                case SpecialValueType.int:
                                  f.productFeature.specialValueInt == null
                                      ? () {
                                          showInfoSnackbar(
                                            context,
                                            'Wrong Special Value Parameter...{ eg. 1 / 4 / 56 / ... }',
                                            Colors.red,
                                          );
                                          return;
                                        }
                                      : () {};
                                case SpecialValueType.bool:
                                  f.productFeature.specialValueBool == null
                                      ? () {
                                          showInfoSnackbar(
                                            context,
                                            'Wrong Special Value Parameter...{ eg. 0.5 / 3.4 / 35.8 / ... }',
                                            Colors.red,
                                          );
                                          return;
                                        }
                                      : () {};
                                case SpecialValueType.double:
                                  f.productFeature.specialValueDouble == null
                                      ? () {
                                          showInfoSnackbar(
                                            context,
                                            'Wrong Special Value Parameter...{ eg. true / false }',
                                            Colors.red,
                                          );
                                          return;
                                        }
                                      : () {};
                                case SpecialValueType.none:
                                default:
                                  return;
                              }
                            }
                            if (!f.productFeature.hasSpecialValue) {
                              f.setOrUpdateFeature(
                                specialValueBool: null,
                                specialValueDouble: null,
                                specialValueInt: null,
                                specialValueType: null,
                              );
                            }
                            f.setOrUpdateFeature(
                              id: null,
                              productId:
                                  context.read<PxProduct>().product.productId,
                            );
                            // print('feature from button==>>');
                            // print(f.productFeature.toString());
                            await shellFunction(
                              context,
                              toExecute: f.createFeature,
                              sucessMsg: 'Feature Created...',
                            );
                          },
                          icon: const Icon(Icons.save),
                          label: const Text("Save"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
