import 'package:flutter/material.dart';

class ProfileListTiles extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  const ProfileListTiles(
      {super.key,
      required this.onTap,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white)),
        onTap: onTap,
        leading: Icon(
          icon,
        ),
        tileColor: Theme.of(context).brightness == Brightness.light
            ? const Color.fromARGB(255, 206, 233, 255)
            : Colors.grey.shade900,
        title: Text(
          title,
        ),
      ),
    );
  }
}
