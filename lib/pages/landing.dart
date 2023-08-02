// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maos/blocs/auth/auth_bloc.dart';
import 'package:maos/shared/methods.dart';
import 'package:maos/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigating to the dashboard screen if the user is authenticated
          Navigator.pushReplacementNamed(context, '/home');
        }
        if (state is AuthError) {
          // Showing the error message if the user has entered invalid credentials
          showSnackbar(context, state.e, true);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            // Showing the loading indicator while the user is signing in
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: whiteColor,
                color: blackColor,
              ),
            );
          }
          return Scaffold(
            backgroundColor: whiteBackground,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/navicon.png',
                            scale: 2.5,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
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
                      Text(
                        'Hi, Welcome Back!',
                        style: semiboldTS.copyWith(fontSize: 32),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'We\'re happy to see you again!, please login to\ncontinue your reading.',
                        style: mediumTS.copyWith(
                            fontSize: 14, color: greyBlur60, height: 1.7),
                      ),
                      const SizedBox(
                        height: 28,
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
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Type your email',
                          contentPadding: const EdgeInsets.all(20),
                          hintStyle: mediumTS.copyWith(
                              color: greyBlur40, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      // Password Form
                      Text(
                        'Password',
                        style: semiboldTS.copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       _passwordVisible = !_passwordVisible;
                          //     });
                          //   },
                          //   icon: _passwordVisible
                          //       ? Image.asset('assets/icons/visible_password.png')
                          //       : Image.asset('assets/icons/invisible_password.png'),
                          // ),
                          hintText: 'Type your password',
                          contentPadding: const EdgeInsets.all(20),
                          hintStyle: mediumTS.copyWith(
                              color: greyBlur40, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: mediumTS.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthSignIn(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: semiboldTS.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: greyBlur10,
                              ),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'or',
                                  style: mediumTS.copyWith(color: greyColor),
                                )),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: greyBlur10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/google.png'),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Login with Google',
                                style: semiboldTS.copyWith(
                                  fontSize: 16,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: const Color(0xffFFFFFF),
              elevation: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/register', (route) => false);
                },
                child: Container(
                  margin: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style:
                            mediumTS.copyWith(fontSize: 14, color: greyBlur60),
                      ),
                      Text(
                        'Register',
                        style: semiboldTS.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Navigating to the dashboard screen if the user is authenticated
          FirebaseAuth.instance.currentUser!
              .updateDisplayName(nameController.text);
          Navigator.pushReplacementNamed(context, '/uploadpp');
        }
        if (state is AuthError) {
          // Showing the error message if the user has entered invalid credentials
          showSnackbar(context, state.e, true);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            // Showing the loading indicator while the user is signing in
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: whiteColor,
                color: blackColor,
              ),
            );
          }
          return Scaffold(
            backgroundColor: whiteBackground,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/navicon.png',
                            scale: 2.5,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', (route) => false);
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
                      Text(
                        'Hi, Welcome!',
                        style: semiboldTS.copyWith(fontSize: 32),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Register first to create a new account and then you can continue your reading.',
                        style: mediumTS.copyWith(
                            fontSize: 14, color: greyBlur60, height: 1.7),
                      ),
                      const SizedBox(
                        height: 28,
                      ),

                      // Name Form
                      Text(
                        'Name',
                        style: semiboldTS.copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Type your name',
                          contentPadding: const EdgeInsets.all(20),
                          hintStyle: mediumTS.copyWith(
                              color: greyBlur40, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
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
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Type your email',
                          contentPadding: const EdgeInsets.all(20),
                          hintStyle: mediumTS.copyWith(
                              color: greyBlur40, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Password Form
                      Text(
                        'Password',
                        style: semiboldTS.copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          // suffixIcon: IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       _passwordVisible = !_passwordVisible;
                          //     });
                          //   },
                          //   icon: _passwordVisible
                          //       ? Image.asset('assets/icons/visible_password.png')
                          //       : Image.asset('assets/icons/invisible_password.png'),
                          // ),
                          hintText: 'Type your password',
                          contentPadding: const EdgeInsets.all(20),
                          hintStyle: mediumTS.copyWith(
                              color: greyBlur40, fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: greyBlur10),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthBloc>(context).add(
                            AuthSignUp(
                              emailController.text,
                              passwordController.text,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              'Register',
                              style: semiboldTS.copyWith(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: greyBlur10,
                              ),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'or',
                                  style: mediumTS.copyWith(color: greyColor),
                                )),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: greyBlur10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/icons/google.png'),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Register with Google',
                                style: semiboldTS.copyWith(
                                  fontSize: 16,
                                  color: blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              color: const Color(0xffFFFFFF),
              elevation: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                child: Container(
                  margin: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have account? ',
                        style:
                            mediumTS.copyWith(fontSize: 14, color: greyBlur60),
                      ),
                      Text(
                        'Login',
                        style: semiboldTS.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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
      showSnackbar(context, 'Your image was completedly uploaded!', false);
      // Navigate to Home
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    } catch (e) {
      // Pop Loading when Failed
      Navigator.pop(context);
      // Show Error Snackbar
      showSnackbar(context, e.toString(), true);
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
                  Image.asset(
                    'assets/images/navicon.png',
                    scale: 2.5,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
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
                height: 90,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: whiteColor, width: 20),
                      color: const Color(0xffFFFFFF),
                      shape: BoxShape.circle,
                      image: pickedImage != null
                          ? DecorationImage(
                              image: MemoryImage(pickedImage!),
                            )
                          : const DecorationImage(
                              scale: 2,
                              image: AssetImage(
                                'assets/icons/profile_picture_skeleton.png',
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Uint8List? img = await pickImage(ImageSource.gallery);
                      setState(() {
                        pickedImage = img;
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
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
