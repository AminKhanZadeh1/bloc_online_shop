import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final double total;
  const CheckoutButton({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.green),
        foregroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      onPressed: () {},
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 25,
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
              height: 3,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Checkout',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  width: 3,
                ),
                Icon(
                  Icons.payment_rounded,
                  color: Colors.white,
                  size: 18,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
