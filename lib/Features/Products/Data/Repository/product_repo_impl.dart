import 'package:bloc_online_shop/Config/API/api_config.dart';
import 'package:bloc_online_shop/Features/Products/Data/Models/product_model.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Repository/product_repo.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:bloc_online_shop/Features/Products/Data/Sources/Remote/products_api_service.dart';

class ProductRepoImpl implements ProductRepo {
  final _apiService = ApiService(dio: ApiConfig.createDio());

  @override
  Future<List<ProductEntity>> fetchProducts() async {
    List<ProductEntity> products = (await _apiService.getProducts())
        .map((e) => ProductModel.fromJson(e).toEntity())
        .toList();
    products[0] = products[0].copyWith(discount: 10);
    products[1] = products[1].copyWith(discount: 50);
    products[4] = products[4].copyWith(discount: 15);
    products[6] = products[6].copyWith(discount: 30);
    products[9] = products[9].copyWith(discount: 20);
    products[13] = products[13].copyWith(discount: 10);
    return products;
  }
}
