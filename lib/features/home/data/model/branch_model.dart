class BranchModel {
  final String id;
  final String name;
  final String image;
  final bool status;
  final String managerId;
  final int table;
  final String managerName;
  final String branchPhoneNumber;
  final String branchBinNumber;
  final String address;

  BranchModel({
    required this.id,
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

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    managerId: json["managerId"],
    table: json["table"],
    managerName: json["managerName"],
    branchPhoneNumber: json["branchPhoneNumber"],
    branchBinNumber: json["branchBinNumber"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "status": status,
    "managerId": managerId,
    "table": table,
    "managerName": managerName,
    "branchPhoneNumber": branchPhoneNumber,
    "branchBinNumber": branchBinNumber,
    "address": address,
  };
}
