import 'package:intl/intl.dart';
import 'package:test_flutter_web/src/json_analysis/convertor/json_convertor.dart';
import 'package:test_flutter_web/src/json_analysis/json_analysis.dart';

class DartEntityConvertor extends JsonObjectConvertor{

  DartEntityConvertor({ConverConfig? config}) : super(config: config);

  String _fieldObjText(JsonElement field, int indentLevel){
    StringBuffer buffer = StringBuffer();
    writeIndentation(buffer, indentLevel);
    buffer.writeln('if(json[\'${field.name}\'] != null) {');
    writelnWithIndentation(buffer, indentLevel + 1, 'this.${field.name} = ${toBeginningOfSentenceCase(field.name)}.fromJson(json[\'${field.name}\']);');
    writelnWithIndentation(buffer, indentLevel, '}');

    String temp = '''
    if(json['${field.name}'] != null) {
    ${indent}${indent}this.${field.name} = ${toBeginningOfSentenceCase(field.name)}.fromJson(json['${field.name}']);
    ${indent}}
    ''';
    return buffer.toString();
  }

  String _fieldArrayText(JsonElement field, int indentLevel){
    JsonArrayElement arrayElement = field as JsonArrayElement;

    StringBuffer buffer = StringBuffer();
    writelnWithIndentation(buffer, indentLevel, 'if(json[\'${field.name}\'] is List) {');
    writelnWithIndentation(buffer, indentLevel+1, 'this.${field.name} = [];');
    writelnWithIndentation(buffer, indentLevel+1, 'for(final v in json[\'${field.name}\']){');
    writelnWithIndentation(buffer, indentLevel+2, 'this.${field.name}!.add(${toBeginningOfSentenceCase(arrayElement.castType)}.fromJson(v));');
    writelnWithIndentation(buffer, indentLevel+1, '}');
    writelnWithIndentation(buffer, indentLevel, '}');

    String temp = '''
    ${indent}if(json['${field.name}'] is List) {
    ${indent}${indent}this.${field.name} = [];
    ${indent}${indent}for(final v in json['${field.name}']){
    ${indent}${indent}${indent}this.${field.name}!.add(${toBeginningOfSentenceCase(arrayElement.castType)}.fromJson(v));
    ${indent}${indent}}
    ${indent}}
    ''';
    return buffer.toString();
  }

  String _fieldObjToJson(JsonElement field, int indentLevel){

    StringBuffer buffer = StringBuffer();
    writelnWithIndentation(buffer, indentLevel, 'if (this.${field.name} != null) {');
    writelnWithIndentation(buffer, indentLevel+1, "data['${field.name}'] = this.${field.name}!.toJson();");
    writelnWithIndentation(buffer, indentLevel, '}');

    String temp = '''
    if (this.${field.name} != null) {
    ${indent}${indent}data['${field.name}'] = this.${field.name}!.toJson();
    ${indent}}
    ''';
    return buffer.toString();
  }

  String _fieldArrayToJson(JsonElement field, int indentLevel){

    StringBuffer buffer = StringBuffer();
    writelnWithIndentation(buffer, indentLevel, 'if (this.${field.name} != null) {');
    writelnWithIndentation(buffer, indentLevel+1, "data['${field.name}'] = this.${field.name}!.map((v) => v.toJson()).toList();");
    writelnWithIndentation(buffer, indentLevel, '}');

    JsonArrayElement arrayElement = field as JsonArrayElement;
    String temp = '''
    ${indent}if (this.${field.name} != null) {
    ${indent}${indent}data['${field.name}'] = this.${field.name}!.map((v) => v.toJson()).toList();
    ${indent}}
    ''';
    return buffer.toString();
  }

  String objectToJsonMapText(JsonElement element){
    int indentLevel = 1;
    StringBuffer result = StringBuffer();

    writelnWithIndentation(result, indentLevel, "Map<String, dynamic> toJson() {");
    writelnWithIndentation(result, indentLevel+1, "final Map<String, dynamic> data = <String, dynamic>{};");

    if(element.children != null){
      for(final field in element.children!){

        if(field is JsonObjectElement){
          result.write(_fieldObjToJson(field, indentLevel + 1));
        } else if(field is JsonArrayElement){
          result.write(_fieldArrayToJson(field, indentLevel + 1));
        } else if(field is JsonNullElement){

        } else{
          // String temp = "$indent${indent}data['${field.name}'] = this.${field.name};\n";
          // result.write(temp);
          writelnWithIndentation(result, indentLevel+1, "data['${field.name}'] = this.${field.name};");
        }
      }
    }

    // result.write('\n'
    //     '$indent${indent}return data;');
    // result.write('\n$indent}');
    writelnWithIndentation(result, indentLevel+1, 'return data;');
    writelnWithIndentation(result, indentLevel, '}');
    return result.toString();
  }

  String objectFromJsonText(JsonElement element){
    int indentLevel = 1;
    String clsName = toBeginningOfSentenceCase(element.name) ?? element.name;
    String paramName = 'json';
    StringBuffer result = StringBuffer();
    writelnWithIndentation(result, indentLevel, '$clsName.fromJson(Map<String, dynamic> $paramName) {');

    if(element.children != null){
      for(final field in element.children!){

        if(field is JsonObjectElement){
          result.write(_fieldObjText(field, indentLevel+1));
        } else if(field is JsonArrayElement){
          result.write(_fieldArrayText(field, indentLevel+1));
        } else if(field is JsonNullElement){

        } else{
          writelnWithIndentation(result, indentLevel+1, "this.${field.name} = $paramName['${field.name}'];");
          // String temp = "this.${field.name} = $paramName['${field.name}'];";
          // result.writeln(temp);
        }
      }
    }
    writelnWithIndentation(result, indentLevel, "}");
    // result.write('$indent}');
    return result.toString();
  }

  String? clsConstructorText(JsonElement element){
    if( !(element.children?.isEmpty ?? true) ){
      /// class里有属性时才生成构造函数
      int indentLevel = 1;
      String clsName = toBeginningOfSentenceCase(element.name) ?? element.name;
      StringBuffer result = StringBuffer();
      writelnWithIndentation(result, indentLevel, '$clsName ({');
      for(final field in element.children!){
        writelnWithIndentation(result, indentLevel+1, 'this.${field.name},');
      }
      writelnWithIndentation(result, indentLevel, '});');
      return result.toString();
    }
    return null;
  }

  @override
  String entityText(JsonElement element) {
    bool nullSafety = config?.nullSafety ?? true;
    int indentLeave = 1;
    StringBuffer result = StringBuffer();
    String clsName = '';
    if(element is JsonObjectElement){
      clsName = toBeginningOfSentenceCase(element.name) ?? element.name;
      result.write('class $clsName { \n');
      if (element.children != null) {
        for (final c in element.children!) {
          String type = c.fieldType ?? c.name;
          bool isNull = c is JsonNullElement;
          if(c is JsonObjectElement){
            type = toBeginningOfSentenceCase(type) ?? type;
          }else if(isNull){
            type = 'Null';
          }
          List<String> temp = [type];
          if(c is JsonArrayElement && c.castType != null && c.castType!.isNotEmpty){
            temp.add('<${toBeginningOfSentenceCase(c.castType) ?? c.castType}>');
          }
          if(nullSafety && !isNull){
            temp.add('?');
          }
          temp.add(' ${c.name};');
          writeIndentation(result, indentLeave);
          result.write('${temp.join('')}\n');
        }
      }
      String? constructorText = clsConstructorText(element);
      String fromJsonText = objectFromJsonText(element);
      String toJsonText = objectToJsonMapText(element);
      if( !(constructorText?.isEmpty ?? true) ){
        result.write('\n$constructorText\n');
      }
      result.write('\n$fromJsonText\n');
      result.write('\n$toJsonText\n');
      result.write('}');
    }
    return result.toString();
  }

  void writeIndentation(StringSink sink, int count) {
    for (var i = 0; i < count; i++) {
      sink.write(indent);
    }
  }

  void writelnWithIndentation(StringSink sink, int count, Object? obj) {
    for (var i = 0; i < count; i++) {
      sink.write(indent);
    }
    sink.writeln(obj);
  }
}