import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_web/src/json_analysis/convertor/json_convertor.dart';
import 'package:test_flutter_web/src/json_analysis/convertor/json_entity_conver.dart';
import 'package:test_flutter_web/src/res/diments.dart';
import 'package:test_flutter_web/src/utils/decoration_utils.dart';
import 'package:flutter/services.dart';

class JsonEntityArea extends StatefulWidget {
  const JsonEntityArea({Key? key, this.text = ''}) : super(key: key);
  final String text;
  @override
  State<JsonEntityArea> createState() => _JsonEntityAreaState();
}

class _JsonEntityAreaState extends State<JsonEntityArea> {
  @override
  Widget build(BuildContext context) {
    return _buildResultLayout();
  }

  Widget _buildResultLayout(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Diments.tileHeight,
          child: Selector<JsonEntityConverVM, ConverConfig>(
              selector: (_, model) => model.converConfig,
              shouldRebuild: (pre, next) => pre != next,
              builder: (ctx, config, _) {
                return CheckboxListTile(
                    title: const Text('Null safety'),
                    value: config.nullSafety,
                    onChanged: (val){
                      ctx.read<JsonEntityConverVM>().setNullsafety(val ?? true);
                });
              }
          ),
        ),
        Expanded(child: _buildParseReult()),

        Container(
          height: Diments.tileHeight,
          child: _buildBottomButtons(),
        ),
      ],
    );
  }



  Widget _buildParseReult(){
    return Container(
      decoration: DecorationUtils.round(
        bgColor: Color(0xFFF2F2F2),
      ),
      child: Selector<JsonEntityConverVM, String>(
          selector: (_, model) => model.resultText,
          shouldRebuild: (pre, next) => pre != next,
          builder: (context, text, _) {
            return LayoutBuilder(builder: (ctx, c){
              Widget resultContent = Text(text, maxLines: 999,);
              if(text.isEmpty){
                return Container(
                    width: c.maxWidth,
                    height: c.maxHeight,
                    child: resultContent);
              }
              resultContent = SelectableText(text, maxLines: 999,);
              return Container(
                  width: c.maxWidth,
                  height: c.maxHeight,
                  child: resultContent);
            });
          }
      ),
    );
  }

  Widget _buildBottomButtons(){
    return TextButton(onPressed: (){
      Clipboard.setData(ClipboardData(
          text: context.read<JsonEntityConverVM>().resultText));
    }, child: Text('复制'));
  }

}
