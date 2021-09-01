import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../../core/constants/colors.dart';
import '../../shared/widgets/status_bar.dart';
import '../../shared/widgets/widgets.dart';
import '../authentication/models/app_user.dart';
import '../profile/views/profile_view.dart';
import 'admin_dashboard_view.dart';

final adminHomeCurrentPageIndex = StateProvider.autoDispose((ref) => 0);

class AdminHomeView extends ConsumerWidget {
  final AppUser user;

  AdminHomeView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentPageIndex = watch(adminHomeCurrentPageIndex);

    return Statusbar(
      child: Scaffold(
        body: [
          AdminDashboardView(user: user),
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
              icon: Icon(Ionicons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
