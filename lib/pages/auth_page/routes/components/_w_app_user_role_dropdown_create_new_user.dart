import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';

class AppUserRoleSelectorDropdown extends StatelessWidget {
  const AppUserRoleSelectorDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: DropdownButton<UserRole>(
          hint: const Text("Select User-Role ..."),
          isExpanded: true,
          alignment: Alignment.center,
          items: UserRole.values.map<DropdownMenuItem<UserRole>>((e) {
            return DropdownMenuItem<UserRole>(
              value: e,
              alignment: Alignment.center,
              child: Text(
                e.name,
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
          onChanged: (value) {},
          // value: context.watch<PxServerStatus>().server,
        ),
      ),
    );
  }
}
