import 'package:bloc/bloc.dart';
import 'package:bloc_online_shop/Core/Utils/UserAuth_Check/user_auth.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Entities/fav_entity.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/Repository/fav_repo.dart';
import 'package:bloc_online_shop/Features/Favorites/Domain/UseCases/fav_use_cases.dart';
import 'package:equatable/equatable.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavRepo _favRepo;
  List<FavEntity> favsList = [];
  FavoritesBloc(this._favRepo) : super(FavoritesInitial()) {
    on<FetchFavStreamEvent>(
      (event, emit) async {
        emit(FavsLoadingState());
        try {
          final favItemsStream =
              FetchFavItemsUseCase(_favRepo).call(UserAuth.userId);

          await emit.onEach(
            favItemsStream,
            onData: (data) {
              final updatedFavsList = data.whereType<FavEntity>().toList();
              favsList = updatedFavsList;
              emit(FavsLoadedState(updatedFavsList));
            },
          );
        } catch (error) {
          emit(FavsErrorState(error.toString()));
        }
      },
    );

    on<RemoveFromFavsEvent>(
      (event, emit) async {
        RemoveItemFromFavsUseCase(_favRepo).call(event.productId);
        final updatedFavsList = List<FavEntity>.from(favsList);
        updatedFavsList
            .removeWhere((item) => item.productId == event.productId);
        emit(FavsLoadedState(updatedFavsList));
      },
    );
  }
}
