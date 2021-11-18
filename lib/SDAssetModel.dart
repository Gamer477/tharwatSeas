class SDModel {
  String? assetId;
  String? assetNameAr;
  String? assetNameEn;
  String? classificationId;
  String? assetBarcode;
  String? purchaseDate;
  double? purchasePrice;
  double? latitude;
  double? longitude;
  String? assetDescription;
  String? qrcode;
  String? supplierId;
  String? locationId;

  SDModel(
      {this.assetId,
      this.assetNameAr,
      this.assetNameEn,
      this.classificationId,
      this.assetBarcode,
      this.purchaseDate,
      this.purchasePrice,
      this.latitude,
      this.longitude,
      this.assetDescription,
      this.qrcode,
      this.supplierId,
      this.locationId});

  SDModel.fromJson(Map<String, dynamic> json) {
    assetId = json['AssetId'];
    assetNameAr = json['AssetNameAr'];
    assetNameEn = json['AssetNameEn'];
    classificationId = json['ClassificationId'];
    assetBarcode = json['AssetBarcode'];
    purchaseDate = json['PurchaseDate'];
    purchasePrice = json['PurchasePrice'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    assetDescription = json['AssetDescription'];
    qrcode = json['Qrcode'];
    supplierId = json['SupplierId'];
    locationId = json['LocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AssetId'] = this.assetId;
    data['AssetNameAr'] = this.assetNameAr;
    data['AssetNameEn'] = this.assetNameEn;
    data['ClassificationId'] = this.classificationId;
    data['AssetBarcode'] = this.assetBarcode;
    data['PurchaseDate'] = this.purchaseDate;
    data['PurchasePrice'] = this.purchasePrice;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['AssetDescription'] = this.assetDescription;
    data['Qrcode'] = this.qrcode;
    data['SupplierId'] = this.supplierId;
    data['LocationId'] = this.locationId;
    return data;
  }
}
