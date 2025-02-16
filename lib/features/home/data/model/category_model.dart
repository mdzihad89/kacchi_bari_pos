
class CategoryModel {
  final String id;
  final String name;
  final String image;
  final String slug;
  final bool status;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
    required this.status,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "slug": slug,
    "status": status,
  };
}

