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
  final String address;

  const Server._({
    required this.name,
    required this.address,
  });

  factory Server.dev() {
    return const Server._(
      name: 'Development',
      address: "http://localhost:8888",
    );
  }

  factory Server.test() {
    return const Server._(
      name: 'Test',
      address: "//TODO: add fly.io server",
    );
  }

  factory Server.production() {
    return const Server._(
      name: "Production",
      address: "//TODO: add deployment server",
    );
  }
}
