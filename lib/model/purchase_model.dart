// ignore_for_file: constant_identifier_names

const String PurchaseId = 'id';
const String PurchaseProductId = 'productId';
const String PurchaseDate = 'purchaseDate';
const String PurchaseProductPrice = 'productPrice';
const String PurchaseProductQunatity = 'productQuantity';

class PurchaseModel {
  String? id;
  String? productId;
  String? purchaseDate;
  num? purchasePrice;
  num? productQuantity;

  PurchaseModel({
    this.id,
    this.productId,
    this.purchaseDate,
    this.purchasePrice,
    this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PurchaseId: id,
      PurchaseProductId: productId,
      PurchaseDate: purchaseDate,
      PurchaseProductPrice: purchasePrice,
      PurchaseProductQunatity: productQuantity
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) => PurchaseModel(
    id: map[PurchaseId],
    productId: map[PurchaseProductId],
    purchaseDate: map[PurchaseDate],
    purchasePrice: map[PurchaseProductPrice],
    productQuantity: map[PurchaseProductQunatity],
  );
}
