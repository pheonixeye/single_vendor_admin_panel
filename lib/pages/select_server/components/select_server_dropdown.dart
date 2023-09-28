import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/providers/px_server_status_px.dart';

class SelectServerDropdown extends StatelessWidget {
  const SelectServerDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.purple.shade100,
          ),
          child: DropdownButton<Server>(
            hint: const Text("Select Server..."),
            isExpanded: true,
            alignment: Alignment.center,
            items: Servers.serverList.map<DropdownMenuItem<Server>>((e) {
              return DropdownMenuItem<Server>(
                value: e,
                alignment: Alignment.center,
                child: Text(
                  e.name,
                  textAlign: TextAlign.center,
                ),
              );
            }).toList(),
            onChanged: (value) {
              context.read<PxServerStatus>().selectServerAddress(value);
              context.read<PxServerStatus>().nullifyServerStatus();
            },
            value: context.watch<PxServerStatus>().server,
          ),
        ),
      ),
    );
  }
}
