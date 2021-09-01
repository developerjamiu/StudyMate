import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/widgets/widgets.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();

  late final emailAddressController = TextEditingController();

  @override
  void dispose() {
    emailAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.all(24.0) + MediaQuery.of(context).viewInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacing.smallHeight(),
              Text(
                'Forgot your password?',
                style: Theme.of(context).textTheme.headline6,
              ),
              Spacing.smallHeight(),
              Divider(color: Colors.black87),
              Spacing.smallHeight(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Confirm your email and we will send you the instructions.',
                    ),
                    Spacing.largeHeight(),
                    CustomTextField(
                      controller: emailAddressController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      validator: context.validateEmailAddress,
                      labelText: 'Email Address',
                    ),
                  ],
                ),
              ),
              Spacing.largeHeight(),
              Consumer(
                builder: (_, watch, __) => AppElevatedButton(
                  isLoading: watch(forgotPasswordControllerProvider).state ==
                      AppState.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(forgotPasswordControllerProvider)
                          .resetPassword(
                            emailAddressController.text.trim(),
                          );
                    }
                  },
                  label: 'Reset Password',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
