import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/widgets/widgets.dart';
import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends StatefulWidget {
  @override
  _UpdatePasswordViewState createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  final _formKey = GlobalKey<FormState>();

  late final oldPasswordController = TextEditingController();
  late final newPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
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
                'Update Password',
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
                    Consumer(
                      builder: (_, ScopedReader watch, __) {
                        final controller =
                            watch(updatePasswordControllerProvider);

                        return CustomTextField(
                          labelText: 'Old Password',
                          keyboardType: TextInputType.visiblePassword,
                          controller: oldPasswordController,
                          obscureText: !controller.oldPasswordVisible,
                          suffixIcon: IconButton(
                            icon: controller.oldPasswordVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: controller.toggleOldPasswordVisibility,
                          ),
                          validator: context.validatePassword,
                        );
                      },
                    ),
                    Spacing.bigHeight(),
                    Consumer(
                      builder: (_, ScopedReader watch, __) {
                        final controller =
                            watch(updatePasswordControllerProvider);

                        return CustomTextField(
                          labelText: 'New Password',
                          controller: newPasswordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !controller.newPasswordVisible,
                          suffixIcon: IconButton(
                            icon: controller.newPasswordVisible
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                            onPressed: controller.toggleNewPasswordVisibility,
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
                  isLoading: watch(updatePasswordControllerProvider).state ==
                      AppState.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(updatePasswordControllerProvider)
                          .updatePassword(
                            oldPasswordController.text,
                            newPasswordController.text,
                          );
                    }
                  },
                  label: 'Update Password',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
