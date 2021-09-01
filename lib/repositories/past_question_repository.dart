import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../core/utilities/file_util.dart';
import '../features/authentication/models/app_user.dart';
import '../features/past_questions/models/past_question.dart';
import '../shared/models/failure.dart';

class PastQuestionRepository {
  final _storage = FirebaseStorage.instance;

  CollectionReference<Map<String, dynamic>> get pastQuestionCollection =>
      FirebaseFirestore.instance.collection('past-questions');

  Future<File?> getQuestionFile(String url) async {
    final refPDF = FirebaseStorage.instance.refFromURL(url);
    final bytes = await refPDF.getData();

    if (bytes == null) {
      throw Failure('Unable to get question file');
    }

    return FileUtil.storeFile(url, bytes);
  }

  Future<String> uploadQuestionFile(String destination, File file) async {
    try {
      final ref = _storage.ref(destination);

      final task = ref.putFile(file);

      final snapshot = await task.whenComplete(() {});
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException {
      throw Failure('Error uploading file. Please try again');
    }
  }

  Future<void> deleteQuestionFile(String downloadUrl) async {
    try {
      await _storage.refFromURL(downloadUrl).delete();
    } on FirebaseException {
      return null;
    }
  }

  Stream<List<PastQuestion>> getUserPastQuestions(AppUser user) {
    return pastQuestionCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (queryDocumentSnapshot) =>
                    PastQuestion.fromDocumentSnapshot(queryDocumentSnapshot),
              )
              .toList()
              .where((question) => question.department == user.department)
              .where((question) => question.level == user.level)
              .toList(),
        );
  }

  Stream<List<PastQuestion>> getPastQuestions() {
    return pastQuestionCollection.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (queryDocumentSnapshot) =>
                    PastQuestion.fromDocumentSnapshot(queryDocumentSnapshot),
              )
              .toList(),
        );
  }

  Future<void> createPastQuestion(PastQuestionParams params) async {
    final url =
        await uploadQuestionFile(params.destination, params.questionFile);

    try {
      await pastQuestionCollection.add({
        'fileDownloadUrl': url,
        ...params.toMap(),
      });
    } catch (ex) {
      deleteQuestionFile(url);
      throw Failure('Error creating course');
    }
  }

  Future<void> updatePastQuestion(
    String id, {
    required String downloadUrl,
    required PastQuestionParams params,
  }) async {
    await deleteQuestionFile(downloadUrl);

    final url =
        await uploadQuestionFile(params.destination, params.questionFile);
    try {
      await pastQuestionCollection.doc(id).update({
        'fileDownloadUrl': url,
        ...params.toMap(),
      });
    } catch (ex) {
      throw Failure('Error updating past question');
    }
  }

  Future<void> deletePastQuestion(String id,
      {required String downloadUrl}) async {
    await deleteQuestionFile(downloadUrl);

    try {
      await pastQuestionCollection.doc(id).delete();
    } catch (ex) {
      throw Failure('Error deleting past question');
    }
  }
}
