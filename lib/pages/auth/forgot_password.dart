// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../shared/methods.dart';
import '../../shared/theme.dart';
import '../../widgets/custom_form.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  bool isEmailEmpty = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateEmailState);
  }

  @override
  void dispose() {
    emailController.removeListener(updateEmailState);
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  void updateEmailState() {
    setState(() {
      isEmailEmpty = emailController.text.isEmpty;
    });
  }

  Future<void> handleForgotPassword() async {
    try {
      // Loading dialog
      showLoadingDialog(context, 'Processing...');
      // Send Password Reset Email
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      // If success, pop loading dialog
      Navigator.pop(context);
      // Show success dialog
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
                height: 247,
                padding:
                    const EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: greyBlur60)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/email_sent.png',
                      scale: 2,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Password reset link has been\nsent to your email!',
                      style: semiboldTS.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor, width: 2),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: FittedBox(
                          child: Text(
                            'Understand',
                            style: semiboldTS.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    } on FirebaseAuthException catch (e) {
      // If error, pop loading dialog
      Navigator.pop(context);
      // Show error dialog
      showTopSnackbar(context, e.code, true);
    }
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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Forgot Password',
                  style: semiboldTS.copyWith(fontSize: 32),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'To reset your password, we have to sent link for reset password in to your active email.',
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
                CustomFormField(
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: 'Type your email',
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),

        // Forgot Password Button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !isEmailEmpty
            ? GestureDetector(
                onTap: handleForgotPassword,
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
              ));
  }
}
