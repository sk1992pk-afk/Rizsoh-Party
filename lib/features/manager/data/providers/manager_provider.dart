import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/agency_model.dart';
import '../models/salary_model.dart';
import '../repositories/manager_repository.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final managerRepositoryProvider = Provider<ManagerRepository>(
  (ref) {
    final firestore = ref.watch(firebaseFirestoreProvider);
    return ManagerRepository(firestore: firestore);
  },
);

final userAgencyProvider = FutureProvider.family<AgencyModel?, String>(
  (ref, userId) async {
    final managerRepository = ref.watch(managerRepositoryProvider);
    // Get user's agencyId first
    final firestore = ref.watch(firebaseFirestoreProvider);
    final userDoc = await firestore.collection('users').doc(userId).get();
    final agencyId = userDoc.get('agencyId') as String?;

    if (agencyId == null) return null;
    return managerRepository.getAgency(agencyId);
  },
);

final userSalaryProvider = FutureProvider.family<SalaryModel?, String>(
  (ref, params) async {
    // params format: "userId,month"
    final parts = params.split(',');
    final userId = parts[0];
    final month = parts[1];

    final managerRepository = ref.watch(managerRepositoryProvider);
    return managerRepository.getUserSalary(userId: userId, month: month);
  },
);
