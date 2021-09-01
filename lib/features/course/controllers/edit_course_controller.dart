import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/utilities/base_change_notifier.dart';
import '../../../services/navigation_service.dart';
import '../../../services/scaffold_messenger_service.dart';
import '../../../shared/models/failure.dart';
import '../models/course.dart';
import '../providers/course_repository_provider.dart';

class EditCourseController extends BaseChangeNotifier {
  EditCourseController(this._read);

  final Reader _read;

  Future<void> editCourse(
    String courseId,
    CourseParams params,
  ) async {
    setState(state: AppState.loading);

    try {
      await _read(courseRepositoryProvider).updateCourse(
        courseId,
        params,
      );

      _read(navigationServiceProvider).back();

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Course updated successfully')),
      );
    } on Failure catch (ex) {
      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text(ex.message)),
      );
    } finally {
      setState(state: AppState.idle);
    }
  }

  Future<void> deleteStudyPlan(String studyPlanId) async {
    try {
      await _read(courseRepositoryProvider).deleteCourse(studyPlanId);

      _read(scaffoldMessengerServiceProvider).showSnackBar(
        SnackBar(content: Text('Course deleted successfully')),
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

final editCourseControllerProvider = ChangeNotifierProvider(
  (ref) => EditCourseController(ref.read),
);
