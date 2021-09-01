import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/enums/department.dart';
import '../../../shared/enums/level.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/custom_text.dart';
import '../../../shared/widgets/spacing.dart';
import '../../../shared/widgets/widgets.dart';
import '../../course/providers/courses_provider.dart';
import '../controllers/edit_past_question_controller.dart';
import '../models/past_question.dart';

class EditPastQuestionView extends HookWidget {
  EditPastQuestionView(this.question);

  final PastQuestion question;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final questionFileController = useTextEditingController();
    final courseTitle = useState<String?>(null);
    final department = useState<Department?>(null);
    final level = useState<Level?>(null);
    final year = useState<String?>(null);
    final questionFile = useState<File?>(null);

    useEffect(() {
      courseTitle.value = question.courseTitle;
      department.value = question.department;
      year.value = question.year;
      level.value = question.level;
    }, []);

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
                    CustomText.subtitle1('EDIT NEW'),
                    Spacing.tinyHeight(),
                    CustomText.headline6('Past Question'),
                    Spacing.largeHeight(),
                    GestureDetector(
                      onTap: () async {
                        final result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        );

                        if (result == null) return;

                        questionFile.value = File(result.files.single.path!);
                        questionFileController.text = result.files.single.name;
                      },
                      child: CustomTextField(
                        controller: questionFileController,
                        labelText: 'Add Question File',
                        validator: context.validateFieldNotEmpty,
                        labelStyle: theme.textTheme.subtitle1?.copyWith(
                          color: AppColors.onBackgroundColor,
                        ),
                        enabled: false,
                        suffixIcon: Icon(Ionicons.book_outline),
                      ),
                    ),
                    Spacing.bigHeight(),
                    Consumer(
                      builder: (_, watch, __) {
                        final courses = watch(coursesProvider);
                        return CustomDropdown<String>(
                          value: courseTitle.value,
                          items: courses.when(
                            data: (data) => data.map((e) => e.title).toList(),
                            loading: () => [],
                            error: (_, __) => [],
                          ),
                          labelText: 'Course Title',
                          hintText: 'Course Title',
                          onChanged: (value) {
                            FocusScope.of(context).unfocus();
                            courseTitle.value = value!;
                          },
                          validator: context.validateFieldNotNull,
                        );
                      },
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
                    CustomDropdown<String>(
                      value: year.value,
                      items: ['2021', '2020', '2019', '2018', '2017'],
                      hintText: 'Year',
                      onChanged: (value) {
                        FocusScope.of(context).unfocus();
                        year.value = value;
                      },
                      validator: context.validateFieldNotNull,
                    ),
                    Spacing.bigHeight(),
                  ],
                ),
              ),
              Spacing.mediumHeight(),
              Consumer(
                builder: (_, watch, __) => AppElevatedButton(
                  label: 'Edit Past Question',
                  isLoading: watch(editPastQuestionControllerProvider).state ==
                      AppState.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    final fileName = questionFileController.text;
                    final destination = 'Questions/$fileName';

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(editPastQuestionControllerProvider)
                          .editPastQuestion(
                            question.id,
                            downloadUrl: question.fileDownloadUrl,
                            params: PastQuestionParams(
                              destination: destination,
                              questionFile: questionFile.value!,
                              courseTitle: courseTitle.value!,
                              department: department.value!,
                              level: level.value!,
                              year: year.value!,
                            ),
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
