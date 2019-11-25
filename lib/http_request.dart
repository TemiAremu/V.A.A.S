import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'model/todo.dart';
import 'dart:convert';

class httpRequestPage extends StatefulWidget {
  httpRequestPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _httpRequestPageState createState() => _httpRequestPageState();
}

class _httpRequestPageState extends State<httpRequestPage> {
  List<Todo> _todos;

  @override 
  void initState() {
    super.initState();

    _loadTodos();
  }
  
  Future<void> _loadTodos() async {
    var response = await http.get('http://127.0.0.1:8000/data.json');

    if (response.statusCode == 200) {
      setState(() {
        _todos = [];

        List data = jsonDecode(response.body);
        for (var item in data) {
          _todos.add(Todo.fromMap(item));
        }
      });
    }
  }
  
  bool isEmpty = true;
  int _selectedIndex = 0;
  var _lastInsertedId = 1;
  bool isSelected;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Delete the 'to do'
              List<Todo> newTodos = [];
              setState(() {
                _todos = newTodos;
              });
            }
          ),
        ],
      ),
      body: 
      Container(
        
       child: new ListView.builder
        (
          itemCount: isEmpty ? 0 : _todos.length,
          itemBuilder: (BuildContext ctxt, int index) 
          {         
            return new Card
            ( 
              child: Container(
                child: GestureDetector(
                  child:  _createTodoList(_todos[index]),
                  onTap: () => setState((){ _selectedIndex = index; isSelected = true;})
                )
              )
            );
          }
        ),
      ),
      
    );
  }

  Widget _createTodoList(Todo passedindex) {
    return ListView.builder(
      itemCount: _todos != null ? _todos.length : 0,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(passedindex.name + "    " + passedindex.dateTime),
          subtitle: Text(passedindex.location),
        );
      }
    );
  }
}


