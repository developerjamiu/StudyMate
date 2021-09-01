import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/widgets/widgets.dart';
import '../controllers/update_email_controller.dart';

class UpdateEmailView extends StatefulWidget {
  @override
  _UpdateEmailViewState createState() => _UpdateEmailViewState();
}

class _UpdateEmailViewState extends State<UpdateEmailView> {
  final _formKey = GlobalKey<FormState>();

  late final emailAddressController = TextEditingController();
  late final passwordController = TextEditingController();

  @override
  void dispose() {
    emailAddressController.dispose();
    passwordController.dispose();
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
                'Update Email Address',
                style: Theme.of(context).textTheme.headline6,
              ),
              Spacing.smallHeight(),
              Divider(color: Colors.black87),
              Spacing.bigHeight(),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      labelText: 'Email Address',
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                      validator: context.validateEmailAddress,
                    ),
                    Spacing.bigHeight(),
                    Consumer(
                      builder: (_, ScopedReader watch, __) {
                        final controller = watch(updateEmailControllerProvider);

                        return CustomTextField(
                          labelText: 'Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !controller.passwordVisible,
                          suffixIcon: IconButton(
                            icon: controller.passwordVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: context.validatePassword,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Spacing.largeHeight(),
              Consumer(
                builder: (_, watch, __) => AppElevatedButton(
                  isLoading: watch(updateEmailControllerProvider).state ==
                      AppState.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(updateEmailControllerProvider)
                          .updateEmail(
                            emailAddressController.text.trim(),
                            passwordController.text,
                          );
                    }
                  },
                  label: 'Update Email',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
