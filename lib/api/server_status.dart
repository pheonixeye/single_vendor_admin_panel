import 'dart:convert';

import 'package:single_vendor_admin_panel/api/constants/api_const.dart';
import 'package:single_vendor_admin_panel/api/constants/servers.dart';
import 'package:single_vendor_admin_panel/api/errors/response_exception.dart';
import 'package:http/http.dart' as http;
import 'package:single_vendor_admin_panel/constants/env.dart';

class HxServerStatus {
  const HxServerStatus();

  Future fetchServerStatus(Server server) async {
    final response = await http.get(
      Uri.parse('${server.client.endPoint}/health'),
      headers: headers
        ..addAll(
          {
            "X-Appwrite-Key": switch (server.name) {
              'Development' => ENV.DEV_API_KEY,
              'Test-Cloud' => ENV.TEST_API_KEY,
              "Production" => ENV.PROD_API_KEY,
              _ => '',
            },
            "X-Appwrite-Project": server.client.config['project']!
          },
        ),
    );

    final res = jsonDecode(response.body);

    if (res['status'] == "pass") {
      return res['status'];
    } else {
      throw ResponseException(res.toString());
    }
  }
}
