import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';

class LoginController extends BaseChangeNotifier {
  LoginController(this._read);

  final Reader _read;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    setState();
  }

  Future<void> loginUser({
    required String emailAddress,
    required String password,
  }) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepositoryProvider).login(
        emailAddress: emailAddress,
        password: password,
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

final loginControllerProvider = ChangeNotifierProvider(
  (ref) => LoginController(ref.read),
);
