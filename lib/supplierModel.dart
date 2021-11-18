class SupplierModel {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  List<ResponseData>? responseData;
  Null responseCount;

  SupplierModel(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.responseData,
      this.responseCount});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseMessage = json['response_message'];
    if (json['response_data'] != null) {
      responseData = <ResponseData>[];
      json['response_data'].forEach((v) {
        responseData!.add(new ResponseData.fromJson(v));
      });
    }
    responseCount = json['response_count'];
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
    data['response_count'] = this.responseCount;
    return data;
  }
}

class ResponseData {
  String? supplierId;
  int? supplierCode;
  String? supplierNameAr;
  String? supplierNameEn;
  String? mobile;
  String? supplierAddress;
  String? email;
  double? latitude;
  double? longitude;
  String? activityType;
  bool? isActive;
  bool? isDeleted;
  Null createdBy;
  Null createdDate;
  String? updatedBy;
  Null updatedDate;

  ResponseData(
      {required this.supplierId,
      required this.supplierCode,
      required this.supplierNameAr,
      required this.supplierNameEn,
      required this.mobile,
      required this.supplierAddress,
      required this.email,
      required this.latitude,
      required this.longitude,
      required this.activityType,
      required this.isActive,
      required this.isDeleted,
      required this.createdBy,
      this.createdDate,
      required this.updatedBy,
      this.updatedDate});

  ResponseData.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplierId'];
    supplierCode = json['supplierCode'];
    supplierNameAr = json['supplierNameAr'];
    supplierNameEn = json['supplierNameEn'];
    mobile = json['mobile'];
    supplierAddress = json['supplierAddress'];
    email = json['email'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    activityType = json['activityType'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierId'] = this.supplierId;
    data['supplierCode'] = this.supplierCode;
    data['supplierNameAr'] = this.supplierNameAr;
    data['supplierNameEn'] = this.supplierNameEn;
    data['mobile'] = this.mobile;
    data['supplierAddress'] = this.supplierAddress;
    data['email'] = this.email;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['activityType'] = this.activityType;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;

    return data;
  }
}
