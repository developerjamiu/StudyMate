import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/enums/priority.dart';

class StudyPlan {
  final String id;
  final String title;
  final String? note;
  final DateTime date;
  final bool completed;
  final Priority priority;
  final Timestamp timestamp;

  StudyPlan({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.completed,
    required this.timestamp,
    required this.priority,
  });

  factory StudyPlan.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      StudyPlan(
        id: snapshot.id,
        title: snapshot.data()?['title'],
        note: snapshot.data()?['note'],
        date: DateTime.parse(snapshot.data()?['date']),
        completed: snapshot.data()?['completed'],
        priority: Priority.values[snapshot.data()?['priority']],
        timestamp: snapshot.data()?['timestamp'],
      );

  StudyPlan copyWith({
    String? id,
    String? title,
    String? note,
    DateTime? date,
    bool? completed,
    Priority? priority,
    Timestamp? timestamp,
  }) {
    return StudyPlan(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      date: date ?? this.date,
      completed: completed ?? this.completed,
      priority: priority ?? this.priority,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class StudyPlanParams {
  final String title;
  final String note;
  final Priority priority;
  final DateTime date;

  StudyPlanParams({
    required this.title,
    required this.note,
    required this.date,
    required this.priority,
  });

  Map<String, dynamic> toMap() => {
        'title': title,
        'note': note,
        'date': date.toIso8601String(),
        'completed': false,
        'priority': priority.index,
        'timestamp': Timestamp.now(),
      };

  Map<String, dynamic> toUpdateMap() => {
        'title': title,
        'note': note,
        'date': date.toIso8601String(),
        'completed': false,
        'priority': priority.index,
      };
}
