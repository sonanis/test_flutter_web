import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_flutter_web/src/res/diments.dart';
import 'package:test_flutter_web/src/utils/decoration_utils.dart';
import 'package:test_flutter_web/src/widgets/card_container.dart';

class JsonInputArea extends StatefulWidget {
  const JsonInputArea({Key? key, required this.edit, this.onChange,}) : super(key: key);
  final TextEditingController edit;
  final ValueChanged<String>? onChange;
  @override
  State<JsonInputArea> createState() => _JsonInputAreaState();
}

class _JsonInputAreaState extends State<JsonInputArea> {

  TextEditingController get edit => widget.edit;
  final FocusNode _jsonEditFocus = FocusNode();

  @override
  void initState() {
    _jsonEditFocus.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildInputLayout();
  }

  Widget _buildInputLayout(){
    return Column(
      children: [
        Container(
            height: Diments.tileHeight,
            child: _buildTopButtons()),
        Expanded(child: _buildInputArea()),
        Container(
            height: Diments.tileHeight,
            child: _buildBottomButtons()),
      ],
    );
  }

  Widget _buildInputArea(){
    return CardContainer(
      shadowColor: _jsonEditFocus.hasFocus ? Colors.blue : null,
      elevation: _jsonEditFocus.hasFocus ? 6 : 4,
      child: Container(
        decoration: DecorationUtils.round(
          bgColor: Color(0xFFF2F2F2),
        ),
        child: TextField(
          focusNode: _jsonEditFocus,
          controller: edit,
          maxLines: 999,
          decoration: const InputDecoration(
            hintText: '请在此输入Json字符串',
          ),
          onChanged: widget.onChange,
        ),
      ),
    );
  }

  Widget _buildTopButtons(){
    return Row(
      children: [
        TextButton(onPressed: (){
          try {
            final prettyString = const JsonEncoder.withIndent('    ').convert(json.decode(edit.text));
            edit.text = prettyString;
          } catch (e) {
            print(e);
          }
        }, child: Text('格式化')),
        TextButton(onPressed: (){
          edit.text = '';
        }, child: Text('清空')),
      ],
    );
  }

  Widget _buildBottomButtons(){
    return Row(
      children: [
        TextButton(onPressed: (){

        }, child: Text('生成Dart')),
      ],
    );
  }

}
