// ignore_for_file: constant_identifier_names

class ENV {
  static const String ENDPOINT = "ENDPOINT";
  static const String PROJECT_ID = "PROJECT_ID";
  static const String API_KEY = "API_KEY";
}

enum ENVIRONMENT {
  dev('env/_dev.env'),
  test('env/_test.env'),
  prod('env/_proc.env');

  final String path;
  const ENVIRONMENT(this.path);
}
