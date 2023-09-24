import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:single_vendor_admin_panel/components/main_appbar.dart';
import 'package:single_vendor_admin_panel/pages/auth_page/routes/create_new_user/components/_w_app_user_role_dropdown.dart';
import 'package:single_vendor_admin_panel/pages/auth_page/routes/create_new_user/components/_w_appuser_textfield.dart';

//TODO: move this page in admin and hr routes only
class CreateNewAppUser extends StatelessWidget {
  const CreateNewAppUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(
        title: Text('Create New User'),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //todo: role
          const AppUserRoleSelectorDropdown(),
          //todo: name
          const AppUserTextField(
            usage: Usage.email,
          ),
          //todo: password
          const AppUserTextField(
            usage: Usage.password,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {},
              child: const Text("Create User"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              child: const Text("Back"),
            ),
          ),
        ],
      ),
    );
  }
}
