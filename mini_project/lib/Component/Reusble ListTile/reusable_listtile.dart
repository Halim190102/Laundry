import 'package:flutter/material.dart';
import 'package:mini_project/Component/Theme/theme.dart';

Widget listTile({
  required int value,
  required int groupValue,
  required String title,
  required Function(int?)? change,
}) {
  return SizedBox(
    width: 140,
    child: ListTile(
      leading: Radio<int>(
        groupValue: groupValue,
        onChanged: change,
        value: value,
        activeColor: ThemesColor().primaryBar,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 12),
      ),
    ),
  );
}
