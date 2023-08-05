import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maos/theme.dart';

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

void showBottomSnackbar(BuildContext context, String text, bool isError) {
  AnimatedSnackBar(
    snackBarStrategy: RemoveSnackBarStrategy(),
    builder: (context) {
      return Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: greyBlur10),
            color: const Color(0xffFFFFFF),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: semiboldTS,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              !isError
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xff00A47D),
                    )
                  : const Icon(
                      Icons.error_rounded,
                      color: Color(0xffEA4335),
                    ),
            ],
          ),
        ),
      );
    },
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  ).show(context);
}

void showTopSnackbar(BuildContext context, String text, bool isError) {
  AnimatedSnackBar(
    snackBarStrategy: RemoveSnackBarStrategy(),
    builder: (context) {
      return Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: greyBlur10),
            color: const Color(0xffFFFFFF),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: semiboldTS,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              !isError
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: Color(0xff00A47D),
                    )
                  : const Icon(
                      Icons.error_rounded,
                      color: Color(0xffEA4335),
                    ),
            ],
          ),
        ),
      );
    },
    mobileSnackBarPosition: MobileSnackBarPosition.top,
  ).show(context);
}

void showLoadingDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: blackColor,
            ),
            const SizedBox(width: 16.0),
            Text(
              text,
              style: semiboldTS,
            ),
          ],
        ),
      ),
    ),
  );
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

Future pickImage(ImageSource source) async {
  XFile? img = await ImagePicker().pickImage(source: source);
  if (img != null) {
    return await img.readAsBytes();
  }
}

Future<String> uploadImageToStorage(String uid, Uint8List image) async {
  final storageRef =
      FirebaseStorage.instance.ref().child('profilePictures/$uid.jpg');

  // Upload the file to Firebase Storage
  final uploadTask = storageRef.putData(image);

  // Get the download URL
  final snapshot = await uploadTask;
  final downloadURL = await snapshot.ref.getDownloadURL();

  // Return the download URL
  return downloadURL;
}
