import 'package:bloc_online_shop/Features/Products/Presentation/Cubits/Notifications/notifications_cubit.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Widgets/notifications_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationButtonWidget extends StatelessWidget {
  const NotificationButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, bool>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border:
                Border.all(color: state ? Colors.white : Colors.transparent),
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.shade800,
          ),
          height: 50,
          width: 50,
          child: const NotificationButton(),
        );
      },
    );
  }
}
