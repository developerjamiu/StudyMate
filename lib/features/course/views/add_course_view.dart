import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/custom_text.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/spacing.dart';
import '../../../shared/widgets/widgets.dart';
import '../controllers/add_course_controller.dart';
import '../models/course.dart';

class AddCourseView extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    CustomText.subtitle1('ADD NEW'),
                    Spacing.tinyHeight(),
                    CustomText.headline6('Course'),
                    Spacing.largeHeight(),
                    CustomTextField(
                      labelText: 'Course Title',
                      controller: titleController,
                      validator: context.validateFieldNotEmpty,
                    ),
                    Spacing.bigHeight(),
                  ],
                ),
              ),
              Spacing.mediumHeight(),
              Consumer(
                builder: (_, watch, __) => AppElevatedButton(
                  label: 'Add Course',
                  isLoading: watch(addCourseControllerProvider).state ==
                      AppState.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context.read(addCourseControllerProvider).addCourse(
                            CourseParams(title: titleController.text),
                          );
                    }
                  },
                ),
              ),
              Spacing.mediumHeight(),
            ],
          ),
        ),
      ),
    );
  }
}
