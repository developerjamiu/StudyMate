import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/enums/department.dart';
import '../../../shared/enums/level.dart';
import '../../../shared/models/failure.dart';
import '../../authentication/providers/user_repository_provider.dart';

class UpdateProfileController extends BaseChangeNotifier {
  UpdateProfileController(this._read);

  final Reader _read;

  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    setState();
  }

  Future<void> updateProfile(
    String fullName,
    Level level,
    Department department,
  ) async {
    setState(state: AppState.loading);

    try {
      await _read(userRepositoryProvider).updateUser(
        fullName: fullName,
        department: department.index,
        level: level.index,
      );

      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(
          content: Text(
            'Profile Update Successful',
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

final updateProfileControllerProvider = ChangeNotifierProvider(
  (ref) => UpdateProfileController(ref.read),
);
