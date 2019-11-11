class Todo {
  Todo({this.id, this.name,this.time,this.date,this.location});

  int id;
  String name;
  String time;
  String date;
  String location;

  Todo.fromMap(Map<String,dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.time = map['time'];
    this.date = map['grade'];
    this.location = map['location'];
  }

  Map<String,dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'time': this.time,
      'grade': this.date,
      'location': this.location
    };
  }

  @override 
  String toString() {
    return 'Todo{id: $id, name: $name, time: $time, date: $date, location: $location}';
  }
}