class LocationModel {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  List<ResponseData>? responseData;
  Null responseCount;

  LocationModel(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.responseData,
      this.responseCount});

  LocationModel.fromJson(Map<String, dynamic> json) {
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
  String? locationId;
  int? locationCode;
  String? locationNameAr;
  String? locationNameEn;
  bool? isActive;
  bool? isDeleted;
  String? createdBy;
  String? deletedBy;
  String? createdDate;
  String? updatedBy;
  String? updatedDate;

  ResponseData(
      {this.locationId,
      this.locationCode,
      this.locationNameAr,
      this.locationNameEn,
      this.isActive,
      this.isDeleted,
      this.createdBy,
      this.deletedBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate});

  ResponseData.fromJson(Map<String, dynamic> json) {
    locationId = json['locationId'];
    locationCode = json['locationCode'];
    locationNameAr = json['locationNameAr'];
    locationNameEn = json['locationNameEn'];
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
    data['locationId'] = this.locationId;
    data['locationCode'] = this.locationCode;
    data['locationNameAr'] = this.locationNameAr;
    data['locationNameEn'] = this.locationNameEn;
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
