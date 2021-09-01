import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../repositories/authentication_repository.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../../authentication/providers/user_repository_provider.dart';
import '../../authentication/views/verify_email_screen.dart';

class UpdateEmailController extends BaseChangeNotifier {
  UpdateEmailController(this._read);

  final Reader _read;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    setState();
  }

  Future<void> updateEmail(String emailAddress, String password) async {
    setState(state: AppState.loading);

    try {
      await _read(authenticationRepositoryProvider).updateEmail(
        newEmailAddress: emailAddress,
        password: password,
      );

      await _read(userRepositoryProvider).updateEmail(emailAddress);

      _read(navigationServiceProvider).offAll(
        MaterialPageRoute(builder: (_) => VerifyEmailView()),
        (Route<dynamic> route) => false,
      );

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(
          content: Text(
            'Email Update Successful! Verify and Login Again',
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

final updateEmailControllerProvider = ChangeNotifierProvider(
  (ref) => UpdateEmailController(ref.read),
);
