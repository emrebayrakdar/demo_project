import 'package:demo_project/base/model/base_view_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
//#region #init's
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
//#endregion

//#region #variable's
  final formKey = GlobalKey<FormState>();

//#endregion

//#region #override's
  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  void init(State? s) {}

//#endregion

//#region #methods's


//#endregion
}
