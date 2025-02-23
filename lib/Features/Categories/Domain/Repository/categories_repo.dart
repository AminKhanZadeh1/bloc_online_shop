import 'package:bloc_online_shop/Features/Categories/Domain/Entities/categories_entity.dart';

abstract class CategoriesRepo {
  Future<List<CategoriesEntity>> getProducts(String category);
}
