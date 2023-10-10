import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/display_product_consumer.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/fearures_edit/components/feature_field.dart';

class FeaturesEditComponent extends StatefulWidget {
  const FeaturesEditComponent({super.key});

  @override
  State<FeaturesEditComponent> createState() => _FeaturesEditComponentState();
}

class _FeaturesEditComponentState extends State<FeaturesEditComponent> {
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
                    title: const Text('Edit Features'),
                    tileColor: Colors.brown.shade200,
                  ),
                  const DisplayProductConsumerTile(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
