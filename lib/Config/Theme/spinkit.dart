import 'package:bloc_online_shop/Config/Theme/Colors/g_color.dart';
import 'package:bloc_online_shop/Config/Theme/Theme_Cubit/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

final spinkit = BlocBuilder<ThemeCubit, ThemeData>(
  builder: (context, theme) {
    return SpinKitCircle(
      color: theme.brightness == Brightness.light ? GColor.black : GColor.white,
      size: 50,
    );
  },
);

final loadingSpinkit = BlocBuilder<ThemeCubit, ThemeData>(
  builder: (context, theme) {
    return SpinKitCircle(
      color: theme.brightness == Brightness.light ? GColor.black : GColor.white,
      size: 25,
    );
  },
);

const authLoadingSpinkit = SpinKitCircle(
  color: GColor.white,
  size: 25,
);
