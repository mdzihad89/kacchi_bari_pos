import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final String id;
  final String name;
  final String image;
  final bool status;
  final String slug;
  final int price;
  final String categoryId;
  final String categoryName;
  final String type;
  final List<Variation> variations;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.slug,
    required this.price,
    required this.categoryId,
    required this.categoryName,
    required this.type,
    required this.variations,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["_id"],
    name: json["name"],
    image: json["image"],
    status: json["status"],
    slug: json["slug"],
    price: json["price"],
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    type: json["type"],
    variations: List<Variation>.from(json["variations"].map((x) => Variation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "status": status,
    "slug": slug,
    "price": price,
    "categoryId": categoryId,
    "categoryName": categoryName,
    "type": type,
    "variations": List<dynamic>.from(variations.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, image: $image, status: $status, slug: $slug, price: $price, categoryId: $categoryId, categoryName: $categoryName, type: $type, variations: $variations}';
  }
}

class Variation {
  final int personCount;
  final int price;
  final String id;

  Variation({
    required this.personCount,
    required this.price,
    required this.id,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    personCount: json["personCount"],
    price: json["price"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "personCount": personCount,
    "price": price,
    "_id": id,
  };

  @override
  String toString() {
    return 'Variation{personCount: $personCount, price: $price, id: $id}';
  }
}


