import 'package:isar/isar.dart';

part 'product_model_isar.g.dart';

@collection
class ProductModelIsar {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
   String productId;
   String name;
   String image;
   bool status;
   String slug;
   int price;
   String categoryId;
   String categoryName;
   String type;
  List<VariationIsar> variations;

  ProductModelIsar({
    required this.productId,
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
}

@embedded
class VariationIsar {
   int? personCount;
   int? price;
   String? variationId;

  VariationIsar({
     this.personCount,
     this.price,
     this.variationId,
  });
}
