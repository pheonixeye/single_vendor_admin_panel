import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';

///Shell function encapsulating loading & error handling logic in the UI
Future<void> shellFunction(
  BuildContext context, {
  required Function toExecute,
  String sucessMsg = "Success...",
}) async {
  try {
    await EasyLoading.show(status: "LOADING...");
    await toExecute();
    await EasyLoading.dismiss();
    if (context.mounted) {
      showInfoSnackbar(context, sucessMsg);
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
}
