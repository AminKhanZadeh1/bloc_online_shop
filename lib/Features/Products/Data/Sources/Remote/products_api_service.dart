import 'package:dio/dio.dart';
import 'package:bloc_online_shop/Config/API/api_config.dart';
// import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
// import 'package:bloc_online_shop/Features/Products/Data/Models/product_model.dart';

class ApiService {
  // final Dio dio = ApiConfig.createDio();
  final Dio dio;

  ApiService({required this.dio});

  Future<List<dynamic>> getProducts() async {
    final response = await dio.get(ApiConfig.productsUrl);

    // if (response.statusCode == 200) {
    //   return (response.data as List)
    //       .map((e) => ProductModel.fromJson(e).toEntity())
    //       .toList();
    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      return data;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
