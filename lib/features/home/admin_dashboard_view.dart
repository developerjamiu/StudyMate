import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/utilities/greeting.dart';
import '../../../shared/widgets/masked_container.dart';
import '../../../shared/widgets/spacing.dart';
import '../../shared/widgets/widgets.dart';
import '../authentication/models/app_user.dart';
import '../course/views/add_course_view.dart';
import '../course/views/courses_view.dart';
import '../past_questions/views/add_past_question_view.dart';
import '../past_questions/views/past_questions_view.dart';

class AdminDashboardView extends HookWidget {
  final AppUser user;

  const AdminDashboardView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final selectedItem = useState(0);

    return Statusbar(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacing.mediumHeight(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting().toUpperCase(),
                      style: textTheme.subtitle1,
                    ),
                    Spacing.height(4),
                    Text(
                      user.fullName,
                      style: textTheme.headline6,
                    ),
                  ],
                ),
                Spacing.mediumHeight(),
                Row(
                  children: [
                    Expanded(
                      child: MaskedContainer(
                        color: colorScheme.primary,
                        texts: ['ADD NEW', 'Course'],
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => AddCourseView()),
                        ),
                      ),
                    ),
                    Spacing.mediumWidth(),
                    Expanded(
                      child: MaskedContainer(
                        color: colorScheme.secondary,
                        texts: ['ADD NEW', 'Past Question'],
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AddPastQuestionView(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacing.mediumHeight(),
                CupertinoSlidingSegmentedControl(
                  // backgroundColor: AppColors.noColor,
                  thumbColor: colorScheme.secondary,
                  groupValue: selectedItem.value,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  children: {
                    0: Container(
                      height: 36,
                      child: Center(child: Text('Courses')),
                    ),
                    1: Container(
                      height: 36,
                      child: Center(child: Text('Questions')),
                    ),
                  },
                  onValueChanged: (int? value) => selectedItem.value = value!,
                ),
                Spacing.mediumHeight(),
                Text(
                  (selectedItem.value == 0 ? 'Courses' : 'Past Questions')
                      .toUpperCase(),
                  style: textTheme.subtitle1,
                ),
                Spacing.mediumHeight(),
                selectedItem.value == 0 ? CoursesView() : PastQuestionsView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
