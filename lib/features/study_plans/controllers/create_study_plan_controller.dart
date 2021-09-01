import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../models/study_plans.dart';
import '../providers/study_plan_repository_provider.dart';

class CreateStudyPlanController extends BaseChangeNotifier {
  CreateStudyPlanController(this._read);

  final Reader _read;

  Future<void> createStudyPlan(StudyPlanParams studyPlan) async {
    setState(state: AppState.loading);

    try {
      await _read(studyPlanRepositoryProvider).createStudyPlan(studyPlan);

      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Study plan created successfully')),
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

final createStudyPlanControllerProvider = ChangeNotifierProvider(
  (ref) => CreateStudyPlanController(ref.read),
);
