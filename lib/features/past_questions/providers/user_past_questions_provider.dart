import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../authentication/providers/app_user_provider.dart';
import '../models/past_question.dart';
import 'past_questions_repository_provider.dart';

final userPastQuestionsProvider = StreamProvider<List<PastQuestion>>((ref) {
  final user = ref.watch(appUserFutureProvider).data;

  return ref.watch(pastQuestionRepositoryProvider).getUserPastQuestions(
        user!.value,
      );
});
