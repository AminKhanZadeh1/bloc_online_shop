import 'package:bloc_online_shop/Features/Search/Domain/Repository/search_repo.dart';
import 'package:bloc_online_shop/Features/Search/Domain/UseCases/search_use_cases.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_event.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_state.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo searchRepo;
  List<ProductEntity>? allProducts;
  String? previousQuery;

  SearchBloc(this.searchRepo) : super(SearchInitial()) {
    allProducts = [];
    on<SearchQueryChanged>((event, emit) async {
      if (allProducts == null || allProducts!.isEmpty) {
        allProducts = await GetResultsUseCase(searchRepo).call(null);
      }
      if (event.query.isEmpty) {
        emit(SearchEndedState());
        return;
      }
      emit(SearchLoadingState());

      final query = event.query;
      final filteredProducts = allProducts!
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()) ||
              product.description.toLowerCase().contains(query.toLowerCase()))
          .toList();

      if (filteredProducts.isEmpty) {
        emit(SearchErrorState(message: "No Items found"));
        previousQuery = event.query;
        if (event.query.contains(previousQuery ?? '')) {
          emit(SearchErrorState(message: "No Items found"));
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
        emit(SearchLoadedState(products: filteredProducts));
      }
    });
    on<SearchFinishedEvent>(
      (event, emit) {
        emit(SearchEndedState());
      },
    );
  }
}
