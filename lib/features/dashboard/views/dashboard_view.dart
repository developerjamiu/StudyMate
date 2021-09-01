import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_mate/features/home/home_view.dart';
import '../../../core/utilities/greeting.dart';
import '../../../shared/widgets/masked_container.dart';
import '../../../shared/widgets/spacing.dart';
import '../../authentication/models/app_user.dart';
import '../../study_plans/views/create_study_plan_view.dart';
import '../../study_plans/views/study_plans_view.dart';

class DashboardView extends HookWidget {
  final AppUser user;

  const DashboardView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
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
                      texts: ['CREATE NEW', 'Study Reminder'],
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => CreateStudyPlanView()),
                      ),
                    ),
                  ),
                  Spacing.mediumWidth(),
                  Expanded(
                    child: MaskedContainer(
                      color: colorScheme.secondary,
                      texts: ['STUDY', 'Past Questions'],
                      onTap: () => context.read(homeCurrentPageIndex).state = 2,
                    ),
                  ),
                ],
              ),
              Spacing.smallHeight(),
              Row(
                children: [
                  Text(
                    'Pending Study Plans'.toUpperCase(),
                    style: textTheme.subtitle1,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () =>
                        context.read(homeCurrentPageIndex).state = 1,
                    child: Text('View all'),
                  )
                ],
              ),
              PendingStudyPlansView(),
            ],
          ),
        ),
      ),
    );
  }
}
