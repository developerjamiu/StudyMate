import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/authentication_repository.dart';
import '../../../repositories/study_plan_repository.dart';

final studyPlanRepositoryProvider = Provider<StudyPlanRepository>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  if (auth.data?.value?.uid != null) {
    return StudyPlanRepository(userId: auth.data!.value!.uid);
  }

  throw UnimplementedError();
});
