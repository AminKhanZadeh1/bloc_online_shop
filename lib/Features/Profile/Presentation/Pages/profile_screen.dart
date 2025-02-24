import 'package:bloc_online_shop/Config/Theme/Theme_Cubit/cubit/theme_cubit.dart';
import 'package:bloc_online_shop/Config/Theme/theme.dart';
import 'package:bloc_online_shop/Features/Profile/Presentation/Widgets/Profile_Screen/profile_list_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                FirebaseAuth.instance.currentUser?.displayName.toString() ??
                    'Unknown',
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 80,
              ),
              const ProfileListView(),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<ThemeCubit, ThemeData>(
                builder: (context, theme) {
                  return Switch(
                      value: theme == darkMode,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme();
                      });
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
