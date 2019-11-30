import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'i18n',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotePage(title: 'i18n'),
      localizationsDelegates: [
        FlutterI18nDelegate(
          useCountryCode: false,
          fallbackFile: 'en',
          path: 'assets/i18n',
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
*/

class NotePage extends StatefulWidget {
  NotePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Translate"),
        actions: <Widget>[
          FlatButton(
            child: Text('EN'),
            onPressed: () {
              Locale newLocale = Locale('en');
              setState(() {
                FlutterI18n.refresh(context, newLocale);
              });
            },
          ),
          FlatButton(
            child: Text('FR'),
            onPressed: () {
              Locale newLocale = Locale('fr');
              setState(() {
                FlutterI18n.refresh(context, newLocale);
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Text(FlutterI18n.translate(context, 'note.title')),
            title: Text(FlutterI18n.translate(context, 'note.description'))
          ),
        ],
      ),
    );
  }
}
