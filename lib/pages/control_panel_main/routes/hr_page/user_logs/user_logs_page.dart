import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/components/main_snackbar.dart';
import 'package:single_vendor_admin_panel/models/app_user_model.dart';
import 'package:single_vendor_admin_panel/pages/control_panel_main/routes/hr_page/user_logs/components/log_view_item.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';

class UserLogsPage extends StatefulWidget {
  const UserLogsPage({super.key});

  @override
  State<UserLogsPage> createState() => _UserLogsPageState();
}

class _UserLogsPageState extends State<UserLogsPage> with AfterLayoutMixin {
  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    if (context.read<PxAppUsers>().appUserList == null) {
      await context.read<PxAppUsers>().fetchAllAppUsers();
    } else {
      return;
    }
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
                  title: Text('User Logs :'),
                ),
                RawAutocomplete<AppUser>(
                  displayStringForOption: (option) {
                    return option.email;
                  },
                  optionsViewBuilder: (
                    BuildContext context,
                    void Function(AppUser) onSelected,
                    Iterable<AppUser> options,
                  ) {
                    return Material(
                      child: SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          child: Column(
                            children: options.map((opt) {
                              return InkWell(
                                onTap: () {
                                  onSelected(opt);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(right: 60),
                                  child: Card(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      child: Text(opt.email),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  },
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return context.read<PxAppUsers>().appUserList!.users;
                    }
                    return context
                        .read<PxAppUsers>()
                        .appUserList!
                        .users
                        .where((element) {
                      return element.email
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (AppUser selection) async {
                    context.read<PxAppUsers>().setForLogAppUser(selection);
                    await _fetchLogs(context, selection);
                    if (mounted) {
                      context.read<PxAppUsers>().setForLogAppUser(null);
                    }
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController textEditingController,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onSubmitted: (val) {
                              onFieldSubmitted();
                            },
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                              labelText: "Search by E-mail or Phone Number...",
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Consumer<PxAppUsers>(
                    builder: (context, l, c) {
                      while (l.logData == null) {
                        return const Center(
                          child: Text("No User Selected..."),
                        );
                      }
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: l.logData?.logs.length,
                            itemBuilder: (context, index) {
                              return LogViewItem(
                                index: index,
                                log: l.logData!.logs[index],
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchLogs(
    BuildContext context,
    AppUser selection,
  ) async {
    try {
      await EasyLoading.show(status: "LOADING...");
      if (mounted) {
        await context.read<PxAppUsers>().fetchAppUserLogData();
      }
      await EasyLoading.dismiss();
      if (mounted) {
        showInfoSnackbar(
            context, "User ${selection.email} Log Data Available...");
      }
    } catch (e) {
      await EasyLoading.dismiss();

      if (mounted) {
        showInfoSnackbar(context, e.toString(), Colors.red);
      }
    }
  }
}
