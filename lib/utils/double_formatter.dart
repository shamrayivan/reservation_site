import 'package:flutter/services.dart';

class DoubleFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    return TextEditingValue(
      text: newValue.text.replaceAll(',', '.'),
      selection: TextSelection.collapsed(offset: newValue.selection.end),
    );
  }
}
