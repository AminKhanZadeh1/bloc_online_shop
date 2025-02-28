import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/blocs/product_bloc/bloc/product_bloc.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TopSellsListWidget extends StatelessWidget {
  const TopSellsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is FetchProductsSuccessState) {
            List<ProductEntity> stateList = [
              state.products[2],
              state.products[8],
              state.products[6],
              state.products[15],
              state.products[16],
              state.products[3]
            ];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: stateList.length,
                  itemBuilder: (context, index) {
                    ProductEntity product2 = stateList[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/order', extra: product2.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: CachedNetworkImage(
                                  imageUrl: product2.image,
                                  fit: BoxFit.cover,
                                  height: 170,
                                  placeholder: (context, url) => Center(
                                      child: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? blackSpinkit
                                          : whiteSpinkit),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: SizedBox(
                                height: 40,
                                child: Center(
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    product2.title.length > 50
                                        ? "${product2.title.substring(0, 50)}..."
                                        : product2.title,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "\$${product2.price.toString()}",
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 270,
                  )),
            );
          } else if (state is FetchProductsFailedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(state.message,
                    style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () => BlocProvider.of<ProductBloc>(context)
                        .add(FetchProductsEvent()),
                    child: const Text('Retry')),
              ],
            );
          }
          return Center(
              child: Theme.of(context).brightness == Brightness.light
                  ? blackSpinkit
                  : whiteSpinkit);
        },
      ),
    );
  }
}
