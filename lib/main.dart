import 'package:call_2507/dbhelper.dart';
import 'package:call_2507/todo.dart';
import 'package:call_2507/todo_repository.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoRepository _todoRepository;

  @override
  void initState() {
    super.initState();
    _todoRepository = TodoRepository();
  }

  Future<void> addNewTodo() async {
    await _todoRepository.newTodo(
      Todo(description: 'Lavar o carro'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call 25/07'),
      ),
      body: Center(
        child: RaisedButton.icon(
          onPressed: addNewTodo,
          icon: Icon(
            Icons.add,
          ),
          label: Text('Add Todo'),
        ),
      ),
    );
  }
}
