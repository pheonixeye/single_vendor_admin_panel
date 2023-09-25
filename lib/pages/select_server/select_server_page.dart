import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/pages/select_server/components/select_server_dropdown.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/providers/px_server_status_px.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';

class SelectServerPage extends StatelessWidget {
  const SelectServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Consumer<PxServerStatus>(
              builder: (context, s, c) {
                return Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 20),
                        Text(s.server == null ? "Unselected" : s.server!.name),
                        const SizedBox(width: 20),
                        Icon(
                          s.status == null ? Icons.info : Icons.check,
                          color: (s.status == null || s.status != "pass")
                              ? Colors.yellow
                              : Colors.green,
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: SelectServerDropdown(),
          ),
          ElevatedButton(
            child: const Text("Connect To Server"),
            onPressed: () async {
              late final String? response;
              try {
                await EasyLoading.show(status: "LOADING...")
                    .then((value) async {
                  response = await context
                      .read<PxServerStatus>()
                      .checkSelectedServerStatus();
                }).then((value) async {
                  await EasyLoading.dismiss();
                }).then((value) async {
                  showInfoSnackbar(context, response ?? "_", Colors.green);
                }).then((_) async {
                  await Future.delayed(const Duration(seconds: 1))
                      .then((value) {
                    GoRouter.of(context).goNamed(
                      PageDir.auth_page.name,
                      pathParameters: {
                        'lang':
                            context.read<PxLocalization>().locale.languageCode,
                      },
                    );
                  });
                });
              } catch (e) {
                await EasyLoading.dismiss().then((_) {
                  showInfoSnackbar(context, e.toString(), Colors.red);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
