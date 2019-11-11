import 'package:flutter/material.dart';

class Scheduling {
  String name;
  String location;
  DateTime dateTime;

  Scheduling({this.name, this.location, this.dateTime});

  String toString() { return '$name $location ($dateTime)'; }
}

class SchedulingPage extends StatefulWidget {
  SchedulingPage({Key key, this.title}): super(key: key);

  final String title;

  @override 
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  DateTime _eventDate = DateTime.now();
  String _eventName = '';
  String _eventLocation = '';

  @override 
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Name: ",
              ),
              onChanged: (String newValue) {
                setState(() {
                  _eventName = newValue;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: "Location: ",
              ),
              onChanged: (String newValue) {
                setState(() {
                  _eventLocation = newValue;
                });
              },
            ),
            

           Container(
              padding: EdgeInsets.all(20.0),
                  child: Text('Select Date and Time'),
                
                ), 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RaisedButton(
                  child: Text('Select'),
                  color: Colors.deepOrange,
                  textColor: Colors.white,
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: now,
                      lastDate: DateTime(2100),
                      initialDate: now,
                    ).then((value) {
                      setState(() {
                        _eventDate = DateTime(
                          value.year,
                          value.month,
                          value.day,
                          _eventDate.hour,
                          _eventDate.minute,
                          _eventDate.second,
                        );
                      });
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(_toDateString(_eventDate)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RaisedButton(
                  child: Text('Select'),
                  color: Colors.deepOrangeAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay( 
                        hour: now.hour,
                        minute: now.minute,
                      ),
                    ).then((value) {
                      setState(() {
                        _eventDate = DateTime(
                          _eventDate.year,
                          _eventDate.month,
                          _eventDate.day,
                          value.hour,
                          value.minute,
                        );
                      });
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(_toTimeString(_eventDate)),
                ),
              ],
            ),
            Center(
              child: RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  Navigator.of(context).pop(
                    Scheduling(name: _eventName, location: _eventLocation, dateTime: _eventDate, )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _twoDigits(int value) {
    if (value < 10) {
      return '0$value';
    } else {
      return '$value';
    }
  }

  String _toTimeString(DateTime dateTime) {
    return '${_twoDigits(dateTime.hour)}:${_twoDigits(dateTime.minute)}';
  }

  String _toDateString(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day}';
  }
}