class SupModel {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  List<ResponseData>? responseData;
  Null responseCount;

  SupModel(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.responseData,
      this.responseCount});

  SupModel.fromJson(Map<String, dynamic> json) {
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
  String? assetStatusId;
  int? assetStatusCode;
  String? assetStatusNameAr;
  String? assetStatusNameEn;
  bool? isActive;
  bool? isDeleted;
  String? createdBy;
  Null deletedBy;
  String? createdDate;
  Null updatedBy;
  Null updatedDate;

  ResponseData(
      {this.assetStatusId,
      this.assetStatusCode,
      this.assetStatusNameAr,
      this.assetStatusNameEn,
      this.isActive,
      this.isDeleted,
      this.createdBy,
      this.deletedBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate});

  ResponseData.fromJson(Map<String, dynamic> json) {
    assetStatusId = json['assetStatusId'];
    assetStatusCode = json['assetStatusCode'];
    assetStatusNameAr = json['assetStatusNameAr'];
    assetStatusNameEn = json['assetStatusNameEn'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    deletedBy = json['deletedBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assetStatusId'] = this.assetStatusId;
    data['assetStatusCode'] = this.assetStatusCode;
    data['assetStatusNameAr'] = this.assetStatusNameAr;
    data['assetStatusNameEn'] = this.assetStatusNameEn;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['deletedBy'] = this.deletedBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
