class CommitteeModel {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  List<ResponseData>? responseData;
  Null responseCount;
  Null responseAdditionalData;

  CommitteeModel(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.responseData,
      this.responseCount,
      this.responseAdditionalData});

  CommitteeModel.fromJson(Map<String, dynamic> json) {
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
    data['response_count'] = this.responseCount;
    data['response_additional_data'] = this.responseAdditionalData;
    return data;
  }
}

class ResponseData {
  String? committeeId;
  int? committeeCode;
  String? committeeNameAr;
  String? committeeNameEn;
  bool? isActive;
  bool? isDeleted;
  Null createdBy;
  String? createdDate;
  Null updatedBy;
  Null updatedDate;

  ResponseData({
    this.committeeId,
    this.committeeCode,
    this.committeeNameAr,
    this.committeeNameEn,
    this.isActive,
    this.isDeleted,
    this.createdBy,
    this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    committeeId = json['committeeId'];
    committeeCode = json['committeeCode'];
    committeeNameAr = json['committeeNameAr'];
    committeeNameEn = json['committeeNameEn'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    createdBy = json['createdBy'];
    createdDate = json['createdDate'];
    updatedBy = json['updatedBy'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['committeeId'] = this.committeeId;
    data['committeeCode'] = this.committeeCode;
    data['committeeNameAr'] = this.committeeNameAr;
    data['committeeNameEn'] = this.committeeNameEn;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedBy'] = this.updatedBy;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}
