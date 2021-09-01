import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/constants/colors.dart';
import '../../../core/utilities/base_change_notifier.dart';
import '../../../core/utilities/date_util.dart';
import '../../../core/utilities/validation_extensions.dart';
import '../../../shared/enums/priority.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../shared/widgets/custom_text.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/spacing.dart';
import '../../../shared/widgets/widgets.dart';
import '../controllers/edit_study_plan_controller.dart';
import '../models/study_plans.dart';

class EditStudyPlanView extends HookWidget {
  EditStudyPlanView(this.studyPlan);

  final StudyPlan studyPlan;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleController = useTextEditingController();
    final noteController = useTextEditingController();
    final dateController = useTextEditingController();
    final date = useState<DateTime?>(studyPlan.date);
    final priority = useState(studyPlan.priority);

    useEffect(
      () {
        print('here');
        titleController.text = studyPlan.title;
        if (studyPlan.note != null) noteController.text = studyPlan.note!;
        dateController.text =
            DateFormat.yMMMMEEEEd().add_jm().format(studyPlan.date);
      },
      [],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        trailing: IconButton(
          icon: Icon(Ionicons.trash_outline),
          onPressed: () {
            context
                .read(editStudyPlanControllerProvider)
                .deleteStudyPlan(studyPlan);
            Navigator.of(context).pop();
          },
        ),
      ),
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
                    CustomText.subtitle1('EDIT'),
                    Spacing.tinyHeight(),
                    CustomText.headline6('Study Plan'),
                    Spacing.largeHeight(),
                    CustomTextField(
                      labelText: 'Reminder Title',
                      controller: titleController,
                      validator: context.validateFieldNotEmpty,
                    ),
                    Spacing.bigHeight(),
                    CustomDropdown<Priority>(
                      value: priority.value,
                      items: Priority.values,
                      labelText: 'Priority',
                      hintText: 'Priority',
                      onChanged: (value) {
                        FocusScope.of(context).unfocus();
                        priority.value = value!;
                      },
                      validator: context.validateFieldNotNull,
                    ),
                    Spacing.bigHeight(),
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();

                        date.value =
                            await DateUtil.showDateAndTimePicker(context);

                        if (date.value != null) {
                          dateController.text = DateFormat.yMMMMEEEEd()
                              .add_jm()
                              .format(date.value!);
                        }
                      },
                      child: CustomTextField(
                        labelText: 'Remind me by',
                        enabled: false,
                        labelStyle: theme.textTheme.subtitle1?.copyWith(
                          color: AppColors.onBackgroundColor,
                        ),
                        suffixIcon: Icon(Ionicons.calendar_outline),
                        controller: dateController,
                        validator: context.validateFieldNotEmpty,
                      ),
                    ),
                    Spacing.bigHeight(),
                    CustomTextField(
                      maxLines: 2,
                      labelText: 'Reminder Note',
                      controller: noteController,
                    ),
                  ],
                ),
              ),
              Spacing.mediumHeight(),
              Consumer(
                builder: (_, watch, __) => AppElevatedButton(
                  label: 'Update Reminder',
                  isLoading: watch(editStudyPlanControllerProvider).state ==
                      AppState.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(editStudyPlanControllerProvider)
                          .editStudyPlan(
                            studyPlan,
                            StudyPlanParams(
                              title: titleController.text,
                              note: noteController.text,
                              date: date.value!,
                              priority: priority.value,
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
