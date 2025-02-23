// import 'package:bloc_online_shop/Config/Theme/spinkit.dart';
// import 'package:bloc_online_shop/Features/Cart/Presentation/Blocs/cart_bloc/bloc/cart_bloc.dart';
// import 'package:bloc_online_shop/Features/Order/Domain/Entities/order_entity.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class CartItemsList extends StatelessWidget {
//   final CartLoadedState state;
//   const CartItemsList({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
//       child: ListView.builder(
//         itemExtent: 110,
//         shrinkWrap: true,
//         itemCount: state.cartItems.length,
//         itemBuilder: (context, index) {
//           OrderEntity item = state.cartItems[index]!;
//           return GestureDetector(
//             onTap: () {
//               context.push('/order', extra: item.productId);
//             },
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Stack(
//                 clipBehavior: Clip.none, // اجازه خروج از محدوده را می‌دهد
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade800,
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     padding: const EdgeInsets.symmetric(horizontal: 12),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(width: 150), // فضای خالی برای تصویر
//                         Expanded(
//                           child: Column(
//                             children: [
//                               const SizedBox(height: 20),
//                               SizedBox(
//                                 height: 35,
//                                 child: Text(
//                                   textAlign: TextAlign.center,
//                                   item.productName.length > 35
//                                       ? '${item.productName.substring(0, 32)}...'
//                                       : item.productName,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 15),
//                               Text(
//                                 "\$${item.price}",
//                                 style: const TextStyle(
//                                     color: Colors.white, fontSize: 15),
//                               )
//                             ],
//                           ),
//                         ),
//                         // _buildQuantityButtons(context, item),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top:
//                         -20, // این مقدار باعث می‌شود تصویر بالاتر از `Container` قرار بگیرد
//                     left: 12,
//                     child: SizedBox(
//                       height:
//                           120, // تنظیم ارتفاع بیشتر برای بیرون زدن از کانتینر
//                       width: 120,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: CachedNetworkImage(
//                           width: double.infinity,
//                           imageUrl: item.image,
//                           fit: BoxFit.cover,
//                           placeholder: (context, url) =>
//                               const Center(child: spinkit),
//                           errorWidget: (context, url, error) =>
//                               const Icon(Icons.error, color: Colors.red),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
