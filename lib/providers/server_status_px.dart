import 'package:flutter/material.dart';
import 'package:single_vendor_admin_panel/api/server_status.dart';
import 'package:single_vendor_admin_panel/constants/servers.dart';

class PxServerStatus extends ChangeNotifier {
  Server? _server;
  Server? get server => _server;

  String? _status;
  String? get status => _status;

  void selectServerAddress(Server? server) {
    _server = server;
    notifyListeners();
  }

  Future checkServerStatus() async {
    try {
      await HxServerStatus.fetchServerStatus(server!.address).then((value) {
        _status = value;
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> checkSelectedServerStatus() async {
    try {
      _status = await HxServerStatus.fetchServerStatus(_server!.address);
      notifyListeners();
    } catch (e) {
      _status = null;
      notifyListeners();
      rethrow;
    }
    return _status;
  }

  void nullifyServerAndStatus() {
    _server = null;
    _status = null;
    notifyListeners();
  }

  void nullifyServerStatus() {
    _status = null;
    notifyListeners();
  }
}
