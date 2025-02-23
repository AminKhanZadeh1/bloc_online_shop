import 'package:bloc_online_shop/Core/Utils/Params/params.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Repository/product_repo.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';

class FetchProdutsUseCase implements UseCase<List<ProductEntity>, void> {
  final ProductRepo _productRepo;

  FetchProdutsUseCase(this._productRepo);

  @override
  Future<List<ProductEntity>> call(void params) async {
    return await _productRepo.fetchProducts();
  }
}
