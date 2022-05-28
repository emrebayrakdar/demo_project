import 'dart:convert';
import 'dart:math';
import 'package:demo_project/base/enums/auth_type_enum.dart';


import 'dart:convert';

class UserModel {
  UserModel({
    this.authType,
    this.extraData,
  });

  AuthType? authType;
  Map<String, dynamic>? extraData;

  UserModel.initial()
      : authType = AuthType.Uninitialized,
        extraData = null;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel();

  Map<String, dynamic> toJson() => {};
}
