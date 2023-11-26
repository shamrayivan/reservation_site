typedef Validator<T> = bool Function(T? newValue);

/// валидация email
bool validateEmail(String? currentText) {
  if (currentText != null && currentText.trim().isNotEmpty) {
    final bool isValid = _emailRegExp.hasMatch(currentText);
    return isValid;
  }
  return false;
}

final _emailRegExp = RegExp(
  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
);

/// валидация номера телефона
final _phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\-\d\d$');

bool validatePhoneNumber(String? value) {
  final bool isValid = _phoneExp.hasMatch(value ?? '');
  return isValid;
}

bool validatePhoneNumberOrEmpty(String? value) {
  if (value != null && value.isEmpty) return true;
  final bool isValid = _phoneExp.hasMatch(value ?? '');
  return isValid;
}

bool validateAdditionalPhoneNumber(String? value) {
  return (value == null || value.isEmpty) ? true : _phoneExp.hasMatch(value);
}

/// Валидатор для пароля
bool validatePassword(String? currentText) =>
    currentText != null && currentText.length > 5 ? true : false;

/// Валидатор для имени
bool validateNotEmptyString(String? currentText) =>
    currentText != null && currentText.trim().isNotEmpty;

/// Валидатор для любого текста
bool validateEmptyOrString(String? currentText) {
  return currentText != null;
}
