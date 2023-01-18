import 'dart:convert';

class JsonAnalysis{
  List<JsonElement>? _objects;
  String? rootName;

  List<JsonElement> get object => _objects ?? [];

  JsonAnalysis.parse(String jsonStr,{this.rootName}){
    final jsonContent = json.decode(jsonStr);
    String name = rootName ?? 'Entity';
    JsonElement rootElement = JsonElement.fromContent(name, jsonContent);
    _parseJsonElement(rootElement, name: name);
  }

  void _parseJsonElement(JsonElement element,{String? name, JsonElement? parent}){
    final jsonContent = element.jsonContent;
    if(jsonContent is Map){
      _createObjectElement(element);
      for (var key in jsonContent.keys){
        JsonElement child = JsonElement.fromContent(key, jsonContent[key]);
        _parseJsonElement(child, name: name, parent: element);
        element.addElement(child);
      }
    }else if(jsonContent is String){
      element.fieldType = 'String';
    }else if(jsonContent is int){
      element.fieldType = 'int';
    }else if(jsonContent is double){
      element.fieldType = 'double';
    }else if(jsonContent is num){
      element.fieldType = 'num';
    }else if(jsonContent is bool){
      element.fieldType = 'bool';
    }else if(jsonContent is List){
      element.fieldType = 'List';
      if(element is JsonArrayElement){
        element.castType = element.name;
      }
      if(jsonContent.isNotEmpty){
        dynamic ite = jsonContent.first;
        JsonElement child = JsonElement.fromContent(element.name, ite);
        _parseJsonElement(child, name: '${element.name}Item', parent: element);
        element.addElement(child);
      }
    }
  }

  void _createObjectElement(JsonElement element){
    _objects ??= [];
    _objects!.add(element);
  }

}

class JsonElement{
  String name;
  String? fieldType;
  dynamic jsonContent;
  List<JsonElement>? children;

  JsonElement(
      {
        required this.name,
        this.fieldType,
        this.jsonContent,
      });

  void addElement(JsonElement ele){
    children ??= [];
    children!.add(ele);
  }

  static JsonElement fromContent(String name, dynamic jsonContent){
    if(jsonContent is Map){
      return JsonObjectElement(name: name, jsonContent: jsonContent);
    }else if(jsonContent is List){
      return JsonArrayElement(name: name, jsonContent: jsonContent);
    }else if(jsonContent == null){
      return JsonNullElement(name: name);
    }
    return JsonElement(name: name, jsonContent: jsonContent);
  }
}

class JsonNullElement extends JsonElement{
  JsonNullElement({required super.name});
}

class JsonObjectElement extends JsonElement{
  JsonObjectElement({required super.name, super.jsonContent});
}

class JsonArrayElement extends JsonElement{
  String? castType;
  JsonArrayElement({required super.name, super.jsonContent});
}