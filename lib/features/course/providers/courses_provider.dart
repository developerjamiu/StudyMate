import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/course.dart';
import 'course_repository_provider.dart';

final coursesProvider = StreamProvider<List<Course>>((ref) {
  return ref.watch(courseRepositoryProvider).getCourses();
});
