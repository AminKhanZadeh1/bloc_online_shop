import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showTopSnackBar(BuildContext context, String message) async {
  await Flushbar(
    messageColor: Colors.white,
    backgroundColor: Colors.red,
    flushbarPosition: FlushbarPosition.TOP,
    message: message,
    duration: const Duration(seconds: 3),
  ).show(context);
}
