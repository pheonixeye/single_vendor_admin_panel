import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/models/product_model.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/products_page/routes/units/components/unit_update_dialog.dart';
import 'package:single_vendor_admin_panel/providers/products/px_products_unit.dart';

class UnitTile extends StatelessWidget {
  const UnitTile({
    super.key,
    required this.unit,
    required this.index,
  });
  final ProductUnit unit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          tileColor: Theme.of(context).canvasColor,
          leading: CircleAvatar(
            backgroundColor: Colors.teal,
            child: Text((index + 1).toString()),
          ),
          hoverColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onTap: () async {
            context.read<PxProductUnit>().selectUnit(unit);
            await showDialog(
              context: context,
              builder: (context) {
                return const UnitEditDialog();
              },
            ).then((_) {
              context.read<PxProductUnit>().emptyUnit();
            });
          },
          title: RichText(
            text: TextSpan(
              text: "EN: ",
              children: [
                TextSpan(
                  text: unit.nameEn,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          subtitle: RichText(
            text: TextSpan(
              text: "AR: ",
              children: [
                TextSpan(
                  text: unit.nameAr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          trailing: FloatingActionButton(
            heroTag: unit.unitId,
            onPressed: () async {
              try {
                await EasyLoading.show(status: "LOADING...");
                if (context.mounted) {
                  await context
                      .read<PxProductUnit>()
                      .removeProductUnit(unit.unitId);
                }
                await EasyLoading.dismiss();
                if (context.mounted) {
                  showInfoSnackbar(context, 'Unit Deleted...');
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
      ),
    );
  }
}
