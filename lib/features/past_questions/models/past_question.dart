import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/enums/department.dart';
import '../../../shared/enums/level.dart';

class PastQuestion {
  final String id;
  final String fileDownloadUrl;
  final String courseTitle;
  final Department department;
  final Level level;
  final String year;
  final Timestamp timestamp;

  PastQuestion({
    required this.id,
    required this.fileDownloadUrl,
    required this.courseTitle,
    required this.department,
    required this.level,
    required this.year,
    required this.timestamp,
  });

  factory PastQuestion.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      PastQuestion(
        id: snapshot.id,
        fileDownloadUrl: snapshot.data()?['fileDownloadUrl'],
        courseTitle: snapshot.data()?['courseTitle'],
        department: Department.values[snapshot.data()?['department']],
        level: Level.values[snapshot.data()?['level']],
        year: snapshot.data()?['year'],
        timestamp: snapshot.data()?['timestamp'],
      );
}

class PastQuestionParams {
  final String destination;
  final File questionFile;
  final String courseTitle;
  final Department department;
  final Level level;
  final String year;

  PastQuestionParams({
    required this.destination,
    required this.questionFile,
    required this.courseTitle,
    required this.department,
    required this.level,
    required this.year,
  });

  Map<String, dynamic> toMap() => {
        'courseTitle': courseTitle,
        'department': department.index,
        'level': level.index,
        'year': year,
        'timestamp': Timestamp.now(),
      };
}
