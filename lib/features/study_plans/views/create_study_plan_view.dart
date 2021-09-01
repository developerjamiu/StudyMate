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
import '../controllers/create_study_plan_controller.dart';
import '../models/study_plans.dart';

class CreateStudyPlanView extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleController = useTextEditingController();
    final noteController = useTextEditingController();
    final dateController = useTextEditingController();
    final date = useState<DateTime?>(null);
    final priority = useState(Priority.normal);

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
                    CustomText.subtitle1('CREATE NEW'),
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
                  label: 'Set Reminder',
                  isLoading: watch(createStudyPlanControllerProvider).state ==
                      AppState.loading,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    if (_formKey.currentState!.validate()) {
                      await context
                          .read(createStudyPlanControllerProvider)
                          .createStudyPlan(
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
