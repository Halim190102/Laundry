import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textField({
  required TextEditingController controller,
  required String lable,
  required String? Function(String?)? valid,
  required String? Function(String?)? onChange,
  required bool boolean,
  required AutovalidateMode submit,
  Widget? icon,
}) {
  return TextFormField(
    autovalidateMode: submit,
    onChanged: onChange,
    obscureText: boolean,
    validator: valid,
    controller: controller,
    cursorColor: Colors.white,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      errorStyle: const TextStyle(
        color: Colors.white,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 18.5),
      hintText: lable,
      hintStyle: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
      border: const UnderlineInputBorder(),
      isDense: true,
      suffixIcon: icon,
    ),
  );
}

Widget textField1({
  required String? Function(String?)? onChange,
  required String lable,
  required TextInputType type,
  required TextInputFormatter format,
  Widget? icon,
}) {
  return SizedBox(
    width: 120,
    child: TextFormField(
      inputFormatters: [format],
      keyboardType: type,
      onChanged: onChange,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: lable,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.5),
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black,
        ),
        border: const UnderlineInputBorder(),
        isDense: true,
        suffixIcon: icon,
      ),
    ),
  );
}
