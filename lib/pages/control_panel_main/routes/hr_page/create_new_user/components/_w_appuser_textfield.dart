import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:single_vendor_admin_panel/providers/auth/px_app_users.dart';

enum Usage { name, email, password }

bool isDebug() {
  return kDebugMode;
}

/// TextField to set AppUser model either for creation or
/// authentication, enum [Usage] determines which field on
/// the AppUser class to set, [uuid] is generated for each
/// change in the [AppUser] model data in copyWith method.
class AppUserTextField extends StatefulWidget {
  const AppUserTextField({super.key, required this.usage});
  final Usage usage;

  @override
  State<AppUserTextField> createState() => _AppUserTextFieldState();
}

class _AppUserTextFieldState extends State<AppUserTextField> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PxAppUsers>(
            builder: (context, u, c) {
              return TextFormField(
                initialValue: isDebug()
                    ? switch (widget.usage) {
                        Usage.email => 'admin@admin.com',
                        Usage.password => 'adminadmin',
                        Usage.name => '',
                      }
                    : '',
                obscureText: switch (widget.usage) {
                  Usage.email || Usage.name => false,
                  Usage.password => _isHidden,
                },
                decoration: InputDecoration(
                  hintText: switch (widget.usage) {
                    Usage.email ||
                    Usage.name ||
                    Usage.password =>
                      "Enter ${widget.usage.name} ...",
                  },
                  labelText: switch (widget.usage) {
                    Usage.email ||
                    Usage.password ||
                    Usage.name =>
                      widget.usage.name,
                  },
                  suffix: switch (widget.usage) {
                    Usage.email || Usage.name => const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.password,
                          color: Colors.transparent,
                        ),
                      ),
                    Usage.password => IconButton(
                        onPressed: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                        icon: const Icon(
                          Icons.password,
                        ),
                      ),
                  },
                ),
                onChanged: (value) {
                  switch (widget.usage) {
                    case Usage.email:
                      u.setAppUser(email: value);
                      break;
                    case Usage.name:
                      u.setAppUser(name: value);
                      break;
                    case Usage.password:
                      u.setAppUser(password: value);
                      break;
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
