enum Environment { dev, staging, prod }

class AppConfig {
  static late Environment _env;

  static void setEnvironment(Environment env) {
    _env = env;
  }

  static String get baseUrl {
    switch (_env) {
      case Environment.dev:
        return "http://esptiles.imperoserver.in";
      case Environment.staging:
        return "http://esptiles.imperoserver.in";
      case Environment.prod:
        return "http://esptiles.imperoserver.in";
    }
  }

  static Environment get current => _env;
}
