import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/functions/shell_function.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/edit_product/components/display_product_tile.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product.dart';
import 'package:single_vendor_admin_panel/providers/products/px_product_price.dart';

class PriceEditComponent extends StatefulWidget {
  const PriceEditComponent({super.key});

  @override
  State<PriceEditComponent> createState() => _PriceEditComponentState();
}

class _PriceEditComponentState extends State<PriceEditComponent> {
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _discountController.dispose();
    _priceController.dispose();
    super.dispose();
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
                    title: const Text('Edit Price'),
                    tileColor: Colors.blue.shade200,
                  ),
                  Consumer<PxProduct>(
                    builder: (context, p, c) {
                      while (p.product == Product.initial()) {
                        return const Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('No Product Selected...'),
                              ),
                            ),
                          ),
                        );
                      }
                      final product = p.product;
                      return DisplayOnlyProductTile(product: product);
                    },
                  ),
                  Consumer<PxProductPrice>(
                    builder: (context, p, c) {
                      if (p.price != ProductPrice.initial()) {
                        _discountController.text = '${p.price.discount}';
                        _priceController.text = '${p.price.price}';
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Text("#"),
                              ),
                              title: const Text('Price'),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _priceController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Empty Price Fields are not Allowed...';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Text("%"),
                              ),
                              title: const Text('Discount %'),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _discountController,
                                ),
                              ),
                            ),
                          ),
                          if (p.price.price == 0.0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  p.setOrUpdatePrice(
                                    productId: context
                                        .read<PxProduct>()
                                        .product
                                        .productId,
                                    price:
                                        double.tryParse(_priceController.text),
                                    discount: double.tryParse(
                                        _discountController.text),
                                  );

                                  await shellFunction(
                                    context,
                                    toExecute: p.createPrice,
                                  );
                                },
                                icon: const Icon(Icons.save),
                                label: const Text("Create"),
                              ),
                            ),
                          if (p.price.price != 0.0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }
                                  p.setOrUpdatePrice(
                                    productId: context
                                        .read<PxProduct>()
                                        .product
                                        .productId,
                                    price:
                                        double.tryParse(_priceController.text),
                                    discount: double.tryParse(
                                        _discountController.text),
                                  );

                                  await shellFunction(
                                    context,
                                    toExecute: p.updatePrice,
                                  );
                                },
                                icon: const Icon(Icons.save),
                                label: const Text("Update"),
                              ),
                            ),
                        ],
                      );
                    },
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
