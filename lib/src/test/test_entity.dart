class Entity {
  int? code;
  String? msg;
  List<Data>? data;
  Data2? data2;

  Entity.fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.msg = json['msg'];
    if(json['data'] is List) {
      this.data = [];
      for(final v in json['data']){
        this.data!.add(Data.fromJson(v));
      }
    }
    if(json['data2'] != null) {
      this.data2 = Data2.fromJson(json['data2']);
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.data2 != null) {
      data['data2'] = this.data2!.toJson();
    }
    return data;
  }

}

class Data {
  String? id;
  String? value;

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.value = json['value'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }

}

class Data2 {
  String? value;
  String? label;

  Data2.fromJson(Map<String, dynamic> json) {
    this.value = json['value'];
    this.label = json['label'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }

}

