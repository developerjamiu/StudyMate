import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../models/app_user.dart';
import '../providers/user_repository_provider.dart';
import '../views/verify_email_screen.dart';

class RegisterController extends BaseChangeNotifier {
  RegisterController(this._read);

  final Reader _read;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  Future<void> registerUser({required UserParams userParams}) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepositoryProvider).register(
        emailAddress: userParams.emailAddress,
        password: userParams.password,
      );

      await _read(userRepositoryProvider).createUser(userParams);

      _read(navigationServiceProvider).off(
        MaterialPageRoute(builder: (_) => VerifyEmailView()),
      );
    } on Failure catch (ex) {
      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text(ex.message)),
      );
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final registerControllerProvider = ChangeNotifierProvider(
  (ref) => RegisterController(ref.read),
);
