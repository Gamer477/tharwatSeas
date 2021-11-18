class HBmodel {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  List<ResponseData>? responseData;
  Null responseToken;
  int? responseCount;
  Null responseAdditionalData;
  int? currentPage = 1;
  int? lastPage = 10;

  HBmodel(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.responseData,
      this.responseToken,
      this.responseCount,
      this.responseAdditionalData});

  HBmodel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseMessage = json['response_message'];
    if (json['response_data'] != null) {
      responseData = <ResponseData>[];
      json['response_data'].forEach((v) {
        responseData!.add(new ResponseData.fromJson(v));
      });
    }
    responseToken = json['response_token'];
    responseCount = json['response_count'];
    responseAdditionalData = json['response_additional_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    data['response_message'] = this.responseMessage;
    if (this.responseData != null) {
      data['response_data'] =
          this.responseData!.map((v) => v.toJson()).toList();
    }
    data['response_token'] = this.responseToken;
    data['response_count'] = this.responseCount;
    data['response_additional_data'] = this.responseAdditionalData;
    return data;
  }
}

class ResponseData {
  String? assetId;
  int? assetCode;
  String? assetBarcode;
  String? assetNameAr;
  String? assetNameEn;
  String? classificationNameAr;
  String? classificationNameEn;
  String? assetDescription;
  String? locationId;
  String? locationNameAr;
  String? locationNameEn;
  int? locationCode;
  bool? isDeleted;
  bool? isActive;
  String? assetImage;
  String? classificationId;
  String? supplierId;
  String? purchaseDate;
  double? purchasePrice;
  int? supplierCode;
  String? supplierNameAr;
  String? supplierNameEn;
  double? latitude;
  double? longitude;
  String? assetStatusId;
  String? assetStatusCode;
  String? assetStatusNameAr;
  String? assetStatusNameEn;

  ResponseData(
      {this.assetId,
      this.assetCode,
      this.assetBarcode,
      this.assetNameAr,
      this.assetNameEn,
      this.classificationNameAr,
      this.classificationNameEn,
      this.assetDescription,
      this.locationId,
      this.locationNameAr,
      this.locationNameEn,
      this.locationCode,
      this.isDeleted,
      this.isActive,
      this.assetImage,
      this.classificationId,
      this.supplierId,
      this.purchaseDate,
      this.purchasePrice,
      this.supplierCode,
      this.supplierNameAr,
      this.supplierNameEn,
      this.latitude,
      this.longitude,
      this.assetStatusId,
      this.assetStatusCode,
      this.assetStatusNameAr,
      this.assetStatusNameEn});

  ResponseData.fromJson(Map<String, dynamic> json) {
    assetId = json['assetId'];
    assetCode = json['assetCode'];
    assetBarcode = json['assetBarcode'];
    assetNameAr = json['assetNameAr'];
    assetNameEn = json['assetNameEn'];
    classificationNameAr = json['classificationNameAr'];
    classificationNameEn = json['classificationNameEn'];
    assetDescription = json['assetDescription'];
    locationId = json['locationId'];
    locationNameAr = json['locationNameAr'];
    locationNameEn = json['locationNameEn'];
    locationCode = json['locationCode'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    assetImage = json['assetImage'];
    classificationId = json['classificationId'];
    supplierId = json['supplierId'];
    purchaseDate = json['purchaseDate'];
    purchasePrice = json['purchasePrice'];
    supplierCode = json['supplierCode'];
    supplierNameAr = json['supplierNameAr'];
    supplierNameEn = json['supplierNameEn'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    assetStatusId = json['assetStatusId'];
    assetStatusCode = json['assetStatusCode'].toString();
    assetStatusNameAr = json['assetStatusNameAr'];
    assetStatusNameEn = json['assetStatusNameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetId'] = this.assetId;
    data['assetCode'] = this.assetCode;
    data['assetBarcode'] = this.assetBarcode;
    data['assetNameAr'] = this.assetNameAr;
    data['assetNameEn'] = this.assetNameEn;
    data['classificationNameAr'] = this.classificationNameAr;
    data['classificationNameEn'] = this.classificationNameEn;
    data['assetDescription'] = this.assetDescription;
    data['locationId'] = this.locationId;
    data['locationNameAr'] = this.locationNameAr;
    data['locationNameEn'] = this.locationNameEn;
    data['locationCode'] = this.locationCode;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['assetImage'] = this.assetImage;
    data['classificationId'] = this.classificationId;
    data['supplierId'] = this.supplierId;
    data['purchaseDate'] = this.purchaseDate;
    data['purchasePrice'] = this.purchasePrice;
    data['supplierCode'] = this.supplierCode;
    data['supplierNameAr'] = this.supplierNameAr;
    data['supplierNameEn'] = this.supplierNameEn;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['assetStatusId'] = this.assetStatusId;
    data['assetStatusCode'] = this.assetStatusCode;
    data['assetStatusNameAr'] = this.assetStatusNameAr;
    data['assetStatusNameEn'] = this.assetStatusNameEn;
    return data;
  }
}
