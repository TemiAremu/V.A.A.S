import 'package:flutter/material.dart';
import 'chat.dart';
import 'voice.dart';
import 'welcome.dart';

import 'model/todo_model.dart';
import 'model/todo.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'model_firebase.dart';
import 'model/todoModelFirebase.dart';
import 'model/todoFirebase.dart';
import 'map.dart';

Todo t;

CollectionReference dbReplies = Firestore.instance.collection('replies');

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class SnackBar {

  String title;
  IconData icon;

  SnackBar({this.title, this.icon});
}

List<String> schedulelist = [
    "Test1", "Test2", "Test3", "Test4"
  ];

  List<Todo> slist = [
   //Todo(name:"1",location: "2",dateTime: "3")
  ];

  int listilelengthcheck = 1;

    final _model = TodoModel();
    final _firebaseModel = TodoModelFireBase();
    bool isSelected;

    bool isEmpty = true;

     bool toedit = false;

     int _selectedIndex = 0;
   

  var _todoItem1;
  var _todoItem2;
  var _todoItem3;

class _MyHomePageState extends State<MyHomePage> {

List<SnackBar> _pages = [
    SnackBar(title: 'Add', icon: Icons.add),
    SnackBar(title: 'Chat', icon: Icons.chat),
    //SnackBar(title: 'Translate', icon: Icons.g_translate),
  ];

  int _pageIndex = 0;

  var _lastInsertedId = 1;

  @override
  
  void initState()
  {
    super.initState();
    
    _updateTodo();
  }
  

  Widget build(BuildContext context) {
    //_updateTodo();
    return Scaffold(
      appBar: AppBar
      (
        title: Text("Schedule list"),
        actions: <Widget>
        [
          IconButton(
            icon: Icon(Icons.table_chart),
            onPressed: () 
            { 
              _showchart(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.g_translate),
            onPressed: ()
            {
              _translate(context);
            },  
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () 
            { 
              _updateTodo();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () 
            { 
              _edit();
                toedit = true;
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
          itemCount: slist.length != null ?  slist.length: 0 ,
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
      bottomNavigationBar: BottomNavigationBar(
       items: _pages.map((SnackBar page) {
         return BottomNavigationBarItem(
           icon: Icon(page.icon),
           title: Text(page.title),
         );
       }).toList(),
       onTap: (int index) {
         setState(() {
           if(index == 0)
           {
              _showDialog(context);
              
           }
           if(index == 1)
           {
              _showchat(context);
           }
          
           /*
           if(index == 3)
           {
             _translate(context);
           } 
           */
         });
       },     
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

Future <void> _showchart(BuildContext context) async {
    var event1 = await Navigator.pushNamed(context, '/chart');
  }

Future <void> _showchat(BuildContext context) async {
    var event1 = await Navigator.pushNamed(context, '/chat');
  }

Future <void> _showvoice(BuildContext context) async {
    var event = await Navigator.pushNamed(context, '/voice');
  }




Future <void> _translate(BuildContext context) async {
  var event2 = await Navigator.pushNamed(context, '/translate');
}


 Future<void> _edit() async {
       _showmanual(context);
    }

   Future<void> _editTodo() async {
    /*
    Todo todoToUpdate = Todo(
      id: _selectedIndex,
      //name: pages[_selectedIndex-1].sid,
      //grade: pages[_selectedIndex-1].grade
    );
    _model.updateTodo(todoToUpdate);
    */

    Todo todoToUpdate = Todo(
      id: _selectedIndex + 1,
      name: t.name,
      dateTime: t.dateTime,
      location: t.location
    );
    _model.updateTodo(todoToUpdate);

 
    toedit = false;
    _updateTodo();
  }

Future<void> _addTodo() async {
    print(t.name);
    print(t.dateTime);
    print(t.location);

    
    Todo newTodo = Todo(name: t.name, dateTime: t.dateTime, location: t.location);
    _lastInsertedId = await _model.insertTodo(newTodo);
    _firebaseModel.insertTodo(newTodo);

    //slist.add(Todo(name: newTodo.name, dateTime: newTodo.dateTime, location: newTodo.location));
    isEmpty = false;
    
    _updateTodo();
  
}

   Future<void> _updateTodo() async {
    //pages.clear();
    
    List<Todo> to = await _model.getAllTodos();

    print(to);

    setState(() => slist = to);

    
  }

  Future<void> _deleteTodo() async {
    _model.deleteTodo(_selectedIndex+1);
    slist.removeAt(_selectedIndex);
    isEmpty = true;
    _updateTodo();
    
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
        if(toedit)
      {
        _editTodo();
      }
      else{
         _addTodo();
      }
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

