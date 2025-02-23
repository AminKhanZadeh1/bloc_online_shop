part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

class FavsLoadingState extends FavoritesState {}

class FavsLoadedState extends FavoritesState {
  final List<FavEntity?> favProducts;

  const FavsLoadedState(this.favProducts);

  @override
  List<Object> get props => [favProducts];
}

class FavsErrorState extends FavoritesState {
  final String message;

  const FavsErrorState(this.message);
}
