class LoginModel {
  String? responseCode;
  String? responseStatus;
  String? responseMessage;
  ResponseData? responseData;
  String? responseToken;
  Null responseCount;
  List<ResponseAdditionalData>? responseAdditionalData;

  LoginModel(
      {this.responseCode,
      this.responseStatus,
      this.responseMessage,
      this.responseData,
      this.responseToken,
      this.responseCount,
      this.responseAdditionalData});

  LoginModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    responseStatus = json['response_status'];
    responseMessage = json['response_message'];
    responseData = json['response_data'] != null
        ? new ResponseData.fromJson(json['response_data'])
        : null;
    responseToken = json['response_token'];
    responseCount = json['response_count'];
    if (json['response_additional_data'] != null) {
      responseAdditionalData = <ResponseAdditionalData>[];
      json['response_additional_data'].forEach((v) {
        responseAdditionalData!.add(new ResponseAdditionalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['response_status'] = this.responseStatus;
    data['response_message'] = this.responseMessage;
    if (this.responseData != null) {
      data['response_data'] = this.responseData!.toJson();
    }
    data['response_token'] = this.responseToken;
    data['response_count'] = this.responseCount;
    if (this.responseAdditionalData != null) {
      data['response_additional_data'] =
          this.responseAdditionalData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseData {
  String? userId;
  String? userGroupId;
  int? userCode;
  String? userNameAr;
  String? userNameEn;
  bool? isActive;
  String? userName;
  String? email;
  String? phoneNumber;
  Null userGroupNameAr;
  Null userGroupNameEn;

  ResponseData(
      {this.userId,
      this.userGroupId,
      this.userCode,
      this.userNameAr,
      this.userNameEn,
      this.isActive,
      this.userName,
      this.email,
      this.phoneNumber,
      this.userGroupNameAr,
      this.userGroupNameEn});

  ResponseData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userGroupId = json['userGroupId'];
    userCode = json['userCode'];
    userNameAr = json['userNameAr'];
    userNameEn = json['userNameEn'];
    isActive = json['isActive'];
    userName = json['userName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    userGroupNameAr = json['userGroupNameAr'];
    userGroupNameEn = json['userGroupNameEn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userGroupId'] = this.userGroupId;
    data['userCode'] = this.userCode;
    data['userNameAr'] = this.userNameAr;
    data['userNameEn'] = this.userNameEn;
    data['isActive'] = this.isActive;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['userGroupNameAr'] = this.userGroupNameAr;
    data['userGroupNameEn'] = this.userGroupNameEn;
    return data;
  }
}

class ResponseAdditionalData {
  String? objectId;
  String? userGroupId;
  bool? canEnter;
  bool? canAdd;
  bool? canEdit;
  bool? canShow;
  bool? canDelete;
  bool? canPrint;
  int? objectCode;
  String? objectNameAr;
  String? objectNameEn;
  String? objectRealName;
  int? userGroupCode;
  Null userGroupNameAr;
  Null userGroupNameEn;
  int? objectType;
  bool? isDeleted;
  bool? hasEnter;
  bool? hasAdd;
  bool? hasEdit;
  bool? hasShow;
  bool? hasDelete;
  bool? hasPrint;
  bool? showInMenu;
  bool? isActive;
  String? redirectTo;

  ResponseAdditionalData(
      {this.objectId,
      this.userGroupId,
      this.canEnter,
      this.canAdd,
      this.canEdit,
      this.canShow,
      this.canDelete,
      this.canPrint,
      this.objectCode,
      this.objectNameAr,
      this.objectNameEn,
      this.objectRealName,
      this.userGroupCode,
      this.userGroupNameAr,
      this.userGroupNameEn,
      this.objectType,
      this.isDeleted,
      this.hasEnter,
      this.hasAdd,
      this.hasEdit,
      this.hasShow,
      this.hasDelete,
      this.hasPrint,
      this.showInMenu,
      this.isActive,
      this.redirectTo});

  ResponseAdditionalData.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    userGroupId = json['userGroupId'];
    canEnter = json['canEnter'];
    canAdd = json['canAdd'];
    canEdit = json['canEdit'];
    canShow = json['canShow'];
    canDelete = json['canDelete'];
    canPrint = json['canPrint'];
    objectCode = json['objectCode'];
    objectNameAr = json['objectNameAr'];
    objectNameEn = json['objectNameEn'];
    objectRealName = json['objectRealName'];
    userGroupCode = json['userGroupCode'];
    userGroupNameAr = json['userGroupNameAr'];
    userGroupNameEn = json['userGroupNameEn'];
    objectType = json['objectType'];
    isDeleted = json['isDeleted'];
    hasEnter = json['hasEnter'];
    hasAdd = json['hasAdd'];
    hasEdit = json['hasEdit'];
    hasShow = json['hasShow'];
    hasDelete = json['hasDelete'];
    hasPrint = json['hasPrint'];
    showInMenu = json['showInMenu'];
    isActive = json['isActive'];
    redirectTo = json['redirectTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this.objectId;
    data['userGroupId'] = this.userGroupId;
    data['canEnter'] = this.canEnter;
    data['canAdd'] = this.canAdd;
    data['canEdit'] = this.canEdit;
    data['canShow'] = this.canShow;
    data['canDelete'] = this.canDelete;
    data['canPrint'] = this.canPrint;
    data['objectCode'] = this.objectCode;
    data['objectNameAr'] = this.objectNameAr;
    data['objectNameEn'] = this.objectNameEn;
    data['objectRealName'] = this.objectRealName;
    data['userGroupCode'] = this.userGroupCode;
    data['userGroupNameAr'] = this.userGroupNameAr;
    data['userGroupNameEn'] = this.userGroupNameEn;
    data['objectType'] = this.objectType;
    data['isDeleted'] = this.isDeleted;
    data['hasEnter'] = this.hasEnter;
    data['hasAdd'] = this.hasAdd;
    data['hasEdit'] = this.hasEdit;
    data['hasShow'] = this.hasShow;
    data['hasDelete'] = this.hasDelete;
    data['hasPrint'] = this.hasPrint;
    data['showInMenu'] = this.showInMenu;
    data['isActive'] = this.isActive;
    data['redirectTo'] = this.redirectTo;
    return data;
  }
}
