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
            side: const BorderSide(color: Colors.white)),
        onTap: onTap,
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        tileColor: Colors.grey.shade900,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
