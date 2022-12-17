// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import 'Colors.dart';

BoxDecoration ButtonDecoration = BoxDecoration(
  border: Border.all(color: Colors.grey.withOpacity(0.2)),
  borderRadius: BorderRadius.circular(40),
);

BoxDecoration CircularGreyDecoration = BoxDecoration(
  color: appStore.isDarkModeOn ? cardDarkColor : primaryGreyColor,
  borderRadius: BorderRadius.circular(45),
);
BoxDecoration CircularBlackDecoration = BoxDecoration(
  color: appStore.isDarkModeOn ? Colors.blue : Colors.blue,
  borderRadius: BorderRadius.circular(45),
);

ButtonStyle ElevatedButtonStyle1 = ButtonStyle(
  minimumSize: const MaterialStatePropertyAll(Size(160, 45)),
  maximumSize: const MaterialStatePropertyAll(Size(160, 45)),
  elevation: const MaterialStatePropertyAll(0),
  side: const MaterialStatePropertyAll(BorderSide(color: Colors.black54)),
  backgroundColor: const MaterialStatePropertyAll(Colors.white),
  foregroundColor: const MaterialStatePropertyAll(Colors.black),
  shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(45))),
);
