import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/authentication_repository.dart';
import '../../../repositories/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  if (auth.data?.value?.uid != null) {
    return UserRepository(userId: auth.data!.value!.uid);
  }

  throw UnimplementedError();
});
