import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/blocs/product_bloc/bloc/product_bloc.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DiscountedListWidget extends StatelessWidget {
  const DiscountedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is FetchProductsSuccessState) {
            List<ProductEntity> discounted = [
              state.products[0],
              state.products[1],
              state.products[4],
              state.products[6],
              state.products[9],
              state.products[13]
            ];
            return GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 7,
                mainAxisSpacing: 15,
                crossAxisCount: 1,
              ),
              shrinkWrap: true,
              itemCount: discounted.length,
              itemBuilder: (context, index) {
                ProductEntity product = discounted[index];
                return GestureDetector(
                  onTap: () {
                    context.push(
                      '/order',
                      extra: product.id, // ارسال مدل
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(255, 191, 235, 255)
                          : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            height: 150,
                            width: double.infinity,
                            imageUrl: product.image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Center(child: spinkit),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 60,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 142,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 35,
                                        width: 142,
                                        child: Text(
                                          textAlign: TextAlign.left,
                                          product.title.length == 25
                                              ? "${product.title.substring(0, 25)}..."
                                              : product.title,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      SizedBox(
                                        height: 15,
                                        width: 100,
                                        child: Text(
                                            textAlign: TextAlign.center,
                                            product.discount != null
                                                ? "\$${product.price.toString()}"
                                                : 'null',
                                            style: const TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                decorationColor: Colors.red,
                                                fontSize: 14)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 41,
                                child: ScrollConfiguration(
                                  behavior: ScrollConfiguration.of(context)
                                      .copyWith(scrollbars: false),
                                  child: SingleChildScrollView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                  size: 14,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4.0),
                                                child: SizedBox(
                                                  height: 15,
                                                  width: 25,
                                                  child: Text(
                                                    product.rating.rate
                                                                .toString()
                                                                .length ==
                                                            1
                                                        ? "${product.rating.rate}.0"
                                                        : product.rating.rate
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Material(
                                          elevation: 5,
                                          shape: const CircleBorder(),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.red,
                                            child: Column(
                                              children: [
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                  child: Text(
                                                    "${product.discount.toString()}%",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                  child: Text(
                                                    "OFF",
                                                    style: TextStyle(
                                                        fontSize: 7,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: double.infinity,
                          // decoration: BoxDecoration(
                          //     color: Colors.grey,
                          //     borderRadius: BorderRadius.only(
                          //         bottomLeft: Radius.circular(20),
                          //         bottomRight: Radius.circular(20))),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              product.discount != null
                                  ? "\$${product.finalPrice.toStringAsFixed(2)}"
                                  : "\$${product.price.toString()}",
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is FetchProductsFailedState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message,
                    style: const TextStyle(color: Colors.white)),
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
          return const Center(child: spinkit);
        },
      ),
    );
  }
}
