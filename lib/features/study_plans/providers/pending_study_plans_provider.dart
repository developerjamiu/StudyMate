import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/study_plans.dart';
import 'study_plan_repository_provider.dart';

final pendingStudyPlansProvider = StreamProvider<List<StudyPlan>>((ref) {
  return ref.watch(studyPlanRepositoryProvider).getPendingStudyPlans();
});
