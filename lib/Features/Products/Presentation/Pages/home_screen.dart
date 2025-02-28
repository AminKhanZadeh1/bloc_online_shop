// ignore_for_file: deprecated_member_use

import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Widgets/ads_banner_list_widget.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Widgets/categories_widget.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Widgets/discounted_list_widget.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Widgets/notification_button_widget.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_event.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Widgets/search_text_field_widget.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Widgets/top_sells_list_widget.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_bloc.dart';
import 'package:bloc_online_shop/Features/Search/Presentation/Blocs/search_bloc/search_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController searchController = TextEditingController();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    super.build(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (searchController.text.isNotEmpty) {
          FocusScope.of(context).unfocus();
          searchController.clear();
          BlocProvider.of<SearchBloc>(context).add(SearchFinishedEvent());
        } else {
          BlocProvider.of<SearchBloc>(context).add(SearchFinishedEvent());
          Navigator.of(context).maybePop();
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          searchController.text = '';
          BlocProvider.of<SearchBloc>(context).add(SearchQueryChanged(''));
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size(width, 80),
            child: Material(
              color: Colors.lightBlue.withAlpha(110),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
              ),
              elevation: 4,
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      SearchTextFieldWidget(
                        searchController: searchController,
                      ),
                      const Spacer(),
                      const NotificationButtonWidget(),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: Theme.of(context).brightness == Brightness.light
                        ? [
                            const Color.fromARGB(255, 155, 250, 183),
                            Colors.white
                          ]
                        : [
                            const Color.fromARGB(255, 40, 15, 84),
                            Colors.black,
                          ])),
            child: Stack(
              children: [
                IndexedStack(
                  index: 0,
                  children: [
                    BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        final crossFadeState = (state is SearchInitial ||
                                state is SearchEndedState)
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond;
                        return ListView(
                          children: [
                            AnimatedCrossFade(
                              firstCurve: Curves.easeInBack,
                              secondCurve: Curves.easeInBack,
                              duration: const Duration(milliseconds: 400),
                              firstChild: Column(
                                children: [
                                  const AdsBannerListWidget(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        textAlign: TextAlign.left,
                                        'Discounted',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const DiscountedListWidget(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        textAlign: TextAlign.left,
                                        'Categories',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const CategoriesWidget(),
                                  const Divider(
                                    indent: 20,
                                    endIndent: 20,
                                    thickness: 1.5,
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 40,
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        textAlign: TextAlign.left,
                                        'Top Sells',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const TopSellsListWidget(),
                                  const SizedBox(height: 15),
                                ],
                              ),
                              secondChild: Column(
                                children: [
                                  if (state is SearchLoadedState)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.products.length,
                                      itemBuilder: (context, index) {
                                        final result = state.products[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: ListTile(
                                            onTap: () {
                                              context.push('/order',
                                                  extra: result.id);
                                            },
                                            title: SizedBox(
                                              height: 20,
                                              child: Text(
                                                style: const TextStyle(
                                                    fontSize: 15),
                                                result.title.length >= 30
                                                    ? "${result.title.substring(0, 27)}..."
                                                    : result.title,
                                              ),
                                            ),
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: RepaintBoundary(
                                                child: CachedNetworkImage(
                                                  height: 50,
                                                  width: 50,
                                                  imageUrl: result.image,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child: Theme.of(context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? blackSpinkit
                                                              : whiteSpinkit),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  if (state is SearchErrorState)
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          state.message,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.light
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    ),
                                  if (state is SearchLoadingState)
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Center(
                                                  child: Theme.of(context)
                                                              .brightness ==
                                                          Brightness.light
                                                      ? blackSpinkit
                                                      : whiteSpinkit),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                ],
                              ),
                              crossFadeState: crossFadeState,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
