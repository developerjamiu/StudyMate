import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id;
  final String title;
  final Timestamp timestamp;

  Course({
    required this.id,
    required this.title,
    required this.timestamp,
  });

  factory Course.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      Course(
        id: snapshot.id,
        title: snapshot.data()?['title'],
        timestamp: snapshot.data()?['timestamp'],
      );
}

class CourseParams {
  final String title;

  CourseParams({required this.title});

  Map<String, dynamic> toMap() => {
        'title': title,
        'timestamp': Timestamp.now(),
      };
}
