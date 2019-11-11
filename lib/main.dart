import 'package:flutter/material.dart';
import 'chat.dart';
import 'voice.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
       routes: <String, WidgetBuilder>{
        '/chat': (BuildContext context) {
          return new HomePageDialogflow();
        },
        '/voice': (BuildContext context) {
          return new VoiceHome();
        }
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

   

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<String> schedulelist = [
    "Test1", "Test2", "Test3", "Test4"
  ];

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
   bool isSelected;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
      (
        title: Text("Schedule list"),
        actions: <Widget>
        [
          IconButton(
            icon: Icon(Icons.mic),
            onPressed: () 
            { 
              
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () 
            { 
                
            }
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () 
            { 
              
            }
          ),
    
        ]

      ),
      body: 
      Container(
       child: new ListView.builder
        (
          itemCount: schedulelist.length,
          itemBuilder: (BuildContext ctxt, int index) 
          {            
            return new Card
            ( 
              child: Container(
                child: GestureDetector(
                  child: tilebuild(schedulelist[index], schedulelist[index] + "SUB", index),
                  onTap: () => setState((){ _selectedIndex = index; isSelected = true;})
                )
              )
            );
          }
        ),

      ),
      floatingActionButton: FloatingActionButton(
          onPressed:(){
              _showDialog(context);
            },
          child: Icon(Icons.add),
          backgroundColor: Colors.deepOrange,
        ),
    );
  }

   Widget tilebuild(String sid,String grade,int index)
  {
    bool isSelected = _selectedIndex == index;
    return Container(
      decoration: BoxDecoration(color: isSelected ? Colors.orange :Colors.white),
      child: ListTile(
          title: Text(sid),
          subtitle: Text(grade),
        )
      );
  }
}

Future <void> _showchat(BuildContext context) async {
    var event1 = await Navigator.pushNamed(context, '/chat');
  }

Future <void> _showvoice(BuildContext context) async {
    var event = await Navigator.pushNamed(context, '/voice');
  }

  Future <void> _showDialog(BuildContext context) async {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Chat"),
              onPressed: () {
                _showchat(context);
              },
            ),
            new FlatButton(
              child: new Text("Voice"),
              onPressed: () {
                _showvoice(context);
              },
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }




