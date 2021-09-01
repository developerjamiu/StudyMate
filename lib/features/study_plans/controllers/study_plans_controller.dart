import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_mate/features/study_plans/models/study_plans.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../providers/study_plan_repository_provider.dart';

class StudyPlansController extends BaseChangeNotifier {
  StudyPlansController(this._read);

  final Reader _read;

  Future<void> toggleStudyPlanComplete(
    StudyPlan studyPlan, {
    required bool completed,
  }) async {
    setState(state: AppState.loading);

    try {
      await _read(studyPlanRepositoryProvider).toggleStudyPlanComplete(
        studyPlan,
        completed: completed,
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

final studyPlansControllerProvider = ChangeNotifierProvider(
  (ref) => StudyPlansController(ref.read),
);
