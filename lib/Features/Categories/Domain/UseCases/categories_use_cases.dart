import 'package:bloc_online_shop/Core/Utils/Params/params.dart';
import 'package:bloc_online_shop/Features/Categories/Domain/Entities/categories_entity.dart';
import 'package:bloc_online_shop/Features/Categories/Domain/Repository/categories_repo.dart';

class FetchCategoriesUseCase
    implements UseCase<List<CategoriesEntity>, String> {
  final CategoriesRepo _categoriesRepo;

  FetchCategoriesUseCase(this._categoriesRepo);
  @override
  Future<List<CategoriesEntity>> call(String params) async {
    return await _categoriesRepo.getProducts(params);
  }
}
