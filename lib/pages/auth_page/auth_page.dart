import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_appbar.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/create_new_user/components/_w_appuser_textfield.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';
import 'package:single_vendor_admin_panel/providers/px_localization.dart';
import 'package:single_vendor_admin_panel/routes/routes.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(
        leading: SizedBox(),
        title: Text('Authentication Page'),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //todo: username
          const AppUserTextField(
            usage: Usage.email,
          ),
          //todo: password
          const AppUserTextField(
            usage: Usage.password,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await EasyLoading.show(status: "LOADING...");
                      if (context.mounted) {
                        await context.read<PxAppUsers>().createEmailSession();
                      }
                      await EasyLoading.dismiss();
                      if (context.mounted) {
                        showInfoSnackbar(context, "Session Created...");
                        GoRouter.of(context).goNamed(
                            PageDir.control_panel_main.name,
                            pathParameters: {
                              "lang": context
                                  .read<PxLocalization>()
                                  .locale
                                  .languageCode,
                            });
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
                  child: const Text("Authenticate"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await EasyLoading.show(status: "LOADING...");
                      if (context.mounted) {
                        await context
                            .read<PxAppUsers>()
                            .createAnonymousSession();
                      }
                      await EasyLoading.dismiss();
                      if (context.mounted) {
                        showInfoSnackbar(context, "Session Created...");
                        GoRouter.of(context).goNamed(
                            PageDir.control_panel_main.name,
                            pathParameters: {
                              "lang": context
                                  .read<PxLocalization>()
                                  .locale
                                  .languageCode,
                            });
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
                  child: const Text("Anonymous Session"),
                ),
              ),
            ],
          ),
          //todo: move this page in admin and hr routes only
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await EasyLoading.show(status: "LOADING...");
                      if (context.mounted) {
                        await context.read<PxAppUsers>().clearLoginSessions();
                      }
                      await EasyLoading.dismiss();
                      if (context.mounted) {
                        showInfoSnackbar(context, "Sessions Cleared...");
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
                  child: const Text("Clear Sessions"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
