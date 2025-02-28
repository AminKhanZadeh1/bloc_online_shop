import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_online_shop/Features/Products/Presentation/Cubits/Notifications/notifications_cubit.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    return IconButton(
      icon: Icon(
        Icons.notifications,
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.grey.shade700
            : Colors.white,
      ),
      onPressed: () {
        cubit.toggleNotificationPanel();
        if (cubit.state) {
          _showOverlay(context);
        } else {
          _removeOverlay();
        }
      },
    );
  }

  static OverlayEntry? _overlayEntry;
  static final ValueNotifier<double> _opacityNotifier =
      ValueNotifier<double>(0.0);

  void _showOverlay(BuildContext context) {
    final cubit = context.read<NotificationCubit>();

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: () {
            _removeOverlay();
            cubit.toggleNotificationPanel();
          },
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              Positioned(
                right: 16,
                top: 80,
                child: GestureDetector(
                  onTap: () {},
                  child: ValueListenableBuilder<double>(
                    valueListenable: _opacityNotifier,
                    builder: (context, opacity, _) {
                      return AnimatedOpacity(
                        opacity: opacity,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          width: 200,
                          height: 300,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(255, 173, 228, 255)
                                    : Colors.grey.shade800,
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              'No Notifications',
                              style: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                fontSize: 15,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(const Duration(milliseconds: 10), () {
      _opacityNotifier.value = 1.0;
    });
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _opacityNotifier.value = 0.0;
      Future.delayed(const Duration(milliseconds: 150), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    }
  }
}
