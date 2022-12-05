import 'package:test_flutter_web/src/json_analysis/json_analysis.dart';

const String indent = '    ';

abstract class JsonObjectConvertor{

  ConverConfig? config;

  JsonObjectConvertor({this.config});

  String entityText(JsonElement element);
}

class ConverConfig{
  bool nullSafety = true;

  ConverConfig({this.nullSafety = true});

  ConverConfig copyWith({bool? nullSafety}){
    return ConverConfig(
      nullSafety: nullSafety ?? this.nullSafety,
    );
  }
}