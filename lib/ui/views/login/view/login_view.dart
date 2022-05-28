import 'package:demo_project/base/helpers/toast/toast_helper.dart';
import 'package:demo_project/base/init/navigation/navigation_service.dart';
import 'package:demo_project/base/view/view_model_builder.dart';
import 'package:demo_project/ui/_products/constants/enums/navigation_constants.dart';
import 'package:demo_project/ui/_products/shared/app_colors.dart';
import 'package:demo_project/ui/_products/shared/ui_helpers.dart';
import 'package:demo_project/ui/_products/widgets/auth_shared/auth_shared.dart';
import 'package:demo_project/ui/_products/widgets/custom_text_form_field.dart';
import 'package:demo_project/ui/_products/widgets/public_button.dart';
import 'package:demo_project/ui/views/login/viewmodel/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.withoutConsumer(
      viewModelBuilder: () => LoginViewModel(),
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
              backgroundColor: Colors.transparent,
              body: _buildMain(viewModel, size),
            )
          ],
        );
      },
    );
  }

  Widget _buildMain(LoginViewModel viewModel, Size size) => Center(
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
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [buildBall(size), buildTitle(size)],
                  ),
                  _buildLoginForm(viewModel, size),
                ],
              ),
            )),
      );

  Widget _buildLoginForm(LoginViewModel viewModel, Size size) => Container(
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
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Giriş Yap", style: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeValue.XXXLARGE, color: Colors.white)),
                const SizedBox(height: 8),
                const Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: FontSizeValue.SMALL, color: Colors.white)),
                const SizedBox(height: 24),
                customTextFormField("Kullanıcı Adı", "Kullanıcı adı giriniz.", Icons.person, viewModel.userNameTextController),
                customTextFormField("Şifre", "Şifre giriniz.", Icons.lock, viewModel.passwordTextController, isObscureText: true),
                _buildRememberMe(),
                PublicButton(
                  title: "Giriş Yap",
                  color: AppColors.primaryColor,
                  textColor: AppColors.white,
                  onTap: () async {
                    ToastHelper.warning(context, "Uyarı", "Kayıt Ol ekranından giriş yapılabilir.", showTime: 2200);
                  },
                  buttonHeight: 0.06,
                  buttonWidth: 1,
                  textStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: FontSizeValue.XLARGE, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                      text: "Hesabınız yok mu ?" + " ",
                      style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Kayıt Ol.",
                            style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                NavigationService.instance.navigateToPage(path: NavigationConstants.REGISTER);
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Row _buildRememberMe() => Row(
        children: [
          Checkbox(
            value: false,
            activeColor: AppColors.primaryColor,
            visualDensity: VisualDensity.compact,
            onChanged: (bool? value) {},
          ),
          const Expanded(
            child: Text(
              "Beni Hatırla",
              style: TextStyle(fontSize: FontSizeValue.XSMALL),
              maxLines: 2,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );
}
