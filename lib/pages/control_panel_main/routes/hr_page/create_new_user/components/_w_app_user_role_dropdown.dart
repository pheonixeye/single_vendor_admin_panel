import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';

/// Dropdown to configure userRole in AppUserModel
/// All [UserRole]s can be assigned except for [UserRole.unknown]
/// as it's added as an initialization value only.
class AppUserRoleSelectorDropdown extends StatelessWidget {
  const AppUserRoleSelectorDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Consumer<PxAppUsers>(
          builder: (context, u, c) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<UserRole>(
                underline: const SizedBox(),
                hint: const Text("Select User-Role ..."),
                isExpanded: true,
                alignment: Alignment.center,
                items: UserRole.values.map<DropdownMenuItem<UserRole>>((e) {
                  return DropdownMenuItem<UserRole>(
                    value: e,
                    alignment: Alignment.center,
                    child: Text(
                      '${e.name.toUpperCase()}\n${e.description}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                value: u.appUser?.role,
                onChanged: (value) {
                  if (value == UserRole.admin &&
                      u.loggedInAppUser?.role != UserRole.admin) {
                    showInfoSnackbar(
                      context,
                      'Creating an admin account must be created by an already existing admin account... Operation not allowed...',
                      Colors.red,
                    );
                    return;
                  } else {
                    u.setAppUser(
                      role: value,
                    );
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
