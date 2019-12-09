import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'main.dart';
import 'notifications.dart';
import 'model/todo_model.dart';
import 'model/todo.dart';

class HomePageDialogflow extends StatefulWidget {
  HomePageDialogflow({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageDialogflow createState() => new _HomePageDialogflow();
}

class _HomePageDialogflow extends State<HomePageDialogflow> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  void Response(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/JARVIS-83743aeeb4f1.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    ChatMessage message = new ChatMessage(
      text: response.getMessage() ??
          new CardDialogflow(response.getListMessage()[0]).title,
      name: "Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
      print(response.getMessage());
      //var _notifications = Notifications();
      //var _lastInsertedId = 1;
      //Old idea: split message into array, since the message is consistent, we'll get the index for each variable and call the addEvent function
      //New idea: Substring into string for each variable to be added
      //then they can either exit or create another event
      var m = response.getMessage();
      var arr = m.split(" "); 
      if (arr.length > 8){
        if (arr[0] == "Done!"){
          print("Hello");
          var start = "Event ";
          var end = " set";
          var startIndex = m.indexOf(start);
          var endIndex = m.indexOf(end, startIndex + start.length);
          //print(m.substring(startIndex + start.length, endIndex));
          //print(arr[5]);
          //print(arr[6]);
          var start2 = "set for";
          var end2 = " at";
          var startIndex2 = m.indexOf(start2);
          var endIndex2 = m.indexOf(end2, startIndex2 + start2.length);

          var start3 = "at ";
          var end3 = " ...";
          var startIndex3 = m.indexOf(start3);
          var endIndex3 = m.indexOf(end3, startIndex3 + start3.length);

          //print(m.substring(startIndex + start.length, endIndex));
          //print(m.substring(startIndex2 + start2.length, endIndex2));
          //print(m.substring(startIndex3 + start3.length, endIndex3));
          var _eventName = m.substring(startIndex + start.length, endIndex);
          var _eventDate = m.substring(startIndex2 + start2.length, endIndex2);
          var _eventLocation = m.substring(startIndex3 + start3.length, endIndex3);
          //var _eventDate = arr[6] + " " + arr[7];
          //print(m.substring(startIndex2 + start2.length, endIndex2));
          print(_eventName);
          print(_eventDate);
          print(_eventLocation);
          //Todo newTodotest = Todo(name: _eventName, dateTime: _eventDate.toString(), location: _eventLocation);
          //_lastInsertedId = await _model.insertTodo(newTodotest);
          //_firebaseModel.insertTodo(newTodotest);
          //_notifications.sendNotificationNow( 'V.A.A.S', 'The event "$_eventName" at "$_eventLocation" is on ($_eventDate)','payload');
        }
      }
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "Promise",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    Response(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Flutter and Dialogflow"),
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(child: new Text('B')),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: Theme.of(context).textTheme.subhead),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
            child: new Text(
          this.name[0],
          style: new TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}