import 'package:final_project_jarvis/Scheduling.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'voice.dart';
import 'welcome.dart';
import 'schedules.dart';

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
      home: MyHomePageWelcome(title: 'Flutter Demo Home Page'),
       routes: <String, WidgetBuilder>{
        '/chat': (BuildContext context) {
          return new HomePageDialogflow();
        },
        '/voice': (BuildContext context) {
          return new VoiceHome();
        },
        '/schedules': (BuildContext context) {
          return new MyHomePage();
        },
        '/manual': (BuildContext context) {
          return SchedulingPage(title: 'Schedule An Event');
        },
      }
    );
  }
}






