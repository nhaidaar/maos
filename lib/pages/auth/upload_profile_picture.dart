// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/methods.dart';
import '../../shared/theme.dart';
import '../home/home.dart';

class UploadProfilePicture extends StatefulWidget {
  const UploadProfilePicture({super.key});

  @override
  State<UploadProfilePicture> createState() => _UploadProfilePictureState();
}

class _UploadProfilePictureState extends State<UploadProfilePicture> {
  Uint8List? pickedImage;

  Future<void> handleImageUpload() async {
    try {
      // Loading
      showLoadingDialog(context, 'Uploading your picture...');
      // Upload the image
      final url = await uploadImageToStorage(
          FirebaseAuth.instance.currentUser!.uid, pickedImage!);
      // Change the user profile pict URL
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      // Pop Loading when Success
      Navigator.pop(context);
      // Show Success Snackbar
      showBottomSnackbar(
          context, 'Your image was completedly uploaded!', false);
      // Navigate to Home
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      // Pop Loading when Failed
      Navigator.pop(context);
      // Show Error Snackbar
      showTopSnackbar(context, e.code, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/navicon.png',
                    scale: 2.5,
                  ),

                  const Spacer(),

                  // Skip Upload Profile Picture Button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                          (route) => false);
                    },
                    child: Text(
                      'Skip',
                      style: mediumTS,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),

              // Title
              Text(
                'Set Your Profile Pict!',
                style: semiboldTS.copyWith(fontSize: 32),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your account was created!, next set up your best\nprofile picture.',
                style: mediumTS.copyWith(
                    fontSize: 14, color: greyBlur60, height: 1.7),
              ),
              const SizedBox(
                height: 70,
              ),

              // Display Image Widget
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: pickedImage != null
                              ? DecorationImage(
                                  image: MemoryImage(pickedImage!),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  scale: 2,
                                  image: AssetImage(
                                    'assets/icons/profile_picture_skeleton.png',
                                  ),
                                ),
                        ),
                      ),
                      Container(
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          border: Border.all(color: whiteColor, width: 20),
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 24,
              ),

              // Insert Image Widget
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Uint8List? img = await pickImage(ImageSource.gallery);
                      setState(() {
                        if (img != null) {
                          pickedImage = img;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: greyColor, width: 1.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            pickedImage != null
                                ? Image.asset(
                                    'assets/icons/profile_picture_add.png',
                                    width: 24,
                                    height: 24,
                                  )
                                : Image.asset(
                                    'assets/icons/profile_picture_change.png',
                                    width: 24,
                                    height: 24,
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            pickedImage != null
                                ? Text(
                                    'Change Image',
                                    style: semiboldTS.copyWith(
                                        fontSize: 14, color: blackColor),
                                  )
                                : Text(
                                    'Upload Image',
                                    style: semiboldTS.copyWith(
                                        fontSize: 14, color: blackColor),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // Upload Image Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: pickedImage != null
          ? GestureDetector(
              onTap: handleImageUpload,
              child: Container(
                height: 56,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    'Done',
                    style: semiboldTS.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : Opacity(
              opacity: 0.2,
              child: Container(
                height: 56,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    'Done',
                    style: semiboldTS.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
