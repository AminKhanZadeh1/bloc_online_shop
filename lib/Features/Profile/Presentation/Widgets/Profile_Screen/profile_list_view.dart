import 'package:bloc_online_shop/Features/Authentication/Presentation/Blocs/login_bloc/bloc/login_bloc.dart';
import 'package:bloc_online_shop/Features/Profile/Presentation/Widgets/Profile_Screen/profile_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class ProfileListView extends StatelessWidget {
  const ProfileListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileListTile(
            onTap: () {}, title: 'Ordered', icon: Icons.shopping_bag_outlined),
        ProfileListTile(
            onTap: () {}, title: 'Settings', icon: IconlyLight.setting),
        ProfileListTile(
            onTap: () => context.push('/about'),
            title: 'About',
            icon: IconlyLight.info_circle),
        const SizedBox(
          height: 15,
        ),
        const Divider(),
        const SizedBox(
          height: 15,
        ),
        ProfileListTile(
            onTap: () =>
                BlocProvider.of<LoginBloc>(context).add(LogOutRequest()),
            title: 'Logout',
            icon: IconlyLight.logout),
      ],
    );
  }
}
