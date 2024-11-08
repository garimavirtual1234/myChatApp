import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class CommonTextfield extends StatefulWidget {
  final TextEditingController controller;
  final bool? readOnly;
  final int maxLine ;
  final Widget? prefixIcon;
  final bool isSecureField;
  final bool autoCorrect;
  final String? hint;
  final TextInputType? inputType;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validation;
  final double hintTextSize;
  final VoidCallback? onTap;
  final bool enable;
  final TextInputAction? textInputAction;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextfield({
    super.key,
    required this.controller,
    required this.maxLine,
    this.prefixIcon,
    this.isSecureField = false,
    this.autoCorrect = false,
    this.enable = true,
    this.inputType,
    this.hint,
    this.validation,
    this.contentPadding,
    this.textInputAction,
    this.hintTextSize = 14,
    this.onTap,
    this.onChange,
    this.onFieldSubmitted,
    this.readOnly,
    this.inputFormatters,
  });

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      obscuringCharacter: '*',
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChange,
      onTap: widget.onTap,
      readOnly: widget.readOnly != null?true:false,
      maxLines: widget.maxLine,
      controller: widget.controller,
      obscureText: widget.isSecureField && !_passwordVisible,
      enableSuggestions: !widget.isSecureField,
      autocorrect: widget.autoCorrect,
      validator: widget.validation,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enable,
      keyboardType: widget.inputType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        //  isCollapsed: true,
          isDense: Theme.of(context).inputDecorationTheme.isDense,
          filled: Theme.of(context).inputDecorationTheme.filled,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          hintStyle:  Theme.of(context).inputDecorationTheme.hintStyle,
          hintText: widget.hint,

          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isSecureField
              ? IconButton(
            icon: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )
              : null,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          border: Theme.of(context).inputDecorationTheme.border
      ) ,
    );

  }
}
