import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/authentication/models/app_user.dart';
import '../shared/models/failure.dart';

class UserRepository {
  UserRepository({required this.userId});

  final String userId;
  final userCollection = FirebaseFirestore.instance.collection('users');

  Stream<AppUser> getUser() {
    return userCollection.doc(userId).snapshots().map(
          (documentSnapshot) => AppUser.fromDocumentSnapshot(
            documentSnapshot,
          ),
        );
  }

  Future<AppUser> getUserFuture() async {
    final user = await userCollection.doc(userId).get();
    return AppUser.fromDocumentSnapshot(user);
  }

  Future<void> createUser(UserParams user) async {
    try {
      await userCollection.doc(userId).set(user.toMap());
    } catch (ex) {
      throw Failure('Error creating user');
    }
  }

  Future<void> updateEmail(String emailAddress) async {
    try {
      await userCollection.doc(userId).update({'emailAddress': emailAddress});
    } catch (ex) {
      throw Failure('Error updating user email');
    }
  }

  Future<void> updateUser({
    required String fullName,
    required int department,
    required int level,
  }) async {
    try {
      await userCollection.doc(userId).update({
        'fullName': fullName,
        'level': level,
        'department': department,
      });
    } catch (ex) {
      throw Failure('Error updating user');
    }
  }
}
