import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../models/past_question.dart';
import '../providers/past_questions_repository_provider.dart';

class EditPastQuestionController extends BaseChangeNotifier {
  EditPastQuestionController(this._read);

  final Reader _read;

  Future<void> editPastQuestion(
    String id, {
    required String downloadUrl,
    required PastQuestionParams params,
  }) async {
    setState(state: AppState.loading);

    try {
      await _read(pastQuestionRepositoryProvider).updatePastQuestion(
        id,
        params: params,
        downloadUrl: downloadUrl,
      );

      _read(navigationServiceProvider).back();
      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Past question updated successfully')),
      );
    } on Failure catch (ex) {
      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text(ex.message)),
      );
    } finally {
      setState(state: AppState.idle);
    }
  }

  Future<void> deletePastQuestion(String id, {required String url}) async {
    try {
      await _read(pastQuestionRepositoryProvider).deletePastQuestion(
        id,
        downloadUrl: url,
      );

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Course deleted successfully')),
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

final editPastQuestionControllerProvider = ChangeNotifierProvider(
  (ref) => EditPastQuestionController(ref.read),
);
