import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/course/models/course.dart';
import '../shared/models/failure.dart';

class CourseRepository {
  CollectionReference<Map<String, dynamic>> get courseCollection =>
      FirebaseFirestore.instance.collection('courses');

  Stream<List<Course>> getCourses() {
    return courseCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (queryDocumentSnapshot) =>
                    Course.fromDocumentSnapshot(queryDocumentSnapshot),
              )
              .toList()
                ..sort((a, b) => a.title.compareTo(b.title)),
        );
  }

  Future<void> createCourse(CourseParams params) async {
    try {
      await courseCollection.add(params.toMap());
    } catch (ex) {
      throw Failure('Error creating course');
    }
  }

  Future<void> updateCourse(String courseId, CourseParams params) async {
    try {
      await courseCollection.doc(courseId).update(params.toMap());
    } catch (ex) {
      throw Failure('Error updating course');
    }
  }

  Future<void> deleteCourse(String courseId) async {
    try {
      await courseCollection.doc(courseId).delete();
    } catch (ex) {
      throw Failure('Error deleting course');
    }
  }
}
