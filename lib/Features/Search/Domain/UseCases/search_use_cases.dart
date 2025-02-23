import 'package:bloc_online_shop/Core/Utils/Params/params.dart';
import 'package:bloc_online_shop/Features/Search/Domain/Repository/search_repo.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';

class GetResultsUseCase implements UseCase<List<ProductEntity>, void> {
  final SearchRepo searchRepo;

  GetResultsUseCase(this.searchRepo);

  @override
  Future<List<ProductEntity>> call(void params) {
    return searchRepo.fetchResults();
  }
}
