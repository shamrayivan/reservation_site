import 'package:flutter/cupertino.dart';
import 'package:reservation_site/utils/phone_formatter.dart';

/// Убираем из номера лишние знаки и добавляем 7
String cleanPhoneNumber({required String number}) {
  if (number.trim().isEmpty) return '';
  return '7${number.replaceAll(RegExp(r'(\D)'), '')}';
}

/// Убираем из номера лишние знаки и добавляем +7
String convenientPhoneNumber({required String number}) {
  final res = number.replaceFirst('7', '');
  final newNumber = RuNumberTextInputFormatter()
      .formatEditUpdate(TextEditingValue(text: res), TextEditingValue(text: res))
      .text;
  return '+7 $newNumber';
}

/// Обратный вариант [cleanPhoneNumber]
String removePrefixPhone({required String number}) {
  final res = number.replaceFirst('7', '');
  return RuNumberTextInputFormatter()
      .formatEditUpdate(TextEditingValue(text: res), TextEditingValue(text: res))
      .text;
}
