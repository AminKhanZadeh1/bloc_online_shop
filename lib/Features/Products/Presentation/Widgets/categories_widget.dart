import 'package:bloc_online_shop/Core/Utils/Routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  context.push(Routes.categoriesPage, extra: 'electronics'),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.green, Colors.black, Colors.blue]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/Category/electronics_category.jpeg",
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Electronic',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  context.push(Routes.categoriesPage, extra: 'jewelery'),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.purple, Colors.black, Colors.blue]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/Category/jewelry_category.jpg",
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Jewelry',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  context.push(Routes.categoriesPage, extra: "men's clothing"),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.amber, Colors.black, Colors.blue]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/Category/men's_clothing_category.jpg",
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Men",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => context.push(Routes.categoriesPage,
                  extra: "women's clothing"),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.red, Colors.black, Colors.blue]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ClipOval(
                          child: Image.asset(
                            "assets/images/Category/women's_clothing_category.jpg",
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Women",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
