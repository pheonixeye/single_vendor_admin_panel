import 'package:flutter/material.dart';

SnackBar iInfoSnackbar(String message, BuildContext context, [Color? color]) {
  return SnackBar(
    padding: const EdgeInsets.all(8.0),
    margin: const EdgeInsets.all(8.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    behavior: SnackBarBehavior.floating,
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(message),
          const SizedBox(
            width: 20,
          ),
          Icon(
            Icons.info,
            color: color ?? Theme.of(context).primaryColor,
          ),
        ],
      ),
    ),
  );
}

void showInfoSnackbar(BuildContext context, String message, [Color? color]) {
  if (context.mounted) {
    ScaffoldMessenger.maybeOf(context)
        ?.showSnackBar(iInfoSnackbar(message, context, color));
  }
}
