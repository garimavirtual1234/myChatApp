import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CommonTextfield extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool? isObscure;
  final bool? isEnabled;
  final TextInputType? keyboardType;
  const CommonTextfield({super.key,
  required this.textController,
    required this.hintText,
     this.isEnabled,
    this.keyboardType,
required this.validator, required this.labelText,
  this.isObscure
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: isObscure??false,
        enabled: isEnabled,
        controller: textController,
        cursorColor: Colors.yellow,
        style: const TextStyle(
          color: Colors.white
        ),
        decoration:  InputDecoration(
          labelStyle: const TextStyle(
            color: Colors.yellow
          ),
          labelText: labelText,
          focusColor: Colors.yellow,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.yellow
              )
          ),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.yellow
              )
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.yellow
              )
          ),

          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white
          )
        ),
        validator: validator
    );
  }
}
