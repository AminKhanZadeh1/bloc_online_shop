import 'package:bloc_online_shop/Core/Utils/Params/params.dart';
import 'package:bloc_online_shop/Core/Utils/UserAuth_Check/user_auth.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Repository/fav_repo.dart';

class FetchFavItemsUseCase implements StreamUseCase<List<FavEntity?>, String> {
  final FavRepo _favRepo;

  const FetchFavItemsUseCase(this._favRepo);
  @override
  Stream<List<FavEntity?>> call(String params) {
    return _favRepo.getFavItems(params);
  }
}

class RemoveItemFromFavsUseCase implements UseCase<void, int> {
  final FavRepo _favRepo;

  const RemoveItemFromFavsUseCase(this._favRepo);

  @override
  Future<void> call(int params) {
    return _favRepo.removeFromFavs(UserAuth.userId, params.toString());
  }
}
