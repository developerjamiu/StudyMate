import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../models/course.dart';
import '../providers/course_repository_provider.dart';

class AddCourseController extends BaseChangeNotifier {
  AddCourseController(this._read);

  final Reader _read;

  Future<void> addCourse(CourseParams params) async {
    setState(state: AppState.loading);

    try {
      await _read(courseRepositoryProvider).createCourse(params);

      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Course created successfully')),
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

final addCourseControllerProvider = ChangeNotifierProvider(
  (ref) => AddCourseController(ref.read),
);
