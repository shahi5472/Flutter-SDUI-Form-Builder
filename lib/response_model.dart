import 'dart:convert';

import 'package:sdui_form_builder/model/action_model.dart';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.data,
  });

  ResponseModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.sections,
  });

  Data.fromJson(dynamic json) {
    if (json['sections'] != null) {
      sections = [];
      json['sections'].forEach((v) {
        sections?.add(Sections.fromJson(v));
      });
    }
  }

  List<Sections>? sections;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sections != null) {
      map['sections'] = sections?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Sections sectionsFromJson(String str) => Sections.fromJson(json.decode(str));

String sectionsToJson(Sections data) => json.encode(data.toJson());

class Sections {
  Sections({
    this.uiType,
    this.content,
    this.action,
  });

  Sections.fromJson(dynamic json) {
    uiType = json['ui_type'];
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    action =
        json['action'] != null ? ActionModel.fromJson(json['action']) : null;
  }

  String? uiType;
  Content? content;
  ActionModel? action;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ui_type'] = uiType;
    if (content != null) {
      map['content'] = content?.toJson();
    }
    if (action != null) {
      map['action'] = action?.toJson();
    }
    return map;
  }
}

Content contentFromJson(String str) => Content.fromJson(json.decode(str));

String contentToJson(Content data) => json.encode(data.toJson());

class Content {
  Content({
    this.hint,
    this.label,
    this.inputType,
    this.value,
    this.validateMessage,
    this.readOnly,
    this.attribute,
  });

  Content.fromJson(dynamic json) {
    hint = json['hint'];
    label = json['label'];
    inputType = json['input_type'];
    value = json['value'];
    validateMessage = json['validate_message'];
    readOnly = json['read_only'];
    attribute = json['attribute'];
  }

  String? hint;
  String? label;
  String? inputType;
  String? value;
  String? validateMessage;
  bool? readOnly;
  String? attribute;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hint'] = hint;
    map['label'] = label;
    map['input_type'] = inputType;
    map['value'] = value;
    map['validate_message'] = validateMessage;
    map['read_only'] = readOnly;
    map['attribute'] = attribute;
    return map;
  }
}
