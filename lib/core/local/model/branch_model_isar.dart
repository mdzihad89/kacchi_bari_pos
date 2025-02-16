import 'package:isar/isar.dart';

part 'branch_model_isar.g.dart';

@Collection()
class BranchModelIsar {

  Id id = Isar.autoIncrement;
  @Index(unique: true)
  final String branchId;
  final String name;
  final String image;
  final bool status;
  final String managerId;
  final int table;
  final String managerName;
  final String branchPhoneNumber;
  final String branchBinNumber;
  final String address;

  BranchModelIsar({
    required this.branchId,
    required this.name,
    required this.image,
    required this.status,
    required this.managerId,
    required this.table,
    required this.managerName,
    required this.branchPhoneNumber,
    required this.branchBinNumber,
    required this.address,
  });


}