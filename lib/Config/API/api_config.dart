import 'package:dio/dio.dart';

class ApiConfig {
  static const String baseUrl = "https://fakestoreapi.com";

  static const String productsUrl = "$baseUrl/products";

  static const String categoriesUrl = "$productsUrl/category";

  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    )..interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
      ));
  }
}
