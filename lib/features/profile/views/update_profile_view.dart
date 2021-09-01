import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/enums/department.dart';
import '../../../shared/enums/level.dart';
import '../../../shared/widgets/widgets.dart';
import '../../authentication/models/app_user.dart';
import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends StatefulWidget {
  final AppUser user;

  UpdateProfileView(this.user);

  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final _formKey = GlobalKey<FormState>();

  late final fullNameController = TextEditingController();
  Department? department;
  Level? level;

  @override
  void initState() {
    fullNameController.text = widget.user.fullName;
    level = widget.user.level;
    department = widget.user.department;
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
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
                'Update Profile',
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
                      labelText: 'Full Name',
                      controller: fullNameController,
                      validator: context.validateFullName,
                    ),
                    Spacing.bigHeight(),
                    CustomDropdown<Department>(
                      value: department,
                      items: Department.values,
                      hintText: 'Department',
                      onChanged: (value) {
                        FocusScope.of(context).unfocus();
                        department = value;
                      },
                      validator: context.validateFieldNotNull,
                    ),
                    Spacing.bigHeight(),
                    CustomDropdown<Level>(
                      value: level,
                      items: Level.values,
                      hintText: 'Level',
                      onChanged: (value) {
                        FocusScope.of(context).unfocus();
                        level = value;
                      },
                      validator: context.validateFieldNotNull,
                    ),
                  ],
                ),
              ),
              Spacing.largeHeight(),
              Consumer(
                builder: (_, watch, __) => AppElevatedButton(
                  isLoading: watch(updateProfileControllerProvider).state ==
                      AppState.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(updateProfileControllerProvider)
                          .updateProfile(
                            fullNameController.text,
                            level!,
                            department!,
                          );
                    }
                  },
                  label: 'Update Profile',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
