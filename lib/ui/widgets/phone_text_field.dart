import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reservation_site/utils/collection_reg_exp.dart';
import 'package:reservation_site/utils/phone_formatter.dart';

class PhoneTextFormField extends StatelessWidget {
  final TextEditingController phoneController;
  final TextStyle? textStyle;
  final bool autofocus;
  final List<double>? borderRadius;
  final Color? cursorColor;
  final void Function(String)? onChanged;

  const PhoneTextFormField({
  required this.phoneController,
  this.textStyle,
  this.borderRadius,
  this.autofocus = true,
  super.key, this.cursorColor, this.onChanged,
});

@override
Widget build(BuildContext context) {
  final textDefaultStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  return TextFormField(
    onChanged: onChanged,
    autofocus: autofocus,
    textAlignVertical: TextAlignVertical.center,
    textInputAction: TextInputAction.done,
    cursorColor: cursorColor,
    controller: phoneController,
    keyboardType: TextInputType.phone,
    style: textStyle ?? textDefaultStyle,
    validator: (value) => validatePhoneNumber(value) ? null : '',
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      RuNumberTextInputFormatter(),
    ],
    decoration: InputDecoration(
      hintStyle: textDefaultStyle?.copyWith(color: const Color(0xFF999999)),
      // hintText: '(___) ___ __ __',
      errorStyle: const TextStyle(height: 0),
      enabledBorder: border,
      border: border,
      disabledBorder: border,
      errorBorder: errorBorder,
      focusedBorder: border,
      focusedErrorBorder: errorBorder,
      isDense: true,
      fillColor: Colors.white,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIcon: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text('+7', style: textDefaultStyle),
        ),
      ),
      prefixIconConstraints: const BoxConstraints(maxWidth: 32),
    ),
  );
}

InputBorder get border => OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: const BorderSide(color: Colors.white),
);

InputBorder get errorBorder => OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: const BorderSide(color: Colors.red),
);
}
