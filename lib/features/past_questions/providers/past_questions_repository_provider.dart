import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/past_question_repository.dart';

final pastQuestionRepositoryProvider = Provider<PastQuestionRepository>(
  (ref) => PastQuestionRepository(),
);
