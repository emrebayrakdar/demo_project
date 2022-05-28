import 'dart:math' as math;

import 'package:demo_project/base/view/view_model_builder.dart';
import 'package:demo_project/ui/_products/shared/app_colors.dart';
import 'package:demo_project/ui/_products/shared/ui_helpers.dart';
import 'package:demo_project/ui/_products/widgets/auth_shared/auth_shared.dart';
import 'package:demo_project/ui/_products/widgets/custom_text_form_field.dart';
import 'package:demo_project/ui/_products/widgets/public_button.dart';
import 'package:demo_project/ui/views/register/viewmodel/register_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.withoutConsumer(
      viewModelBuilder: () => RegisterViewModel(),
      onInitState: (viewModel) {
        viewModel.setContext(context);
        viewModel.init(this);
      },
      onPageBuilder: (context, viewModel, child, size) {
        return Stack(
          children: [
            buildBackgroundImage(context),
            buildTopShadow(),
            buildBottomShadow(),
            Scaffold(
              // appBar: AppBar(
              //   leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: AppColors.nearlyWhite), onPressed: () => Navigator.of(context).pop()),
              //   backgroundColor: Colors.transparent,
              //   elevation: 0.0,
              //   //No shadow
              // ),
              backgroundColor: Colors.transparent,
              body: _buildMain(viewModel, size),
            )
          ],
        );
      },
    );
  }



  Widget _buildMain(RegisterViewModel viewModel, Size size) => Center(
        child: Container(
            padding: const EdgeInsets.only(top: 40),
            width: UIHelper.width(80),
            height: UIHelper.height(90),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              color: const Color.fromRGBO(49, 53, 59, 1).withOpacity(0.33),
              border: Border.all(color: const Color.fromRGBO(0, 0, 0, 1), width: 1),
            ),
            child: SingleChildScrollView(
              controller: viewModel.scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [buildBall(size), buildTitle(size)],
                  ),
                  _buildRegisterForm(viewModel, size),
                ],
              ),
            )),
      );


  Widget _buildRegisterForm(RegisterViewModel viewModel, Size size) => Container(
        height: UIHelper.height(75),
        width: UIHelper.width(70),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
          color: Color(0xFF373331),
        ),
        child: SingleChildScrollView(
          controller: viewModel.scrollController,
          physics: BouncingScrollPhysics(),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Kayıt Ol", style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeValue.XXXLARGE, color: Colors.white)),
                const SizedBox(height: 8),
                const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: FontSizeValue.SMALL, color: Colors.white)),
                const SizedBox(height: 8),
                customTextFormField("Mail", "E-Mail adresinizi giriniz.", Icons.email_outlined, viewModel.mailTextController),
                customTextFormField("Kullanıcı Adı", "Kullanıcı adınızı giriniz.", Icons.person, viewModel.userNameTextController),
                customTextFormField("Şifre", "Şifre giriniz.", Icons.lock, viewModel.passwordTextController, isObscureText: true),
                customTextFormField("Şifre Tekrar", "Tekrar şifrenizi giriniz.", Icons.lock, viewModel.passwordAgainTextController, isObscureText: true),
                _buildCheckbox1(),
                _buildCheckbox2(),
                PublicButton(
                  title: "Kayıt Ol",
                  color: AppColors.primaryColor,
                  textColor: AppColors.white,
                  onTap: () async {
                    viewModel.register();
                  },
                  buttonHeight: 0.05,
                  buttonWidth: 1,
                  textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: FontSizeValue.XLARGE, color: Colors.white),
                ),
                 SizedBox(height: 24),

              ],
            ),
          ),
        ),
      );

  Row _buildCheckbox1() => Row(
        children: [
          Checkbox(
            value: true,
            activeColor: AppColors.primaryColor,
            visualDensity: VisualDensity.compact,
            onChanged: (bool? value) {},
          ),
          const Expanded(
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              style: TextStyle(fontSize: FontSizeValue.XSMALL),
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );

  Row _buildCheckbox2() => Row(
        children: [
          Checkbox(
            value: false,
            activeColor: AppColors.primaryColor,
            visualDensity: VisualDensity.compact,
            onChanged: (bool? value) {
              setState(() {
                value = true;
              });
            },
          ),
          const Expanded(
            child: Text(
              "Lorem Ipsum",
              style: TextStyle(fontSize: FontSizeValue.XSMALL),
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );



}
