import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:bloc_online_shop/Features/Profile/Presentation/Widgets/Profile_Screen/profile_list_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ProfileListView extends StatelessWidget {
  const ProfileListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileListTiles(
            onTap: () {}, title: 'Ordered', icon: Icons.shopping_bag_outlined),
        ProfileListTiles(
            onTap: () {}, title: 'Settings', icon: IconlyLight.setting),
        ProfileListTiles(
            onTap: () {}, title: 'About', icon: IconlyLight.info_circle),
        const SizedBox(
          height: 15,
        ),
        const Divider(),
        const SizedBox(
          height: 15,
        ),
        ProfileListTiles(
            onTap: () =>
                BlocProvider.of<LoginBloc>(context).add(LogOutRequest()),
            title: 'Logout',
            icon: IconlyLight.logout),
      ],
    );
  }
}
