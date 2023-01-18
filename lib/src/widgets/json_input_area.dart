import 'dart:convert';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_web/src/json_analysis/convertor/json_entity_conver.dart';
import 'package:test_flutter_web/src/res/diments.dart';
import 'package:test_flutter_web/src/utils/decoration_utils.dart';
import 'package:test_flutter_web/src/widgets/card_container.dart';

class JsonInputArea extends StatefulWidget {
  const JsonInputArea({
    Key? key,
    required this.edit,
    required this.clsNameEdit,
    this.onChange,
  }) : super(key: key);
  final TextEditingController edit;
  final TextEditingController clsNameEdit;
  final ValueChanged<String>? onChange;
  @override
  State<JsonInputArea> createState() => _JsonInputAreaState();
}

class _JsonInputAreaState extends State<JsonInputArea> {

  TextEditingController get edit => widget.edit;
  TextEditingController get clsEdit => widget.clsNameEdit;
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
        SizedBox(
            height: Diments.tileHeight,
            child: _buildTopButtons()),
        Expanded(child: _buildInputArea()),
        SizedBox(
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
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.inputJsonAreaHint,
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
        }, child: Text(AppLocalizations.of(context)!.formatBtnText)),
        TextButton(onPressed: (){
          edit.text = '';
        }, child: Text(AppLocalizations.of(context)!.cleanBtnTest)),
      ],
    );
  }

  Widget _buildBottomButtons(){
    return Row(
      children: [
        Expanded(child: TextField(
          controller: clsEdit,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.inputClassNameHint,
          ),
        )),
        TextButton(onPressed: (){
          context.read<JsonEntityConverVM>()
              .changeInputText(edit.text, clsName: clsEdit.text);
        }, child: Text(AppLocalizations.of(context)!.genDartText)),
      ],
    );
  }

}
