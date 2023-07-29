import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String capitalizeFirstLetter(String input) {
  if (input.isEmpty) return '';

  final firstLetter = input[0].toUpperCase();
  final restOfString = input.substring(1).toLowerCase();

  return '$firstLetter$restOfString';
}

Future<bool> doesAssetExist(String assetName) async {
  try {
    // Attempt to load the asset. If it exists, it will return the ByteData.
    await rootBundle.load(assetName);
    // If there is no exception, the asset exists.
    return true;
  } catch (error) {
    // If an exception occurs, the asset doesn't exist.
    return false;
  }
}

void showCustomSnackbar(BuildContext context, String? msg) {
  Flushbar(
    message: msg ?? 'This feature is coming soon!',
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Colors.red,
    duration: const Duration(seconds: 2),
  ).show(context);
}

String replaceSpecialCharacters(String input) {
  return input
      .replaceAll('“', '"')
      .replaceAll('”', '"')
      .replaceAll('‘', '\'')
      .replaceAll('’', '\'')
      .replaceAll('ā', 'a')
      .replaceAll("…", '...')
      .replaceAll('—', '--');
}
