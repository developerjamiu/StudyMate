import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/past_question.dart';
import 'past_questions_repository_provider.dart';

final pastQuestionsProvider = StreamProvider<List<PastQuestion>>((ref) {
  return ref.watch(pastQuestionRepositoryProvider).getPastQuestions();
});
