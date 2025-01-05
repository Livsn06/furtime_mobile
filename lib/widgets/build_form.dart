import 'package:flutter/material.dart';
import 'package:furtime/utils/_constant.dart';

Widget textFormInput({
  label,
  controller,
  isEmail = false,
  isPassword = false,
  isName = false,
  maxLine = 1,
  Color? hintColor,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLine,
    decoration: InputDecoration(
      hintText: label,
      border: const OutlineInputBorder(),
      prefixIcon: isEmail
          ? const Icon(Icons.email_outlined)
          : isPassword
              ? const Icon(Icons.lock_outline)
              : isName
                  ? const Icon(Icons.person_outline)
                  : null,
      prefixIconColor: hintColor ?? APP_THEME.value.colorScheme.primaryFixedDim,
      hintStyle: TextStyle(
        color: hintColor ?? APP_THEME.value.colorScheme.primaryFixedDim,
      ),
      constraints: BoxConstraints(
        maxWidth: SCREEN_SIZE.value.width,
        minWidth: SCREEN_SIZE.value.width / 2,
      ),
    ),
    validator: validator,
  );
}

Widget customButton({label, Function()? onPress, color}) {
  return MaterialButton(
    textColor: Colors.white,
    minWidth: SCREEN_SIZE.value.width,
    color: color ?? APP_THEME.value.colorScheme.secondary,
    onPressed: onPress,
    child: Text(label),
  );
}

Widget authNavigation({label, text, Function()? onPress}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      TextButton(
        onPressed: onPress,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
