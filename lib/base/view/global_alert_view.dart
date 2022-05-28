import 'package:demo_project/ui/_products/shared/app_colors.dart';
import 'package:demo_project/ui/_products/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalAlertView extends StatefulWidget {
  GlobalAlertView({Key? key, required this.assetsPath, required this.isSvg, required this.title, required this.description}) : super(key: key);
  final String assetsPath;
  final String title;
  final String description;
  final bool isSvg;

  _GlobalAlertViewState createState() => _GlobalAlertViewState();
}

class _GlobalAlertViewState extends State<GlobalAlertView> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isSvg ? SvgPicture.asset(widget.assetsPath, height: size.height * 0.55) : Image.asset(widget.assetsPath, height: size.height * 0.55),
              Text(widget.title, style: const TextStyle(fontSize: FontSizeValue.XXLARGE, fontWeight: FontWeight.bold, color: Colors.red)),
              Text(widget.description, style: const TextStyle(fontSize: FontSizeValue.MEDIUM), textAlign: TextAlign.center),
              SizedBox(height: size.height * 0.01),
              // PublicButton(
              //     onTap: () async {
              //
              //     },
              //     title: "Tekrar Dene!",
              //     color: Colors.blue,
              //     textColor: AppColors.white,
              //     buttonHeight: 0.07,
              //     buttonWidth: 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
