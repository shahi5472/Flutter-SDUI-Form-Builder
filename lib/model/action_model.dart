import 'dart:convert';

ActionModel actionFromJson(String str) =>
    ActionModel.fromJson(json.decode(str));

String actionToJson(ActionModel data) => json.encode(data.toJson());

class ActionModel {
  ActionModel({
    this.title,
    this.type,
  });

  ActionModel.fromJson(dynamic json) {
    title = json['title'];
    type = json['type'];
  }

  String? title;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['type'] = type;
    return map;
  }
}
