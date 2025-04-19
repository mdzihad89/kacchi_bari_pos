class ContactModel{
  final String id;
    final String name;
    final String branchId;
    final String number;

    ContactModel({
      required this.id,
      required this.name,
      required this.branchId,
      required this.number,
    });

    factory ContactModel.fromJson(Map<String, dynamic> json) {
      return ContactModel(
        id: json['_id'],
        name: json['name'],
        branchId: json['branchId'],
        number: json['number'],
      );
    }

    Map<String, dynamic> toJson() {
      return {
         '_id': id,
        'name': name,
        'branchId': branchId,
        'number': number,
      };
    }


}