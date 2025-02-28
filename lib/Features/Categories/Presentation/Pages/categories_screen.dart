import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/blocs/product_bloc/bloc/product_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatelessWidget {
  final String category;
  const CategoriesScreen({super.key, required this.category});

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            capitalizeFirstLetter(category),
            style: GoogleFonts.aladin(),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is FetchProductsProcessState) {
              return const Center(
                child: spinkit,
              );
            } else if (state is FetchProductsSuccessState) {
              List<ProductEntity> rawData = state.products;
              List<ProductEntity> stateList = [];
              if (category == "men's clothing") {
                stateList = [rawData[0], rawData[1], rawData[2], rawData[3]];
              } else if (category == "jewelery") {
                stateList = [rawData[4], rawData[5], rawData[6], rawData[7]];
              } else if (category == "electronics") {
                stateList = [
                  rawData[8],
                  rawData[9],
                  rawData[10],
                  rawData[11],
                  rawData[12],
                  rawData[13]
                ];
              } else if (category == "women's clothing") {
                stateList = [
                  rawData[14],
                  rawData[15],
                  rawData[16],
                  rawData[17],
                  rawData[18],
                  rawData[19]
                ];
              }
              return ListView(
                children: [
                  Padding(
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
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CachedNetworkImage(
                                    imageUrl: product2.image,
                                    fit: BoxFit.cover,
                                    height: 170,
                                    width: 170,
                                    placeholder: (context, url) =>
                                        const Center(child: spinkit),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: SizedBox(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          product2.title.length > 50
                                              ? "${product2.title.substring(0, 50)}..."
                                              : product2.title,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 270,
                        )),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Failed to fetch data'),
              );
            }
          },
        ),
      ),
    );
  }
}
