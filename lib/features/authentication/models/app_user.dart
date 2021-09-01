import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../shared/enums/department.dart';
import '../../../shared/enums/level.dart';
import '../../../shared/enums/role.dart';

class AppUser {
  final String id;
  final String fullName;
  final String emailAddress;
  final Level level;
  final Department department;
  final Role role;
  final Timestamp timestamp;

  const AppUser({
    required this.id,
    required this.fullName,
    required this.emailAddress,
    required this.level,
    required this.department,
    required this.role,
    required this.timestamp,
  });

  factory AppUser.fromDocumentSnapshot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      AppUser(
        id: snapshot.id,
        fullName: snapshot.data()?['fullName'],
        emailAddress: snapshot.data()?['emailAddress'],
        level: Level.values[snapshot.data()?['level']],
        department: Department.values[snapshot.data()?['department']],
        role: Role.values[snapshot.data()?['role']],
        timestamp: snapshot.data()?['timestamp'],
      );

  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'emailAddress': emailAddress,
        'level': level.index,
        'department': department.index,
        'role': role.index,
        'timestamp': Timestamp.now(),
      };
}

class UserParams {
  final String fullName;
  final String emailAddress;
  final Level level;
  final Department department;
  final String password;

  UserParams({
    required this.fullName,
    required this.emailAddress,
    required this.level,
    required this.department,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'emailAddress': emailAddress,
        'level': level.index,
        'department': department.index,
        'role': Role.student.index,
        'timestamp': Timestamp.now(),
      };
}
