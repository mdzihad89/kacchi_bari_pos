
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


List<CategoryModel> categories = [
  CategoryModel(
    id: "1",
    name: "Electronics",
    image: "https://i.postimg.cc/02VXQsgb/Whats-App-Image-2024-09-24-at-10-03-02-PM.jpg",
    slug: "electronics",
    status: true,
  ),
  CategoryModel(
    id: "2",
    name: "Fashion",
    image: "https://i.postimg.cc/02VXQsgb/Whats-App-Image-2024-09-24-at-10-03-02-PM.jpg",
    slug: "fashion",
    status: true,
  ),
  CategoryModel(
    id: "3",
    name: "Appliances",
    image: "https://i.postimg.cc/02VXQsgb/Whats-App-Image-2024-09-24-at-10-03-02-PM.jpg",
    slug: "appliances",
    status: true,
  ),
  CategoryModel(
    id: "4",
    name: "Books",
    image: "https://i.postimg.cc/02VXQsgb/Whats-App-Image-2024-09-24-at-10-03-02-PM.jpg",
    slug: "books",
    status: true,
  ),
  CategoryModel(
    id: "5",
    name: "Toys",
    image: "https://i.postimg.cc/02VXQsgb/Whats-App-Image-2024-09-24-at-10-03-02-PM.jpg",
    slug: "toys",
    status: true,
  ),
];
