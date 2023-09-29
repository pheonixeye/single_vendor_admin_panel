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
              _boldyEvent(log.event),
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

SelectableText _boldyEvent(String data) {
  Color? color1;
  Color? color2;

  if (data.contains("session")) {
    color2 = Colors.deepPurple;
    if (data.contains("create")) {
      color1 = Colors.green;
    } else if (data.contains("delete")) {
      color1 = Colors.red;
    }
  }
  if (data.contains("document")) {
    color2 = Colors.teal;
    if (data.contains("create")) {
      color1 = Colors.blue;
    } else if (data.contains("delete")) {
      color1 = Colors.red;
    } else if (data.contains("update")) {
      color1 = Colors.orange;
    }
  }
  final List<String> items = data.split('.');
  return SelectableText.rich(
    TextSpan(
      text: items[0],
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: color2,
      ),
      children: [
        const TextSpan(text: "."),
        TextSpan(
          text: items[1],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color1,
          ),
        ),
      ],
    ),
  );
}

_boldy(String data) {
  return SelectableText(
    data,
    style: const TextStyle(fontWeight: FontWeight.bold),
  );
}
