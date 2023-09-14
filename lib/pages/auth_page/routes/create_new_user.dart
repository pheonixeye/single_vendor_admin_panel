import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:single_vendor_admin_panel/components/main_appbar.dart';
import 'package:single_vendor_admin_panel/pages/auth_page/routes/components/_w_app_user_role_dropdown_create_new_user.dart';

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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //todo: role
          const AppUserRoleSelectorDropdown(),
          //TODO: user
          //TODO: password
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
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
