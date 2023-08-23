// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/methods.dart';
import '../../shared/theme.dart';
import 'widgets/profile_menu.dart';
import 'home.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(
            height: 20,
          ),

          // User Profile Picture
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: user.photoURL != null
                        ? NetworkImage(user.photoURL.toString())
                            as ImageProvider
                        : const AssetImage('assets/images/profile.jpg'),
                  ),
                ),
              ),
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: whiteColor, width: 10),
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 20,
          ),

          // User Display Name
          Text(
            '${user.displayName}',
            style: semiboldTS.copyWith(fontSize: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),

          const SizedBox(
            height: 12,
          ),

          // User Joined Time
          Text(
            'Joined in ${user.metadata.creationTime != null ? DateFormat('MMMM y').format(user.metadata.creationTime!) : 'unknown'}',
            style: mediumTS.copyWith(
              color: greyColor,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(
            height: 40,
          ),

          // Profile Menu
          ProfileMenu(
            title: 'Edit Profile',
            iconUrl: 'assets/icons/user_edit.png',
            action: () {
              Navigator.of(context).push(
                PageTransition(
                  child: const EditProfile(),
                  type: PageTransitionType.bottomToTop,
                  childCurrent: this,
                ),
              );
            },
          ),

          Divider(
            thickness: 1,
            color: greyBlur10,
          ),

          ProfileMenu(
            title: 'Help Center',
            iconUrl: 'assets/icons/user_help.png',
            action: () {},
          ),

          Divider(
            thickness: 1,
            color: greyBlur10,
          ),

          ProfileMenu(
            title: 'Log Out',
            iconUrl: 'assets/icons/user_logout.png',
            color: Colors.redAccent,
            isRouted: false,
            action: () {
              showDialog(
                  barrierDismissible: false,
                  barrierColor: greyBlur25,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      alignment: Alignment.center,
                      insetPadding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      content: Container(
                        height: 150,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Are you sure to log out?',
                              style: semiboldTS.copyWith(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context.read<AuthBloc>().add(AuthSignOut());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: blackColor, width: 1.5),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: FittedBox(
                                      child: Text(
                                        'Yes, I\'m Out',
                                        style:
                                            semiboldTS.copyWith(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: blackColor,
                                      border: Border.all(
                                          color: blackColor, width: 1.5),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: FittedBox(
                                      child: Text(
                                        'Nevermind',
                                        style: semiboldTS.copyWith(
                                            fontSize: 12, color: whiteColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      );
    } else {
      return const LoginRequired();
    }
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final currentPasswordController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final newPasswordFocusNode = FocusNode();
  final currentPasswordFocusNode = FocusNode();

  bool _newPasswordVisible = true;
  bool _currentPasswordVisible = true;
  String recentEmail = '';
  Uint8List? pickedImage;

  Future<void> handleUpdateProfile() async {
    showLoadingDialog(context, 'Updating your profile...');
    try {
      await user!.reauthenticateWithCredential(EmailAuthProvider.credential(
          email: recentEmail, password: currentPasswordController.text));
      if (newPasswordController.text.isNotEmpty) {
        await user!.updatePassword(newPasswordController.text);
      }
      if (recentEmail != emailController.text) {
        await user!.updateEmail(emailController.text);
      }
      if (pickedImage != null) {
        final url = await uploadImageToStorage(user!.uid, pickedImage!);
        await user!.updatePhotoURL(url);
      }
      await user!.updateDisplayName(nameController.text);
      Navigator.pop(context);
      // Show Success Snackbar
      showBottomSnackbar(
          context, 'Your profile was completedly updated!', false);
      // Navigate to Home
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // Show Error Snackbar
      if (e.code == 'channel-error') {
        showTopSnackbar(context, 'Please insert your current password!', true);
      } else {
        showTopSnackbar(context, e.code, true);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = user!.displayName.toString();
    emailController.text = user!.email.toString();
    recentEmail = user!.email.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        backgroundColor: whiteBackground,
        elevation: 0,
        leadingWidth: 68,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 48,
            width: 48,
            margin: const EdgeInsets.only(left: 18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: greyBlur20),
            ),
            child: Center(
              child: Image.asset(
                'assets/icons/news_back.png',
                width: 24,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: pickedImage != null
                                ? DecorationImage(
                                    image: MemoryImage(pickedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image:
                                        NetworkImage(user!.photoURL.toString()),
                                    fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            border: Border.all(color: whiteColor, width: 10),
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
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
                          vertical: 10,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: greyColor, width: 1.5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/profile_picture_change.png',
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Change Image',
                                style: semiboldTS,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                // Name Form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: semiboldTS.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      focusNode: nameFocusNode,
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Type your name',
                        contentPadding: const EdgeInsets.all(16),
                        hintStyle:
                            mediumTS.copyWith(color: greyBlur40, fontSize: 13),
                        border: defaultInputBorder,
                        enabledBorder: defaultInputBorder,
                        focusedBorder: defaultInputBorder,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // Email Form
                    Text(
                      'Email',
                      style: semiboldTS.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      focusNode: emailFocusNode,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Type your email',
                        contentPadding: const EdgeInsets.all(16),
                        hintStyle:
                            mediumTS.copyWith(color: greyBlur40, fontSize: 13),
                        border: defaultInputBorder,
                        enabledBorder: defaultInputBorder,
                        focusedBorder: defaultInputBorder,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // New Password Form
                    Text(
                      'New Password',
                      style: semiboldTS.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      focusNode: newPasswordFocusNode,
                      controller: newPasswordController,
                      obscureText: _newPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _newPasswordVisible = !_newPasswordVisible;
                            });
                          },
                          icon: !_newPasswordVisible
                              ? Image.asset(
                                  'assets/icons/password_visible.png',
                                )
                              : Image.asset(
                                  'assets/icons/password_invisible.png',
                                ),
                        ),
                        hintText: 'Leave blank if won\'t change your password',
                        contentPadding: const EdgeInsets.all(16),
                        hintStyle:
                            mediumTS.copyWith(color: greyBlur40, fontSize: 13),
                        border: defaultInputBorder,
                        enabledBorder: defaultInputBorder,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // Current Password Form
                    Text(
                      'Current Password',
                      style: semiboldTS.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      focusNode: currentPasswordFocusNode,
                      controller: currentPasswordController,
                      obscureText: _currentPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _currentPasswordVisible =
                                  !_currentPasswordVisible;
                            });
                          },
                          icon: !_currentPasswordVisible
                              ? Image.asset(
                                  'assets/icons/password_visible.png',
                                )
                              : Image.asset(
                                  'assets/icons/password_invisible.png',
                                ),
                        ),
                        hintText: 'Type your current password',
                        contentPadding: const EdgeInsets.all(16),
                        hintStyle:
                            mediumTS.copyWith(color: greyBlur40, fontSize: 13),
                        border: defaultInputBorder,
                        enabledBorder: defaultInputBorder,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: whiteBackground,
        elevation: 0,
        child: GestureDetector(
          onTap: handleUpdateProfile,
          child: Container(
            height: 56,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                'Update',
                style: semiboldTS.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
