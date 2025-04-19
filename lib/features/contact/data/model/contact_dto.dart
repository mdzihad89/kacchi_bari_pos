class ContactDto {
  final String name;
  final String number;
  final String branchId ;

  ContactDto({
    required this.name,
    required this.number,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'number': number,
      'branchId': branchId,
    };
  }
}