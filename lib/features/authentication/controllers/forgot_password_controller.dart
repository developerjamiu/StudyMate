import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';

class ForgotPasswordController extends BaseChangeNotifier {
  ForgotPasswordController(this._read);

  final Reader _read;

  Future<void> resetPassword(String emailAddress) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepositoryProvider).resetPassword(
        emailAddress,
      );

      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(
          content: Text(
            'Instructions to reset your password has been sent to your email',
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

final forgotPasswordControllerProvider = ChangeNotifierProvider(
  (ref) => ForgotPasswordController(ref.read),
);
