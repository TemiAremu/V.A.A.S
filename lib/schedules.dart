import 'package:flutter/material.dart';
import 'chat.dart';
import 'voice.dart';
import 'welcome.dart';

import 'model/todo_model.dart';
import 'model/todo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model_firebase.dart';

Todo t;

 CollectionReference dbReplies = Firestore.instance.collection('replies');

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<String> schedulelist = [
    "Test1", "Test2", "Test3", "Test4"
  ];

  List<Todo> slist = [
   
  ];

  int listilelengthcheck = 1;

    final _model = TodoModel();
    bool isSelected;

    bool isEmpty = true;

     int _selectedIndex = 0;
   

  var _todoItem1;
  var _todoItem2;
  var _todoItem3;

class _MyHomePageState extends State<MyHomePage> {

  var _lastInsertedId = 1;

  @override
  /*
  void initState()
  {
    super.initState();
    
    updateTodo();
  }
  */

  Widget build(BuildContext context) {
    //updateTodo();
    return Scaffold(
      appBar: AppBar
      (
        title: Text("Schedule list"),
        actions: <Widget>
        [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () 
            { 
              updateTodo();
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
              _deleteTodo();
            }
          ),
    
        ]

      ),
      body: 
      Container(
        
       child: new ListView.builder
        (
          itemCount: isEmpty ? 0 : slist.length,
          itemBuilder: (BuildContext ctxt, int index) 
          {         
            return new Card
            ( 
              child: Container(
                child: GestureDetector(
                  child: tilebuild(slist[index], index),
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

   Widget tilebuild(Todo passedindex,int index)
  {
    print(passedindex);
    bool isSelected = _selectedIndex == index;
    return Container(
      decoration: BoxDecoration(color: isSelected ? Colors.orange :Colors.white),
      child: ListTile(
          title: Text(passedindex.name + "    " + passedindex.dateTime),
          subtitle: Text(passedindex.location),
        )
      );
  }


Future <void> _showchat(BuildContext context) async {
    var event1 = await Navigator.pushNamed(context, '/chat');
  }

Future <void> _showvoice(BuildContext context) async {
    var event = await Navigator.pushNamed(context, '/voice');
  }

   Future<void> _addTodo() async {
    print(t.name);
    print(t.dateTime);
    print(t.location);

    
    Todo newTodo = Todo(name: t.name, dateTime: t.dateTime, location: t.location);
    _lastInsertedId = await _model.insertTodo(newTodo);

    isEmpty = false;
    
    slist.add(Todo(name: newTodo.name, dateTime: newTodo.dateTime, location: newTodo.location));

  
    //int testinsert = await insertFirestoreItem(newTodo);


    updateTodo();
  
  }

   Future<void> updateTodo() async {
    //pages.clear();
    
    List<Todo> todos = await _model.getAllTodos();

    setState(() => slist = todos);
    
    print(slist);

  }

  Future<void> _deleteTodo() async {
    _model.deleteTodo(_selectedIndex+1);
    slist.removeAt(_selectedIndex);
    isEmpty = true;
    updateTodo();
    
  }

  Future<void> _listTodos() async {
    List<Todo> todos = await _model.getAllTodos();
    print('To Dos:');
    for (Todo todo in todos) {
      print(todo);
    }
  }

Future <void> _showmanual(BuildContext context) async {
    var event = await Navigator.pushNamed(context, '/manual');
     t = event;

    if(t.name != null && t.dateTime != null && t.location != null)
    {
         _addTodo();
    }

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
              child: new Text("Manual"),
              onPressed: () {
                _showmanual(context);
              },
            ),
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
            ),
            
          ],
        );
      },
    );
  }

  CollectionReference dbReplies = Firestore.instance.collection('replies');
  
  Future <int> insertFirestoreItem(Todo todo)async{
    CollectionReference events = Firestore.instance.collection('Calendar Events');
    var newDocument = await events.add(todo.toMap());
    print(newDocument);
    /*
    Firestore.instance.runTransaction((Transaction tx) async {
    var _result = await dbReplies.add(todo.toMap());
    print(_result);
    });
    */
  }

  Future <void> deleteFirestoreItem(int id) async{
    CollectionReference events = Firestore.instance.collection('Calendar Events');
    await events.document(id.toString()).delete();
    print("ID has been deleted");
  }
}
