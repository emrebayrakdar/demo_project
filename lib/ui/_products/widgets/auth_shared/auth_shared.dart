import 'dart:ui';
import 'dart:math' as math;
import 'package:demo_project/ui/_products/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildBall(Size size) => Image.asset("assets/images/top.png");

Widget buildTitle(Size size) => SvgPicture.asset("assets/images/svg/text.svg");

Widget buildTopShadow() => Align(
  alignment: Alignment.topRight,
  child: Opacity(
    opacity: 0.2,
    child: Transform.rotate(
      angle: 0.00001001791226195056 * (math.pi / 180),
      child: Container(
          width: double.infinity,
          height: UIHelper.height(20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF212323),
                Color(0x00000000),
              ],
            ),
          )),
    ),
  ),
);

Widget buildBottomShadow() => Align(
  alignment: Alignment.bottomCenter,
  child: Opacity(
    opacity: 0.2,
    child: Container(
        width: double.infinity,
        height: UIHelper.height(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF212323),
              Color(0x00000000),
            ],
          ),
        )),
  ),
);

Image buildBackgroundImage(BuildContext context) => Image.asset(
  "assets/images/background_1.png",
  height: MediaQuery.of(context).size.height,
  width: MediaQuery.of(context).size.width,
  fit: BoxFit.cover,
);