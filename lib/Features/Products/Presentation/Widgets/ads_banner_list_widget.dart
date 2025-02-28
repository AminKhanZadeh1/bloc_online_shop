import 'package:bloc_online_shop/Features/Products/Presentation/Cubits/Ads/ads_banner_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdsBannerListWidget extends StatelessWidget {
  const AdsBannerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> adPhotos = [
      'assets/images/Backpack_ad.png',
      'assets/images/Jewelry_ad.png',
      'assets/images/Wd_ad.jpg'
    ];

    return BlocProvider(
      create: (context) => AdsBannerCubit(pageCount: adPhotos.length),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AdsBannerCubit>();

          return SizedBox(
            height: 230,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: cubit.pageController,
                    itemCount: adPhotos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(adPhotos[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<AdsBannerCubit, int>(
                  builder: (context, currentIndex) {
                    return SmoothPageIndicator(
                      controller: cubit.pageController,
                      count: adPhotos.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.blue,
                        dotColor: Colors.grey,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
