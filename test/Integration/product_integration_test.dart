// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_online_shop/Features/Products/Data/Repository/product_repo_impl.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProductRepoImpl repository;

  setUp(() {
    repository = ProductRepoImpl();
  });

  test(
    "Real API test",
    () async {
      List<ProductEntity> result = await repository.fetchProducts();
      result[0] = result[0].copyWith(discount: 10);
      result[1] = result[1].copyWith(discount: 50);
      result[4] = result[4].copyWith(discount: 15);
      result[6] = result[6].copyWith(discount: 30);
      result[9] = result[9].copyWith(discount: 20);
      result[13] = result[13].copyWith(discount: 10);

      expect(result, isA<List<ProductEntity>>());
      expect(result.isNotEmpty, true);
      expect(result[0].discount, 10.0);
    },
  );
}
