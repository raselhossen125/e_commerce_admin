const String PurchaseId = 'id';
const String PurchaseProductId = 'productId';
const String PurchaseDate = 'purchaseDate';
const String PurchaseProductPrice = 'productPrice';
const String PurchaseProductQunatity = 'productQuantity';

class PurchaseModel {
  String? id;
  String? productId;
  String? purchaseDate;
  num? productPrice;
  num? productQuantity;

  PurchaseModel({
    this.id,
    this.productId,
    this.purchaseDate,
    this.productPrice,
    this.productQuantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PurchaseId: id,
      PurchaseProductId: productId,
      PurchaseDate: purchaseDate,
      PurchaseProductPrice: productPrice,
      PurchaseProductQunatity: productQuantity
    };
  }

  factory PurchaseModel.fromMap(Map<String, dynamic> map) => PurchaseModel(
    id: map[PurchaseId],
    productId: map[PurchaseProductId],
    purchaseDate: map[PurchaseDate],
    productPrice: map[PurchaseProductPrice],
    productQuantity: map[PurchaseProductQunatity],
  );
}
