import 'package:isar/isar.dart';
part 'category_model_isar.g.dart';

@collection
class CategoryModelIsar {
  Id id = Isar.autoIncrement;
  @Index(unique: true)
   String categoryId;
   String name;
   String image;
   String slug;
   bool status;

  CategoryModelIsar({
    required this.categoryId,
    required this.name,
    required this.image,
    required this.slug,
    required this.status,
  });

}
