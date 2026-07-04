import 'package:freezed_annotation/freezed_annotation.dart';

part 'salary_model.freezed.dart';
part 'salary_model.g.dart';

@freezed
class SalaryModel with _$SalaryModel {
  const factory SalaryModel({
    required String salaryId,
    required String userId,
    required String month,
    @Default(0) double baseSalary,
    @Default(0) double salary1AgencyOpening,
    @Default(0) double salary2RevenueCommission,
    @Default(0) double salary3Bonus,
    @Default(0) double totalSalary,
    @Default(false) bool withdrawn,
    DateTime? withdrawnAt,
    DateTime? createdAt,
  }) = _SalaryModel;

  factory SalaryModel.fromJson(Map<String, dynamic> json) =>
      _$SalaryModelFromJson(json);
}
