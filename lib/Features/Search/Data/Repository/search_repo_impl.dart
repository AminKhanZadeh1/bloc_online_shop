import 'package:bloc_online_shop/Config/API/api_config.dart';
import 'package:bloc_online_shop/Features/Products/Data/Models/product_model.dart';
import 'package:bloc_online_shop/Features/Search/Domain/Repository/search_repo.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:bloc_online_shop/Features/Products/Data/Sources/Remote/products_api_service.dart';

class SearchRepoImpl implements SearchRepo {
  final _apiService = ApiService(dio: ApiConfig.createDio());

  @override
  Future<List<ProductEntity>> fetchResults() async {
    return (await _apiService.getProducts())
        .map((e) => ProductModel.fromJson(e).toEntity())
        .toList();
  }
}
