import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<bool> {
  NotificationCubit() : super(false);

  void toggleNotificationPanel() => emit(!state); // تغییر وضعیت
}
