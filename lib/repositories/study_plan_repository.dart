import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/study_plans/models/study_plans.dart';
import '../services/notification_service.dart';
import '../shared/models/failure.dart';

class StudyPlanRepository {
  StudyPlanRepository({required this.userId});

  final String userId;

  CollectionReference<Map<String, dynamic>> get userCollection =>
      FirebaseFirestore.instance.collection('users');

  CollectionReference<Map<String, dynamic>> get studyPlanCollection =>
      userCollection.doc(userId).collection('study-plans');

  Stream<List<StudyPlan>> getPendingStudyPlans() {
    return studyPlanCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (queryDocumentSnapshot) => StudyPlan.fromDocumentSnapshot(
                  queryDocumentSnapshot,
                ),
              )
              .toList()
              .where((studyPlan) => studyPlan.completed == false)
              .toList(),
        );
  }

  Stream<List<StudyPlan>> getCompletedStudyPlans() {
    return studyPlanCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (queryDocumentSnapshot) => StudyPlan.fromDocumentSnapshot(
                  queryDocumentSnapshot,
                ),
              )
              .toList()
              .where((studyPlan) => studyPlan.completed == true)
              .toList(),
        );
  }

  Future<StudyPlan> getStudyPlan(String id) async {
    final documentSnapshot = await studyPlanCollection.doc(id).get();

    return StudyPlan.fromDocumentSnapshot(documentSnapshot);
  }

  Future<void> createStudyPlan(StudyPlanParams params) async {
    try {
      final reference = await studyPlanCollection.add(params.toMap());

      final snapshot = await reference.get();

      await NotificationService.createStudyPlanNotification(
        studyPlan: StudyPlan.fromDocumentSnapshot(snapshot),
      );
    } catch (ex) {
      throw Failure('Error creating study plan');
    }
  }

  Future<void> updateStudyPlan(
      StudyPlan studyPlan, StudyPlanParams params) async {
    try {
      await studyPlanCollection.doc(studyPlan.id).update(params.toUpdateMap());

      await NotificationService.cancelStudyPlanNotification(
        studyPlan: studyPlan,
      );

      await NotificationService.createStudyPlanNotification(
        studyPlan: studyPlan.copyWith(
          date: params.date,
          title: params.title,
          note: params.note,
        ),
      );
    } catch (ex) {
      throw Failure('Error updating study plan');
    }
  }

  Future<void> toggleStudyPlanComplete(
    StudyPlan studyPlan, {
    required bool completed,
  }) async {
    try {
      await studyPlanCollection.doc(studyPlan.id).update(
        {'completed': !completed},
      );

      if (completed) {
        await NotificationService.createStudyPlanNotification(
          studyPlan: studyPlan,
        );
      } else {
        await NotificationService.cancelStudyPlanNotification(
          studyPlan: studyPlan,
        );
      }
    } catch (ex) {
      throw Failure('Error completing study plan');
    }
  }

  Future<void> deleteStudyPlan(StudyPlan studyPlan) async {
    try {
      await studyPlanCollection.doc(studyPlan.id).delete();

      await NotificationService.cancelStudyPlanNotification(
        studyPlan: studyPlan,
      );
    } catch (ex) {
      throw Failure('Error deleting study plan');
    }
  }
}
