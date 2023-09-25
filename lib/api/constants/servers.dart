// ignore_for_file: library_prefixes

import 'package:single_vendor_admin_panel/constants/env.dart';
import 'package:appwrite/appwrite.dart' as clientSDK;
import 'package:dart_appwrite/dart_appwrite.dart' as serverSDK;

class Servers {
  const Servers._();

  static Servers get instance => const Servers._();

  static final List<Server> _servers = [
    Server.dev(),
    Server.test(),
    Server.production(),
  ];

  static List<Server> get serverList => _servers;
}

class Server {
  final String name;
  final clientSDK.Client clientClient;
  final serverSDK.Client serverClient;

  const Server._({
    required this.name,
    required this.clientClient,
    required this.serverClient,
  });

  factory Server.dev() {
    return Server._(
      name: 'Development',
      clientClient:
          clientSDK.Client(endPoint: ENV.DEV_ENDPOINT, selfSigned: true)
              .setProject(ENV.DEV_PROJECT_ID),
      serverClient:
          serverSDK.Client(endPoint: ENV.DEV_ENDPOINT, selfSigned: true)
              .setProject(ENV.DEV_PROJECT_ID)
              .setKey(ENV.DEV_API_KEY),
    );
  }

  factory Server.test() {
    return Server._(
      name: 'Test-Cloud',
      clientClient:
          clientSDK.Client(endPoint: ENV.TEST_ENDPOINT, selfSigned: true)
              .setProject(ENV.TEST_PROJECT_ID)
              .addHeader("X-RateLimit-Limit", "5000"),
      serverClient:
          serverSDK.Client(endPoint: ENV.TEST_ENDPOINT, selfSigned: true)
              .setProject(ENV.TEST_PROJECT_ID)
              .setKey(ENV.TEST_API_KEY),
    );
  }

  factory Server.production() {
    return Server._(
      name: "Production",
      clientClient:
          clientSDK.Client(endPoint: ENV.PROD_ENDPOINT, selfSigned: true)
              .setProject(ENV.PROD_PROJECT_ID),
      serverClient:
          serverSDK.Client(endPoint: ENV.PROD_ENDPOINT, selfSigned: true)
              .setProject(ENV.PROD_PROJECT_ID)
              .setKey(ENV.PROD_API_KEY),
    );
  }
}
