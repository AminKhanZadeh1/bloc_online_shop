import 'package:flutter/material.dart';

class AdsBannerListWidget extends StatelessWidget {
  const AdsBannerListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> adPhotos = [
      'assets/images/Backpack_ad.png',
      'assets/images/Jewelry_ad.png',
      'assets/images/Wd_ad.jpg'
    ];
    return SizedBox(
      height: 230,
      child: PageView(
          scrollDirection: Axis.horizontal,
          children: List.generate(adPhotos.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(adPhotos[index])))),
            );
          })),
    );
  }
}
