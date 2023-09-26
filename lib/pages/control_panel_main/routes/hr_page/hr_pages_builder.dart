import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/create_new_user/create_new_user.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/edit_user/edit_user_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/user_logs/user_logs_page.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/user_salaries/user_salaries_page.dart';

enum HRPageReference {
  createUser(
    name: "Create User",
    icon: Icons.person_3,
    page: CreateNewAppUser(),
  ),
  editUser(
    name: "Edit User",
    icon: Icons.edit,
    page: EditUserPage(),
  ),
  userLogs(
    name: "User Logs",
    icon: Icons.file_copy,
    page: UserLogsPage(),
  ),
  userSalaries(
    name: "User Salaries",
    icon: Icons.money,
    page: UserSalariesPage(),
  );

  final Widget page;
  final String name;
  final IconData icon;

  const HRPageReference({
    required this.name,
    required this.page,
    required this.icon,
  });
}
