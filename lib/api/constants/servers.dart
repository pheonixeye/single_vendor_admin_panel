import 'package:single_vendor_admin_panel/constants/env.dart';
import 'package:appwrite/appwrite.dart';

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
  final Client client;

  const Server._({
    required this.name,
    required this.client,
  });

  factory Server.dev() {
    return Server._(
      name: 'Development',
      client: Client(endPoint: ENV.DEV_ENDPOINT, selfSigned: true)
          .setProject(ENV.DEV_PROJECT_ID),
    );
  }

  factory Server.test() {
    final client = Client(endPoint: ENV.TEST_ENDPOINT, selfSigned: true)
        .setProject(ENV.TEST_PROJECT_ID);
    return Server._(
      name: 'Test-Cloud',
      client: client,
    );
  }

  factory Server.production() {
    final client = Client(endPoint: ENV.PROD_ENDPOINT, selfSigned: true)
        .setProject(ENV.PROD_PROJECT_ID);
    return Server._(
      name: "Production",
      client: client,
    );
  }
}
