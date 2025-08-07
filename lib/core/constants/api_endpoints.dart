class Auth {
  String endPoint = '/auth';
  String get login => '$endPoint/login';
}

class ProductEndpoints {
  String endPoint = '/api/API/Product';
  String get dashboard => '$endPoint/DashBoard';
  String get productList => '$endPoint/ProductList';
}

class ApiEndpoints {
  static final auth = Auth();
  static final product = ProductEndpoints();
}
