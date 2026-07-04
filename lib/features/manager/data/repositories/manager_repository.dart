import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/agency_model.dart';
import '../models/salary_model.dart';

class ManagerRepository {
  final FirebaseFirestore _firestore;

  ManagerRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  // Create agency
  Future<AgencyModel> createAgency({
    required String bdId,
    required String name,
  }) async {
    try {
      final agencyId = _firestore.collection('agencies').doc().id;

      final agency = AgencyModel(
        agencyId: agencyId,
        bdId: bdId,
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore.collection('agencies').doc(agencyId).set(agency.toJson());

      // Update BD's agencyId
      await _firestore.collection('users').doc(bdId).update({
        'agencyId': agencyId,
      });

      return agency;
    } catch (e) {
      rethrow;
    }
  }

  // Add team member
  Future<void> addTeamMember({
    required String agencyId,
    required String memberId,
  }) async {
    try {
      await _firestore.collection('agencies').doc(agencyId).update({
        'memberIds': FieldValue.arrayUnion([memberId]),
      });

      // Update member's agencyId
      await _firestore.collection('users').doc(memberId).update({
        'agencyId': agencyId,
      });
    } catch (e) {
      rethrow;
    }
  }

  // Get agency
  Future<AgencyModel> getAgency(String agencyId) async {
    try {
      final doc = await _firestore.collection('agencies').doc(agencyId).get();
      return AgencyModel.fromJson(doc.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  // Update agency revenue
  Future<void> updateAgencyRevenue({
    required String agencyId,
    required int amount,
  }) async {
    try {
      await _firestore.collection('agencies').doc(agencyId).update({
        'revenue': FieldValue.increment(amount),
        'totalCoinsGenerated': FieldValue.increment(amount),
      });
    } catch (e) {
      rethrow;
    }
  }

  // Calculate salary
  Future<SalaryModel> calculateSalary({
    required String userId,
    required String month,
  }) async {
    try {
      // Get user agency info
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final agencyId = userDoc.get('agencyId') as String?;

      double salary1 = 0;
      double salary2 = 0;
      double salary3 = 0;

      if (agencyId != null) {
        // Get agency revenue for the month
        final agencyDoc =
            await _firestore.collection('agencies').doc(agencyId).get();
        final agencyData = agencyDoc.data() as Map<String, dynamic>;

        // Salary1: Agency Opening - tier based
        final totalCoinsGenerated = agencyData['totalCoinsGenerated'] as int? ?? 0;
        if (totalCoinsGenerated >= 500000) {
          salary1 = 50; // T4
        } else if (totalCoinsGenerated >= 250000) {
          salary1 = 30; // T3
        } else if (totalCoinsGenerated >= 100000) {
          salary1 = 15; // T2
        } else {
          salary1 = 5; // T1
        }

        // Salary2: Revenue Commission - 10% of monthly revenue
        salary2 = (totalCoinsGenerated * 0.1).toDouble();
      }

      final totalSalary = 100 + salary1 + salary2 + salary3; // 100 = base

      final salaryId = _firestore.collection('salaries').doc().id;

      final salary = SalaryModel(
        salaryId: salaryId,
        userId: userId,
        month: month,
        baseSalary: 100,
        salary1AgencyOpening: salary1,
        salary2RevenueCommission: salary2,
        salary3Bonus: salary3,
        totalSalary: totalSalary,
        createdAt: DateTime.now(),
      );

      await _firestore.collection('salaries').doc(salaryId).set(salary.toJson());

      return salary;
    } catch (e) {
      rethrow;
    }
  }

  // Get user salary
  Future<SalaryModel?> getUserSalary({
    required String userId,
    required String month,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('salaries')
          .where('userId', isEqualTo: userId)
          .where('month', isEqualTo: month)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;
      return SalaryModel.fromJson(snapshot.docs.first.data());
    } catch (e) {
      rethrow;
    }
  }

  // Withdraw salary
  Future<bool> withdrawSalary({
    required String salaryId,
  }) async {
    try {
      await _firestore.collection('salaries').doc(salaryId).update({
        'withdrawn': true,
        'withdrawnAt': DateTime.now(),
      });
      return true;
    } catch (e) {
      rethrow;
    }
  }

  // Get user's agency members
  Future<List<String>> getAgencyMembers(String agencyId) async {
    try {
      final doc = await _firestore.collection('agencies').doc(agencyId).get();
      return List<String>.from(
        (doc.data() as Map<String, dynamic>?)?.['memberIds'] ?? [],
      );
    } catch (e) {
      rethrow;
    }
  }

  // Update user role
  Future<void> updateUserRole({
    required String userId,
    required String role,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'role': role,
      });
    } catch (e) {
      rethrow;
    }
  }
}
