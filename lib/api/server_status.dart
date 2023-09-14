import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:single_vendor_admin_panel/api/constants/api_const.dart';
import 'package:single_vendor_admin_panel/api/errors/response_exception.dart';

class HxServerStatus {
  static Future fetchServerStatus(String address) async {
    final Uri uri = Uri.parse(address);
    final response = await http.get(
      uri,
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw ResponseException(jsonDecode(response.body));
    }
  }
}
