import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';

class DisplayOnlyProductTile extends StatelessWidget {
  const DisplayOnlyProductTile({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            leading: const CircleAvatar(
              child: Text("#"),
            ),
            hoverColor: Colors.amber,
            onTap: () async {},
            title: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Text(product.nameEn),
                const Text(" | "),
                Text(product.nameAr),
              ],
            ),
            subtitle: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Text(product.descriptionEn),
                const Text(" | "),
                Text(product.descriptionAr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
