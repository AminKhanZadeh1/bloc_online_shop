import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AdsBannerCubit extends Cubit<int> {
  final PageController pageController = PageController();
  final int pageCount;
  late Timer _timer;

  AdsBannerCubit({required this.pageCount}) : super(0) {
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int nextPage = (state + 1) % pageCount;
      pageController.animateToPage(
        nextPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      emit(nextPage);
    });
  }

  @override
  Future<void> close() {
    _timer.cancel();
    pageController.dispose();
    return super.close();
  }
}
