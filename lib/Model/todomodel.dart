class Todo {
  int? taskId;
  String title;
  String desc;
  String date;
  bool flag = false;
  Todo(
      {this.taskId,
      required this.title,
      required this.desc,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'date': date,
    };
  }
}
