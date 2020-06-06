class Todo {
  final int id;
  final String title;
  final String desc;
  final int status;

  Todo({this.id, this.title, this.desc, this.status});

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      desc: map['desc'],
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'status': status,
    };
  }
}
