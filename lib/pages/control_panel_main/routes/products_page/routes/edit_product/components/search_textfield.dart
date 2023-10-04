import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/text_field_enums.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_list.dart';

class ProductSearchTextField extends StatefulWidget {
  const ProductSearchTextField({super.key});

  @override
  State<ProductSearchTextField> createState() => _ProductSearchTextFieldState();
}

class _ProductSearchTextFieldState extends State<ProductSearchTextField> {
  final controller = TextEditingController();

  FieldLang? lang = FieldLang.en;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) {
              return TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search Product By Name...",
                  labelText: "Product Name",
                  prefix: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<FieldLang>(
                      elevation: 0,
                      isDense: true,
                      items: FieldLang.values.map((e) {
                        return DropdownMenuItem<FieldLang>(
                          alignment: Alignment.center,
                          value: e,
                          child: Text(e.name),
                        );
                      }).toList(),
                      dropdownColor: Colors.white,
                      onChanged: (val) {
                        setState(() {
                          lang = val;
                        });
                      },
                      value: lang,
                    ),
                  ),
                  suffix: FloatingActionButton.small(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    heroTag: 'src-product-filter-btn',
                    child: const Icon(Icons.search),
                    onPressed: () async {
                      await shellFunction(context, toExecute: () {
                        context
                            .read<PxProductList>()
                            .filterProducts(controller.text, lang!);
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
