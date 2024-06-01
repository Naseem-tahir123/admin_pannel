import 'package:admin_pannel/utils/app_constants.dart';
import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final String? initialValue;
  final Widget? prefixicon;
  final Widget? suffixicon;
  final bool obscureText;
  final int? length;
  final int? lines;
  final TextInputType? keyboard;
  final TextInputAction? inputAction;
  final String? Function(String?)? validate;
  final Function(String)? onchanged;
  const TextFields(
      {super.key,
      this.controller,
      required this.text,
      this.prefixicon,
      this.obscureText = false, // by default false rakha hy
      this.validate,
      this.initialValue,
      this.onchanged,
      this.length,
      this.lines,
      this.keyboard,
      this.inputAction,
      this.suffixicon});

  // final FormField = GlobalKey<FormState>;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 5,
        // bottom: 5,
      ),
      child: TextFormField(
        cursorColor: AppConstants.appMainColor,
        controller: controller,
        maxLength: length,
        maxLines: lines,
        onChanged: onchanged,
        keyboardType: keyboard,
        initialValue: initialValue,
        textInputAction: inputAction,
        obscureText: obscureText,
        validator: validate,
        decoration: InputDecoration(
          hintText: text,
          fillColor: const Color(0xffF8F9FA),
          filled: true,
          prefixIcon: prefixicon,
          suffixIcon: suffixicon,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 3, color: AppConstants.appScendoryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            // borderSide: const BorderSide(color: Color(0xffE4e7EB)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
