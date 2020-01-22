class Env {
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  static const testConfig = {
    'baseUrl': 'http://192.168.68.105:3000/api'
  };

  static const productionConfig = {
    'baseUrl': 'http://192.168.68.105:3000/api'
  };

  static const environment = isProduction ? productionConfig : testConfig;

}