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
          title: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              const Text('Event:'),
              _boldy(log.event),
            ],
          ),
          subtitle: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              const Text('User Id:'),
              _boldy(log.userId),
              const Text('Username:'),
              _boldy(log.userName),
              const Text('User Email:'),
              _boldy(log.userEmail),
              const Text('Time:'),
              _boldy(log.time),
            ],
          ),
        ),
      ),
    );
  }
}

SelectableText _boldy(String data) {
  Color? _color;
  switch (data) {
    case "session.create":
      _color = Colors.green;
      break;
    case "session.delete":
      _color = Colors.red;
      break;
    default:
      _color = null;
      break;
  }
  return SelectableText(
    data,
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: _color,
    ),
  );
}
