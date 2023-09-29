import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/create_new_user/components/_w_app_user_role_dropdown.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/create_new_user/components/_w_appuser_textfield.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';

//todo: move this page in admin and hr routes only
class CreateNewAppUser extends StatelessWidget {
  const CreateNewAppUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                const ListTile(
                  title: Text("Create New User"),
                ),
                const AppUserTextField(
                  usage: Usage.name,
                ),
                const AppUserTextField(
                  usage: Usage.email,
                ),
                //todo: password
                const AppUserTextField(
                  usage: Usage.password,
                ),
                //todo: role
                const AppUserRoleSelectorDropdown(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await EasyLoading.show(status: "LOADING...");
                        if (context.mounted) {
                          await context.read<PxAppUsers>().createAppUser();
                        }
                        await EasyLoading.dismiss();
                        if (context.mounted) {
                          showInfoSnackbar(
                            context,
                            'User Created...',
                            Colors.green,
                          );
                        }
                      } catch (e) {
                        await EasyLoading.dismiss();
                        if (context.mounted) {
                          showInfoSnackbar(context, e.toString(), Colors.red);
                        }
                      }
                    },
                    child: const Text("Create User"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
