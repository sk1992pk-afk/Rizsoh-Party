import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) {
    final auth = ref.watch(firebaseAuthProvider);
    final firestore = ref.watch(firebaseFirestoreProvider);
    return AuthRepository(
      firebaseAuth: auth,
      firestore: firestore,
    );
  },
);

final currentUserProvider = StreamProvider<User?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return authRepository.authStateChanges;
  },
);

final currentUserDataProvider = FutureProvider<UserModel?>(
  (ref) async {
    final user = ref.watch(currentUserProvider);
    final authRepository = ref.watch(authRepositoryProvider);

    return user.when(
      data: (firebaseUser) {
        if (firebaseUser == null) return null;
        return authRepository.getUserData(firebaseUser.uid);
      },
      loading: () => null,
      error: (_, __) => null,
    );
  },
);
