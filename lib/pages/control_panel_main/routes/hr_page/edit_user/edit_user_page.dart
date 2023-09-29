import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/api/appusers/hx_appusers.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    await context.read<PxAppUsers>().fetchAllAppUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Text("AppUsers List :"),
                ),
                Consumer<PxAppUsers>(
                  builder: (context, u, c) {
                    while (u.appUserList == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: u.appUserList?.users.length,
                        itemBuilder: (context, index) {
                          final AppUser? usr = u.appUserList?.users[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ExpansionTile(
                                  leading: CircleAvatar(
                                    child: Text("${index + 1}"),
                                  ),
                                  title: Text(usr!.name),
                                  subtitle: Wrap(
                                    children: [
                                      Text(usr.email),
                                      const SizedBox(width: 10, height: 10),
                                      Text(
                                        usr.status
                                            ? "(Activate)"
                                            : "(Inactivate)",
                                        style: TextStyle(
                                          color: usr.status
                                              ? Colors.green
                                              : Colors.purple,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    ...UserRole.values.map((e) {
                                      return CheckboxListTile(
                                        isThreeLine: true,
                                        title: Text(e.name),
                                        subtitle: Wrap(
                                          children: [
                                            Text(e.description),
                                            const SizedBox(
                                                width: 10, height: 10),
                                            if (e.name == usr.role.name)
                                              const Text(
                                                '(Primary Role)',
                                                style: TextStyle(
                                                    color: Colors.purple,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                          ],
                                        ),
                                        value: (e.name == usr.role.name ||
                                            usr.otherRoles.contains(
                                                UserRole.fromString(e.name))),
                                        onChanged: (val) async {
                                          try {
                                            if (e.name == usr.role.name) {
                                              showInfoSnackbar(context,
                                                  "Cannot Modify Primary Role of an Account...");
                                              return;
                                            }
                                            if (e == UserRole.admin &&
                                                u.loggedInAppUser?.role !=
                                                    UserRole.admin) {
                                              showInfoSnackbar(context,
                                                  "Cannot Add Admin Privilages From an Account With Lower Authorization...");
                                              return;
                                            }
                                            if (e == UserRole.unknown) {
                                              showInfoSnackbar(context,
                                                  "Unselectable Field...");
                                              return;
                                            }

                                            final bool toRemove = usr.otherRoles
                                                .contains(UserRole.fromString(
                                                    e.name));
                                            final newUser = usr.copyWith(
                                              otherRoles: toRemove
                                                  ? [
                                                      ...usr.otherRoles
                                                        ..remove(
                                                            UserRole.fromString(
                                                                e.name))
                                                    ]
                                                  : [
                                                      ...usr.otherRoles,
                                                      UserRole.fromString(
                                                          e.name)
                                                    ],
                                            );
                                            await EasyLoading.show(
                                                status: "LOADING...");
                                            await u.updateAppUser(
                                                newUser, UserUpdate.roles);
                                            await EasyLoading.dismiss();
                                            if (mounted) {
                                              showInfoSnackbar(
                                                  context, 'User Updated...');
                                            }
                                          } catch (e) {
                                            await EasyLoading.dismiss();
                                            if (mounted) {
                                              showInfoSnackbar(context,
                                                  e.toString(), Colors.red);
                                            }
                                          }
                                        },
                                      );
                                    }).toList(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                if (usr.role ==
                                                    UserRole.admin) {
                                                  showInfoSnackbar(context,
                                                      "Cannot Modify Activity of an Admin Account...");
                                                  return;
                                                }
                                                await EasyLoading.show(
                                                    status: "LOADING...");
                                                await u.updateAppUser(
                                                    usr, UserUpdate.activity);
                                                await EasyLoading.dismiss();
                                                if (mounted) {
                                                  showInfoSnackbar(context,
                                                      'User Activity Updated...');
                                                }
                                              } catch (e) {
                                                await EasyLoading.dismiss();
                                                if (mounted) {
                                                  showInfoSnackbar(context,
                                                      e.toString(), Colors.red);
                                                }
                                              }
                                            },
                                            child: Text(usr.status
                                                ? "Deactivate"
                                                : "Activate"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                if (usr.role ==
                                                        UserRole.admin &&
                                                    u.loggedInAppUser?.role !=
                                                        UserRole.admin) {
                                                  showInfoSnackbar(context,
                                                      "Cannot Delete an Admin Account From An Account With Lower Authorization...");
                                                  return;
                                                }
                                                await EasyLoading.show(
                                                    status: "LOADING...");
                                                await u.deleteUser(usr);
                                                await EasyLoading.dismiss();
                                                if (mounted) {
                                                  showInfoSnackbar(context,
                                                      'User Deleted...');
                                                }
                                              } catch (e) {
                                                await EasyLoading.dismiss();
                                                if (mounted) {
                                                  showInfoSnackbar(context,
                                                      e.toString(), Colors.red);
                                                }
                                              }
                                            },
                                            child: const Text("Delete Account"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
