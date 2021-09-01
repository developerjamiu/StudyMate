import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_mate/features/authentication/views/forgot_password_view.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/widgets/widgets.dart';
import '../controllers/login_controller.dart';
import 'register_view.dart';

class LoginView extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = context.read(loginControllerProvider);

    final emailAddressController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Statusbar(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          trailing: TextButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => RegisterView()),
            ),
            child: Text('Create Account'),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Hero(
                        tag: 'auth-title',
                        child: CustomText.headline6(
                          'Welcome back to your\nPersonal Assistant',
                        ),
                      ),
                      Spacing.height(14),
                      Hero(
                        tag: 'auth-text',
                        child: CustomText.bodyText1('Let’s get you started...'),
                      ),
                      Spacing.largeHeight(),
                      CustomTextField(
                        labelText: 'Email Address',
                        controller: emailAddressController,
                        keyboardType: TextInputType.emailAddress,
                        validator: context.validateEmailAddress,
                      ),
                      Spacing.bigHeight(),
                      Consumer(
                        builder: (_, ScopedReader watch, __) {
                          final loginController =
                              watch(loginControllerProvider);

                          return CustomTextField(
                            labelText: 'Password',
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !loginController.passwordVisible,
                            suffixIcon: IconButton(
                              icon: loginController.passwordVisible
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            validator: context.validatePassword,
                          );
                        },
                      ),
                      Spacing.smallHeight(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (_) => ForgotPasswordView(),
                            );
                          },
                          child: Text('Forgot Password'),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacing.mediumHeight(),
                Hero(
                  tag: 'auth-button',
                  child: Consumer(
                    builder: (_, watch, __) => AppElevatedButton(
                      isLoading: watch(loginControllerProvider).state ==
                          AppState.loading,
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        if (_formKey.currentState!.validate()) {
                          await context.read(loginControllerProvider).loginUser(
                                emailAddress:
                                    emailAddressController.text.trim(),
                                password: passwordController.text,
                              );
                        }
                      },
                      label: 'Login',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
