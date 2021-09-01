import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/enums/department.dart';
import '../../../shared/enums/level.dart';
import '../../../shared/widgets/widgets.dart';
import '../controllers/register_controller.dart';
import '../models/app_user.dart';
import 'authentication_wrapper.dart';

class RegisterView extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = context.read(registerControllerProvider);

    final fullNameController = useTextEditingController();
    final emailAddressController = useTextEditingController();
    final passwordController = useTextEditingController();
    final department = useState<Department?>(null);
    final level = useState<Level?>(null);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        trailing: TextButton(
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => AuthenticationWrapper()),
          ),
          child: Text('Login'),
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
                        'Welcome to your own\nPersonal Assistant',
                      ),
                    ),
                    Spacing.height(14),
                    Hero(
                      tag: 'auth-text',
                      child: CustomText.bodyText1('Let’s get you started...'),
                    ),
                    Spacing.largeHeight(),
                    CustomTextField(
                      labelText: 'Full Name',
                      controller: fullNameController,
                      validator: context.validateFullName,
                    ),
                    Spacing.bigHeight(),
                    CustomTextField(
                      labelText: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailAddressController,
                      validator: context.validateEmailAddress,
                    ),
                    Spacing.bigHeight(),
                    CustomDropdown<Department>(
                      value: department.value,
                      items: Department.values,
                      hintText: 'Department',
                      onChanged: (value) {
                        FocusScope.of(context).unfocus();
                        department.value = value;
                      },
                      validator: context.validateFieldNotNull,
                    ),
                    Spacing.bigHeight(),
                    CustomDropdown<Level>(
                      value: level.value,
                      items: Level.values,
                      hintText: 'Level',
                      onChanged: (value) {
                        FocusScope.of(context).unfocus();
                        level.value = value;
                      },
                      validator: context.validateFieldNotNull,
                    ),
                    Spacing.bigHeight(),
                    Consumer(
                      builder: (_, ScopedReader watch, __) {
                        final registerController =
                            watch(registerControllerProvider);

                        return CustomTextField(
                          labelText: 'Password',
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: !registerController.passwordVisible,
                          suffixIcon: IconButton(
                            icon: registerController.passwordVisible
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
              Spacing.mediumHeight(),
              Hero(
                tag: 'auth-button',
                child: Consumer(
                  builder: (_, watch, __) => AppElevatedButton(
                    isLoading: watch(registerControllerProvider).state ==
                        AppState.loading,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (_formKey.currentState!.validate()) {
                        await context
                            .read(registerControllerProvider)
                            .registerUser(
                              userParams: UserParams(
                                fullName: fullNameController.text,
                                emailAddress:
                                    emailAddressController.text.trim(),
                                level: level.value!,
                                department: department.value!,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                    label: 'Create Account',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
