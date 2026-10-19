import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  static double width(double value) => value.w;

  static double height(double value) => value.h;

  static double font(double value) => value.sp;

  static double radius(double value) => value.r;

  static double get screenWidth => ScreenUtil().screenWidth;

  static double get screenHeight => ScreenUtil().screenHeight;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).shortestSide >= 600;
}
