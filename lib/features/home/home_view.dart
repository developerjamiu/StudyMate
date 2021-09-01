import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/constants/colors.dart';
import '../../shared/widgets/status_bar.dart';
import '../../shared/widgets/widgets.dart';
import '../authentication/models/app_user.dart';
import '../dashboard/views/dashboard_view.dart';
import '../past_questions/views/user_past_questions_view.dart';
import '../profile/views/profile_view.dart';
import '../study_plans/views/study_plans_view.dart';

final homeCurrentPageIndex = StateProvider.autoDispose((ref) => 0);

class HomeView extends ConsumerWidget {
  final AppUser user;

  HomeView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentPageIndex = watch(homeCurrentPageIndex);

    return Statusbar(
      child: Scaffold(
        body: [
          DashboardView(user: user),
          StudyPlansView(),
          UserPastQuestionsView(),
          ProfileView(user: user),
        ][currentPageIndex.state],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPageIndex.state,
          onTap: (newIndex) => currentPageIndex.state = newIndex,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.onBackgroundColor,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.options),
              label: 'Study Plans',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Ionicons.calendar_clear_outline),
            //   label: 'Timetable',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.book_outline),
              label: 'Questions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
