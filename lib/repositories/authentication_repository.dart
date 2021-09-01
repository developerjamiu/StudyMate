import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../shared/models/failure.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

class AuthenticationRepository {
  AuthenticationRepository(this._auth);

  final FirebaseAuth _auth;

  User? get getUser => _auth.currentUser;

  Future<void> register({
    required String emailAddress,
    required String password,
  }) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await _userCredential.user!.sendEmailVerification();
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  Future<void> login({
    required String emailAddress,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      if (!_userCredential.user!.emailVerified) {
        await _auth.signOut();
        throw Failure('Email is not verified');
      }
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  Future<void> resetPassword(String emailAddress) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailAddress);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  Future<void> updateEmail({
    required String newEmailAddress,
    required String password,
  }) async {
    try {
      AuthCredential authCredential = EmailAuthProvider.credential(
        email: getUser!.email!,
        password: password,
      );

      await getUser?.reauthenticateWithCredential(authCredential);

      await getUser?.updateEmail(newEmailAddress);

      await getUser?.sendEmailVerification();
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      AuthCredential authCredential = EmailAuthProvider.credential(
        email: getUser!.email!,
        password: oldPassword,
      );

      await getUser?.reauthenticateWithCredential(authCredential);

      await getUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (ex) {
      throw Failure(ex.message ?? 'Something went wrong!');
    }
  }

  Future<void> logout() async => await _auth.signOut();
}

final authenticationRepositoryProvider = Provider(
  (ref) => AuthenticationRepository(ref.watch(firebaseAuthProvider)),
);
