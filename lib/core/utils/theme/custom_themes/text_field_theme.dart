import 'package:flutter/material.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  static final InputDecorationTheme lightInputDecorationTheme =
      InputDecorationTheme(
        errorMaxLines: 3,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
        hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
        errorStyle: const TextStyle(fontSize: 12, color: Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.orange),
        ),
      );

  static const InputDecorationTheme darkInputDecorationTheme =
      InputDecorationTheme(
        errorMaxLines: 3,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        labelStyle: TextStyle(fontSize: 14, color: Colors.white),
        hintStyle: TextStyle(fontSize: 14, color: Colors.white70),
        errorStyle: TextStyle(fontSize: 12, color: Colors.redAccent),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
      );
}
