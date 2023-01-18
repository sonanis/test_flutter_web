import 'package:flutter/foundation.dart';
import 'package:test_flutter_web/src/json_analysis/convertor/dart_entity_convertor.dart';
import 'package:test_flutter_web/src/json_analysis/convertor/json_convertor.dart';
import 'package:test_flutter_web/src/json_analysis/json_analysis.dart';

class JsonEntityConverVM extends ChangeNotifier{
  String _resultText = '';
  String _originalText = '';
  String? _clsName;
  ConverConfig _converConfig = ConverConfig();


  JsonEntityConverVM();

  ConverConfig get converConfig => _converConfig;

  String get resultText => _resultText;

  void setNullsafety(bool safety){
    _converConfig = _converConfig.copyWith(nullSafety: safety);
    notifyListeners();

    changeInputText(_originalText);
  }

  void changeClsName(String? text){
    if(text != _clsName){
      _clsName = text;
      changeInputText(_originalText);
    }
  }

  void changeInputText(String text,{String? clsName}){
    _originalText = text;
    _clsName = clsName;
    try {
      if(text.isEmpty){
        _resultText = '';
        notifyListeners();
        return ;
      }
      JsonAnalysis analysis = JsonAnalysis.parse(text, rootName: _clsName);

      JsonObjectConvertor convertor = DartEntityConvertor();
      StringBuffer result = StringBuffer();
      List<JsonElement> objects = analysis.object;
      for(final obj in objects){
        String clsText = convertor.entityText(obj);
        result.write('$clsText\n\n');
      }
      _resultText = result.toString();
    } catch (e) {
      debugPrint('$e');
      _resultText = '$e';
    }
    notifyListeners();
  }
}