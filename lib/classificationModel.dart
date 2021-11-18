class ClassificationModel {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  List<ResponseData>? responseData;
  Null responseCount;

  ClassificationModel(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.responseData,
      this.responseCount});

  ClassificationModel.fromJson(Map<String, dynamic> json) {
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
  String? classificationId;
  int? classificationCode;
  String? classificationNameAr;
  String? classificationNameEn;
  bool? isLast;
  bool? isActive;
  String? createdBy;
  String? createdDate;
  String? updatedBy;
  Null updatedDate;
  String? parentClassificationId;

  ResponseData(
      {this.classificationId,
      this.classificationCode,
      this.classificationNameAr,
      this.classificationNameEn,
      this.isLast,
      this.isActive,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.parentClassificationId});

  ResponseData.fromJson(Map<String, dynamic> json) {
    classificationId = json['classificationId'];
    classificationCode = json['classificationCode'];
    classificationNameAr = json['classificationNameAr'];
    classificationNameEn = json['classificationNameEn'];
    isLast = json['isLast'];
    isActive = json['isActive'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
    parentClassificationId = json['parentClassificationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classificationId'] = this.classificationId;
    data['classificationCode'] = this.classificationCode;
    data['classificationNameAr'] = this.classificationNameAr;
    data['classificationNameEn'] = this.classificationNameEn;
    data['isLast'] = this.isLast;
    data['isActive'] = this.isActive;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    data['parentClassificationId'] = this.parentClassificationId;

    return data;
  }
}
