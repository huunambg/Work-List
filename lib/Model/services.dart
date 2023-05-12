import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/Model/todo.dart';

class Datahandler {
  Future<Database> initializeDBToDo() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'TodoHW.db'), onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE Todo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL,task TEXT NOT NULL,category TEXT NOT NULL,date TEXT NOT NULL,description TEXT NOT NULL,time TEXT NOT NULL)");
    }, version: 1);
  }

  Future<int> insertToDoList(List<Todo> Todo) async {
    int result = 0;
    final Database db = await initializeDBToDo();
    for (var todo in Todo) {
      result = await db.insert('Todo', todo.toMap());
    }
    return result;
  }

  Future<int> insertToDo(Todo Todo) async {
    int result = 0;
    final Database db = await initializeDBToDo();
    result = await db.insert('Todo', Todo.toMap());
    return result;
  }

  Future<List<Todo>> retrieveToDo() async {
    final Database db = await initializeDBToDo();
    final List<Map<String, Object?>> queryResult = await db.query("Todo");
    return queryResult.map((e) => Todo.fromMap(e)).toList();
  }

  Future<List<Todo>> retrieveToDoHomNay(String date) async {
    final Database db = await initializeDBToDo();
    final List<Map<String, Object?>> queryResult =
        await db.query("Todo", where: "date = '$date'");
    return queryResult.map((e) => Todo.fromMap(e)).toList();
  }

  Future<List<Map<String, dynamic>>> xToDo() async {
    final Database db = await initializeDBToDo();
    return db.query("Todo");
  }

  Future<void> updateToDo(Todo _ToDo) async {
    final Database db = await initializeDBToDo();
    await db
        .update("Todo", _ToDo.toMap(), where: "id = ?", whereArgs: [_ToDo.id]);
  }

  Future<void> deleteToDo(int id) async {
    final db = await initializeDBToDo();
    await db.delete(
      'Todo',
      where: "id = ?",
      whereArgs: [id],
    );
  }


}
