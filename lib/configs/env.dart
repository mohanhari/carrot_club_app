class Env {
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  static const testConfig = {
    'baseUrl': 'http://10.0.2.2:3000/api'
  };

  static const productionConfig = {
    'baseUrl': 'some-url.com'
  };

  static const environment = isProduction ? productionConfig : testConfig;

}