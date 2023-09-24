import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:single_vendor_admin_panel/constants/env.dart';
import 'package:appwrite/appwrite.dart';

final _client = Client();

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
      client: _client
          .setEndpoint(dotenv.get(ENV.ENDPOINT))
          .setProject(dotenv.get(ENV.PROJECT_ID))
          .addHeader('X-Appwrite-Key', dotenv.get(ENV.API_KEY))
          .setSelfSigned(status: true),
    );
  }

  factory Server.test() {
    return Server._(
      name: 'Test-Cloud',
      client: _client
          .setEndpoint(dotenv.get(ENV.ENDPOINT))
          .setProject(dotenv.get(ENV.PROJECT_ID))
          .addHeader('X-Appwrite-Key', dotenv.get(ENV.API_KEY))
          .setSelfSigned(status: true),
    );
  }

  factory Server.production() {
    return Server._(
      name: "Production",
      client: _client,
    );
  }
}
