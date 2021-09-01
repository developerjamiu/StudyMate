import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../models/past_question.dart';
import '../providers/past_questions_repository_provider.dart';

class AddPastQuestionController extends BaseChangeNotifier {
  AddPastQuestionController(this._read);

  final Reader _read;

  Future<void> addCourse(PastQuestionParams params) async {
    setState(state: AppState.loading);

    try {
      await _read(pastQuestionRepositoryProvider).createPastQuestion(params);

      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Past question added successfully')),
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

final addPastQuestionControllerProvider = ChangeNotifierProvider(
  (ref) => AddPastQuestionController(ref.read),
);
