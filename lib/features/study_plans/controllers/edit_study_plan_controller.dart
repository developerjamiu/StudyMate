import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:study_mate/services/navigation_service.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../models/study_plans.dart';
import '../providers/study_plan_repository_provider.dart';

class EditStudyPlanController extends BaseChangeNotifier {
  EditStudyPlanController(this._read);

  final Reader _read;

  Future<void> editStudyPlan(
    StudyPlan studyPlan,
    StudyPlanParams params,
  ) async {
    setState(state: AppState.loading);

    try {
      await _read(studyPlanRepositoryProvider).updateStudyPlan(
        studyPlan,
        params,
      );

      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Study plan updated successfully')),
      );
    } on Failure catch (ex) {
      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text(ex.message)),
      );
    } finally {
      setState(state: AppState.idle);
    }
  }

  Future<void> deleteStudyPlan(StudyPlan studyPlan) async {
    try {
      await _read(studyPlanRepositoryProvider).deleteStudyPlan(studyPlan);

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Study plan deleted successfully')),
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

final editStudyPlanControllerProvider = ChangeNotifierProvider(
  (ref) => EditStudyPlanController(ref.read),
);
