import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/course_repository.dart';

final courseRepositoryProvider = Provider<CourseRepository>(
  (ref) => CourseRepository(),
);
