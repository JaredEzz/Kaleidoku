import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaleidoku/core/styles/decorations.dart';
import 'package:kaleidoku/core/styles/sizes.dart';
import 'package:kaleidoku/core/utils/extensions/context.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.minLines,
    this.maxLines,
    this.leadingIcon,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.enabled,
    this.trailingIcon,
    this.initialValue,
    this.inputFormatters,
    this.textAlign,
    this.expands,
    this.prefixText,
    this.suffixText,
    this.hintStyle,
    this.autovalidateMode,
  });

  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final bool? expands;
  final String? prefixText;
  final String? suffixText;
  final TextStyle? hintStyle;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kStandardBorderRadius,
      child: TextFormField(
          autovalidateMode: autovalidateMode,
          validator: validator,
          enabled: enabled,
          keyboardType: keyboardType,
          onChanged: onChanged,
          cursorColor: context.primaryColor,
          controller: controller,
          maxLines: maxLines,
          minLines: minLines,
          inputFormatters: inputFormatters,
          style: context.textStyles.mRegular.copyWith(fontSize: 12),
          textAlign: textAlign ?? TextAlign.start,
          expands: expands ?? false,
          decoration: Decorations.inputDecoration.copyWith(
            suffixText: suffixText ?? '',
            prefixText: prefixText ?? '',
            hintText: initialValue,
            labelText: hintText,
            fillColor: Colors.grey.shade100,
            prefixIcon: leadingIcon,
            suffixIcon: trailingIcon,
            hintStyle: hintStyle ??
                context.textStyles.mRegular
                    .copyWith(color: Colors.grey.shade100, fontSize: 12),
            labelStyle: context.textStyles.mRegular
                .copyWith(color: Colors.grey.shade600, fontSize: 12),
          )),
    );
  }
}
