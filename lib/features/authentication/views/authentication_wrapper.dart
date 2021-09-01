import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/authentication_repository.dart';
import '../../../shared/enums/role.dart';
import '../../home/admin_home_view.dart';
import '../../home/home_view.dart';
import '../../startup/views/splash_view.dart';
import '../providers/app_user_provider.dart';
import 'login_view.dart';

class AuthenticationWrapper extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = useProvider(authStateChangesProvider);

    return user.when(
      data: (user) {
        if (user == null) {
          return LoginView();
        } else {
          final appUser = useProvider(appUserProvider);
          return appUser.maybeWhen(
            data: (appUser) => appUser.role == Role.student
                ? HomeView(user: appUser)
                : AdminHomeView(user: appUser),
            orElse: () => Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
      loading: () => SplashView(),
      error: (_, __) => Scaffold(body: Center(child: Text('Error'))),
    );
  }
}
