// ignore_for_file: constant_identifier_names, camel_case_types

const String CategoryId = 'catId';
const String CategoryName = 'catName';
const String CategoryAvailable = 'available';

class categoryModel {
  String? catId;
  String? catName;
  bool available;

  categoryModel({
    this.catId,
    this.catName,
    this.available = true,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CategoryId: catId,
      CategoryName: catName,
      CategoryAvailable: available,
    };
  }

  factory categoryModel.fromMap(Map<String, dynamic> map) => categoryModel(
    catId: map[CategoryId],
    catName: map[CategoryName],
    available: map[CategoryAvailable],
  );
}
