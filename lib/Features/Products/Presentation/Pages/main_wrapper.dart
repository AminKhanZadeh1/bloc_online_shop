// import 'package:bloc_online_shop/Features/Products/Domain/Entities/product_entity.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Pages/bottom_nav_cubit.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Pages/home_screen.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Pages/pages.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/blocs/product_bloc/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late PageController pageController;
  @override
  void initState() {
    context.read<ProductBloc>().add(FetchProductsEvent());
    pageController = PageController(keepPage: true);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<Widget> pages = const [
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: _mainWrapperBody(),
        bottomNavigationBar: _mainWrapperBottomNavBar(context),
      ),
    );
  }

  Widget _mainWrapperBody() {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return PageView(
          controller: pageController,
          onPageChanged: (int page) {
            BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
          },
          children: pages.map((page) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: page,
            );
          }).toList(),
        );
      },
    );
  }

  void onPageChanged(int page) {
    BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
  }

  Widget _bottomAppBarItem(
    BuildContext context, {
    required defaultIcon,
    required page,
    required label,
    required filledIcon,
  }) {
    return GestureDetector(
      onTap: () {
        pageController.jumpToPage(
          page,
        );
        BlocProvider.of<BottomNavCubit>(context).changeSelectedIndex(page);
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 3),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: Center(
                child: Icon(
                  context.watch<BottomNavCubit>().state == page
                      ? filledIcon
                      : defaultIcon,
                  color: context.watch<BottomNavCubit>().state == page
                      ? Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.amber
                      : Theme.of(context).brightness == Brightness.light
                          ? Colors.grey[700]
                          : Colors.grey,
                  size: Checkbox.width * 1.5,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            SizedBox(
              width: 60,
              height: 18,
              child: Center(
                child: Text(label,
                    style: GoogleFonts.aBeeZee(
                        color: context.watch<BottomNavCubit>().state == page
                            ? Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.amber
                            : Theme.of(context).brightness == Brightness.light
                                ? Colors.grey[700]
                                : Colors.grey,
                        fontSize: Checkbox.width / 1.5,
                        fontWeight:
                            context.watch<BottomNavCubit>().state == page
                                ? FontWeight.w600
                                : FontWeight.w300)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _mainWrapperBottomNavBar(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          border:
              const Border(top: BorderSide(color: Colors.lightBlue, width: 2)),
          gradient: LinearGradient(
              colors: Theme.of(context).brightness == Brightness.light
                  ? [
                      Colors.white,
                      const Color.fromARGB(255, 115, 208, 255),
                      Colors.white
                    ]
                  : [Colors.black, Colors.grey.shade900, Colors.black]),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.home,
              page: 0,
              label: 'Home',
              filledIcon: IconlyBold.home),
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.heart,
              page: 1,
              label: 'Favorites',
              filledIcon: IconlyBold.heart),
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.buy,
              page: 2,
              label: 'Cart',
              filledIcon: IconlyBold.buy),
          _bottomAppBarItem(context,
              defaultIcon: IconlyLight.profile,
              page: 3,
              label: 'Profile',
              filledIcon: IconlyBold.profile),
        ],
      ),
    );
  }
}
