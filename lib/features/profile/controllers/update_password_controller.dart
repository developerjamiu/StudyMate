import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';

class UpdatePasswordController extends BaseChangeNotifier {
  UpdatePasswordController(this._read);

  final Reader _read;

  bool _oldPasswordVisible = false;

  bool get oldPasswordVisible => _oldPasswordVisible;

  void toggleOldPasswordVisibility() {
    _oldPasswordVisible = !_oldPasswordVisible;
    setState();
  }

  bool _newPasswordVisible = false;

  bool get newPasswordVisible => _newPasswordVisible;

  void toggleNewPasswordVisibility() {
    _newPasswordVisible = !_newPasswordVisible;
    setState();
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepositoryProvider).updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(
          content: Text(
            'Password Update Successful',
          ),
        ),
      );
    } on Failure catch (ex) {
      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text(ex.message)),
      );
    } finally {
      setState(state: AppState.idle);
    }
  }
}

final updatePasswordControllerProvider = ChangeNotifierProvider(
  (ref) => UpdatePasswordController(ref.read),
);
