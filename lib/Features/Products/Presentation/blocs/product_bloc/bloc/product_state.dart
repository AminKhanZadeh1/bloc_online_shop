part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class FetchProductsProcessState extends ProductState {}

class FetchProductsFailedState extends ProductState {
  final String message;
  const FetchProductsFailedState({required this.message});

  @override
  List<Object> get props => [message];
}

class FetchProductsSuccessState extends ProductState {
  final List<ProductEntity> products;
  const FetchProductsSuccessState({required this.products});

  @override
  List<Object> get props => [products];
}
