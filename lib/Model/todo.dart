class Todo {
  int? id;
  String? title;
  String? task;
  String? category;
  String? description;
  String? date;
  String? time;
  Todo(
      {this.id,
      this.title,
      this.task,
      this.category,
      this.date,
      this.time ,this.description});

  Todo.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        task = res["task"],
        category = res["category"],
        date = res["date"],
        description = res["description"],
        time = res["time"];


  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'task': task,
      'category': category,
      'date': date,
      'time': time,
      'description': description
    };
  }
}
    