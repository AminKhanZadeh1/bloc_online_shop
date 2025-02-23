import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';

abstract class ProductRepo {
  Future<List<ProductEntity>> fetchProducts();
}
