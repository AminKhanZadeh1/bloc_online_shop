import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';

abstract class SearchState {}

class SearchInitial extends SearchLoadedState {
  SearchInitial() : super(products: []);
}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<ProductEntity> products;
  SearchLoadedState({required this.products});
}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({required this.message});
}

class SearchEndedState extends SearchState {}
