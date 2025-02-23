import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Repository/product_repo.dart';
import 'package:bloc_online_shop/Features/Products/Domain/UseCases/products_use_cases.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _productRepo;
  List<ProductEntity>? products;

  ProductBloc(this._productRepo) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is FetchProductsEvent) {
        emit(FetchProductsProcessState());
        try {
          // Fetch products with timeout
          products = await FetchProdutsUseCase(_productRepo).call(null).timeout(
            const Duration(seconds: 6), // Set your timeout duration here
            onTimeout: () {
              throw TimeoutException(
                  "The operation has timed out."); // Custom timeout exception
            },
          );
        } on TimeoutException catch (_) {
          emit(const FetchProductsFailedState(
              message: "Network Error. Please check your connection"));
        } catch (e) {
          emit(const FetchProductsFailedState(
              message: "Network Error. Please check your connection"));
        }

        if (products == null || products!.isEmpty) {
          emit(const FetchProductsFailedState(
              message: "Network Error. Please check your connection"));
        } else {
          products![0] = products![0].copyWith(discount: 10);
          products![1] = products![1].copyWith(discount: 50);
          products![4] = products![4].copyWith(discount: 15);
          products![6] = products![6].copyWith(discount: 30);
          products![9] = products![9].copyWith(discount: 20);
          products![13] = products![13].copyWith(discount: 10);
          emit(FetchProductsSuccessState(products: products!));
        }
      }
    });
  }
}
