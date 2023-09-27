import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/models/app_user_log_model.dart';

class LogViewItem extends StatelessWidget {
  const LogViewItem({super.key, required this.log, required this.index});
  final AppUserLog log;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Text((index + 1).toString()),
          ),
          title: Text(log.event),
          subtitle: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              Text(log.userId),
              Text(log.userEmail),
              Text(log.clientCode),
              Text(log.userName),
              Text(log.time),
            ],
          ),
        ),
      ),
    );
  }
}
