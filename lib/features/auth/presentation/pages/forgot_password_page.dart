import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos/core/common/themes.dart';
import 'package:maos/core/common/widgets/custom_appbar.dart';

import '../../../../core/common/fontstyles.dart';
import '../../../../core/common/widgets/custom_button.dart';
import '../../../../core/common/widgets/custom_snackbar.dart';
import '../../../../core/common/widgets/custom_textfield.dart';
import '../../../../init_dependencies.dart';
import '../bloc/auth_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  bool isEmailEmpty = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(updateEmailState);
  }

  @override
  void dispose() {
    _emailController.removeListener(updateEmailState);
    _emailController.dispose();
    super.dispose();
  }

  void updateEmailState() {
    setState(() => isEmailEmpty = _emailController.text.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthPasswordReseted) {
            showSnackbar(context, message: 'Password reset link has been sent to your email!');
          }

          if (state is AuthError) showSnackbar(context, message: state.message, isError: true);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: customAppBar(context),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      // Title
                      Text(
                        'Forgot Password',
                        style: semiboldTS.copyWith(fontSize: 32),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'To reset your password, we have to sent link for reset password in to your active email.',
                        style: mediumTS.copyWith(color: Theme.of(context).appColors.neutral60),
                      ),

                      const SizedBox(height: 28),

                      // Email Form
                      CustomForm(
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        hint: 'Type your email',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: state is AuthLoading
                      ? CustomLoadingButton()
                      : CustomButton(
                          onTap: () => context.read<AuthBloc>().add(AuthResetPassword(email: _emailController.text)),
                          text: 'Done',
                          disabled: isEmailEmpty,
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
