import 'dart:convert';

class DartEntityEncoder extends Converter<String?, String>{

  final String? indent;


  DartEntityEncoder({this.indent = '    '});

  @override
  String convert(String? input) {
    return '';
  }

}