import 'package:bloc_online_shop/Config/Theme/Colors/g_color.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final double total;
  const CheckoutButton({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
          side:
              WidgetStatePropertyAll(BorderSide(color: GColor.white, width: 2)),
          backgroundColor: WidgetStatePropertyAll(Colors.green),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          elevation: WidgetStatePropertyAll(5)),
      onPressed: () {},
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    margin: const EdgeInsets.only(top: 6),
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: Center(
                        child: Text(
                      "\$${total.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.green),
                    ))),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.payment_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
