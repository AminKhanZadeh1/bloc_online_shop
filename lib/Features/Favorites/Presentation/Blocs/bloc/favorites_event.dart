part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FetchFavStreamEvent extends FavoritesEvent {
  final String userId;

  const FetchFavStreamEvent(this.userId);
}

class RemoveFromFavsEvent extends FavoritesEvent {
  final int productId;

  const RemoveFromFavsEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
