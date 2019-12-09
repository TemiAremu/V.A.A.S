import 'package:final_project_jarvis/Scheduling.dart';
import 'package:final_project_jarvis/translate.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'voice.dart';
import 'welcome.dart';
import 'schedules.dart';
import 'chart.dart';
import 'map.dart';
import 'datatable.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Example Dialogflow Flutter',
      theme: new ThemeData(
        primarySwatch: Colors.orange,  
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      localizationsDelegates: [
        FlutterI18nDelegate(
          useCountryCode: false,
          fallbackFile: 'en',
          path: 'assets/i18n',
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      //Routes created to get through the pages
       routes: <String, WidgetBuilder>{
        '/chat': (BuildContext context) {
          return new HomePageDialogflow();
        },
        '/voice': (BuildContext context) {
          return new VoiceHome();
        },
        '/schedules': (BuildContext context) {
          return MyHomePage();
        },
        '/manual': (BuildContext context) {
          return SchedulingPage(title: 'Schedule An Event');
        },
        '/chart': (BuildContext context) {
          return ChartPage(title: 'Most used locations');
        },
        '/map': (BuildContext context) {
          return new HomeMap();
        },
        '/translate': (BuildContext context){
          return new NotePage();
        },
        '/table': (BuildContext context){
          return new TablePage();
        },
      }
    );
  }
}






