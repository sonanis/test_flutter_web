class ExtraTask {
  int? code;
  String? msg;
  List<Data>? data;
  int? total;
  bool? isLogin;

  ExtraTask ({
    this.code,
    this.msg,
    this.data,
    this.total,
    this.isLogin,
  });


  ExtraTask.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if(json['data'] is List) {
      data = [];
      for(final v in json['data']){
        data!.add(Data.fromJson(v));
      }
    }
    total = json['total'];
    isLogin = json['isLogin'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['isLogin'] = isLogin;
    return data;
  }

}

class Data {
  String? taskId;
  String? taskCode;
  String? taskName;
  String? planStartTime;
  String? planEndTime;
  String? userId;
  String? userName;
  String? mobile;
  int? taskState;
  String? taskStateLabel;
  int? category;
  String? categoryLabel;
  int? isExpired;
  int? superviseLevel;
  String? superviseLevelLabel;
  String? createdTime;

  Data ({
    this.taskId,
    this.taskCode,
    this.taskName,
    this.planStartTime,
    this.planEndTime,
    this.userId,
    this.userName,
    this.mobile,
    this.taskState,
    this.taskStateLabel,
    this.category,
    this.categoryLabel,
    this.isExpired,
    this.superviseLevel,
    this.superviseLevelLabel,
    this.createdTime,
  });


  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    taskCode = json['taskCode'];
    taskName = json['taskName'];
    planStartTime = json['planStartTime'];
    planEndTime = json['planEndTime'];
    userId = json['userId'];
    userName = json['userName'];
    mobile = json['mobile'];
    taskState = json['taskState'];
    taskStateLabel = json['taskStateLabel'];
    category = json['category'];
    categoryLabel = json['categoryLabel'];
    isExpired = json['isExpired'];
    superviseLevel = json['superviseLevel'];
    superviseLevelLabel = json['superviseLevelLabel'];
    createdTime = json['createdTime'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskId'] = taskId;
    data['taskCode'] = taskCode;
    data['taskName'] = taskName;
    data['planStartTime'] = planStartTime;
    data['planEndTime'] = planEndTime;
    data['userId'] = userId;
    data['userName'] = userName;
    data['mobile'] = mobile;
    data['taskState'] = taskState;
    data['taskStateLabel'] = taskStateLabel;
    data['category'] = category;
    data['categoryLabel'] = categoryLabel;
    data['isExpired'] = isExpired;
    data['superviseLevel'] = superviseLevel;
    data['superviseLevelLabel'] = superviseLevelLabel;
    data['createdTime'] = createdTime;
    return data;
  }

}

class ExtData {

  ExtData.fromJson(Map<String, dynamic> json) {
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }

}

