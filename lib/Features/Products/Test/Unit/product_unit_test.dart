// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_online_shop/Features/Products/Data/Models/product_model.dart';
import 'package:bloc_online_shop/Features/Products/Data/Repository/product_repo_impl.dart';
import 'package:bloc_online_shop/Features/Products/Data/Sources/Remote/products_api_service.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([ApiService, ProductRepoImpl])
import 'product_unit_test.mocks.dart';

void main() {
  late MockApiService mockApiService;
  late MockProductRepoImpl mockProductRepoImpl;

  setUp(() {
    mockApiService = MockApiService();
    mockProductRepoImpl = MockProductRepoImpl();
  });

  test('fetchProducts should return a list of ProductEntity', () async {
    final fakeJson = [
      {
        "id": 1,
        "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        "price": 109.95,
        "description":
            "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        "category": "men's clothing",
        "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        "rating": {"rate": 3.9, "count": 120}
      },
      {
        "id": 2,
        "title": "Mens Casual Premium Slim Fit T-Shirts ",
        "price": 22.3,
        "description":
            "Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.",
        "category": "men's clothing",
        "image":
            "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
        "rating": {"rate": 4.1, "count": 259}
      }
    ];

    when(mockApiService.getProducts()).thenAnswer((_) async => fakeJson);

    when(mockProductRepoImpl.fetchProducts()).thenAnswer((_) async =>
        (await mockApiService.getProducts())
            .map((e) => ProductModel.fromJson(e).toEntity())
            .toList());

    final result = await mockProductRepoImpl.fetchProducts();

    expect(result, isA<List<ProductEntity>>());
    expect(result, isNotEmpty);
    expect(result.first.title,
        "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops");
  });
}
