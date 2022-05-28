import 'package:demo_project/ui/_products/shared/app_colors.dart';
import 'package:demo_project/ui/_products/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customTextFormField(String title, String hintText, IconData prefixIcon, TextEditingController controller, {bool isObscureText = false, Function? validator}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(title, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: FontSizeValue.NORMAL, color: Colors.white)),
    const SizedBox(height: 5),
    TextFormField(
        controller: controller,
        obscureText: isObscureText,
        validator: (val) {
          if (validator != null) validator((val == null || val.isEmpty) ? null : val);
        },
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          prefixIcon: IconButton(color: Colors.white, icon: Icon(prefixIcon, color: Colors.white), onPressed: () {}),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  const BorderSide(
              color: AppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.hintGrey, fontWeight: FontWeight.bold, fontSize: FontSizeValue.SMALL),
          labelStyle: TextStyle(color: AppColors.hintGrey, fontWeight: FontWeight.bold, fontSize: FontSizeValue.SMALL),
        )),
    const SizedBox(height: 8),
  ],
);