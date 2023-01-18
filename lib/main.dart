import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_web/src/json_analysis/convertor/json_entity_conver.dart';
import 'package:test_flutter_web/src/res/diments.dart';
import 'package:test_flutter_web/src/widgets/json_entity_area.dart';
import 'package:test_flutter_web/src/widgets/json_input_area.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JsonEntityConverVM()),
      ],
      child: MaterialApp(
        // locale: const Locale('en'),
        locale: const Locale('zh'),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _clsEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = Diments.mainWidth;
            if(constraints.maxWidth > width){
              width = constraints.maxWidth;
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: width,
                height: Diments.mainHeight,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                          height: Diments.mainHeight,
                          child: JsonInputArea(
                            edit: _editingController,
                            clsNameEdit: _clsEditingController,
                            onChange: (text){
                              context.read<JsonEntityConverVM>()
                                  .changeInputText(text);
                            },
                          )),
                    ),

                    const SizedBox(width: 20,),

                    Expanded(
                        child: Container(
                        height: Diments.mainHeight,
                        child: JsonEntityArea())),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  

}
