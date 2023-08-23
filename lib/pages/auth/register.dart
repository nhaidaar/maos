import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos/pages/auth/login.dart';
import 'package:maos/pages/auth/upload_profile_picture.dart';
import 'package:maos/widgets/custom_form.dart';
import 'package:page_transition/page_transition.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../shared/methods.dart';
import '../../shared/theme.dart';
import '../home/home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool areFieldsEmpty = true;
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    nameController.addListener(updateFieldState);
    emailController.addListener(updateFieldState);
    passwordController.addListener(updateFieldState);
  }

  @override
  void dispose() {
    nameController.removeListener(updateFieldState);
    emailController.removeListener(updateFieldState);
    passwordController.removeListener(updateFieldState);
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  void updateFieldState() {
    setState(() {
      areFieldsEmpty = emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          nameController.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          // Update user display name
          FirebaseAuth.instance.currentUser!
              .updateDisplayName(nameController.text);
          // Navigating to the upload profile picture screen if the user is authenticated
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const UploadProfilePicture(),
              ),
              (route) => false);
        }
        if (state is AuthError) {
          // Showing the error message if the user has entered invalid credentials
          showBottomSnackbar(context, state.e, true);
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
                          // Logo
                          Image.asset(
                            'assets/images/navicon.png',
                            scale: 2.5,
                          ),

                          const Spacer(),

                          // Skip Auth Button
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
                      CustomFormField(
                        focusNode: nameFocusNode,
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        hintText: 'Type your name',
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
                      CustomFormField(
                        focusNode: emailFocusNode,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        hintText: 'Type your email',
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
                        focusNode: passwordFocusNode,
                        controller: passwordController,
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: !_passwordVisible
                                ? Image.asset(
                                    'assets/icons/password_visible.png',
                                  )
                                : Image.asset(
                                    'assets/icons/password_invisible.png',
                                  ),
                          ),
                          hintText: 'Type your password',
                          contentPadding: const EdgeInsets.all(20),
                          hintStyle: mediumTS.copyWith(
                              color: greyBlur40, fontSize: 14),
                          border: defaultInputBorder,
                          enabledBorder: defaultInputBorder,
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // If one of field empty, disable the register button
                      !areFieldsEmpty
                          ? GestureDetector(
                              onTap: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthSignUp(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
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
                            )
                          : Opacity(
                              opacity: 0.2,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
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

                      const SizedBox(
                        height: 12,
                      ),
                      Row(
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
                      const SizedBox(
                        height: 12,
                      ),

                      // Register with Google Button (Coming Soon)
                      GestureDetector(
                        onTap: () {
                          showLoadingDialog(context, 'Please wait...');
                          showTopSnackbar(
                              context, 'This feature is coming soon!', true);
                          Navigator.pop(context);
                        },
                        child: Container(
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
                onTap: () {
                  Navigator.of(context).push(
                    PageTransition(
                      child: const LoginPage(),
                      type: PageTransitionType.leftToRight,
                      childCurrent: widget,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(24),
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      style: mediumTS.copyWith(fontSize: 14, color: greyBlur60),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: semiboldTS.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
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
