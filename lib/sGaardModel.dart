class SGModel {
  String? inventoryId;
  int? inventoryCode;
  String? inventoryDate;
  String? committeeId;
  String? locationId;
  String? notes;
  List<TbInventoryAssets>? tbInventoryAssets;

  SGModel(
      {this.inventoryId,
      this.inventoryCode,
      this.inventoryDate,
      this.committeeId,
      this.locationId,
      this.notes,
      this.tbInventoryAssets});

  SGModel.fromJson(Map<String, dynamic> json) {
    inventoryId = json['InventoryId'];
    inventoryCode = json['InventoryCode'];
    inventoryDate = json['InventoryDate'];
    committeeId = json['CommitteeId'];
    locationId = json['LocationId'];
    notes = json['Notes'];
    if (json['TbInventoryAssets'] != null) {
      tbInventoryAssets = <TbInventoryAssets>[];
      json['TbInventoryAssets'].forEach((v) {
        tbInventoryAssets!.add(new TbInventoryAssets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InventoryId'] = this.inventoryId;
    data['InventoryCode'] = this.inventoryCode;
    data['InventoryDate'] = this.inventoryDate;
    data['CommitteeId'] = this.committeeId;
    data['LocationId'] = this.locationId;
    data['Notes'] = this.notes;
    if (this.tbInventoryAssets != null) {
      data['TbInventoryAssets'] =
          this.tbInventoryAssets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TbInventoryAssets {
  String? assetId;
  bool? isExists;
  String? assetNote;

  TbInventoryAssets({this.assetId, this.isExists, this.assetNote});

  TbInventoryAssets.fromJson(Map<String, dynamic> json) {
    assetId = json['AssetId'];
    isExists = json['IsExists'];
    assetNote = json['AssetNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AssetId'] = this.assetId;
    data['IsExists'] = this.isExists;
    data['AssetNote'] = this.assetNote;
    return data;
  }
}
