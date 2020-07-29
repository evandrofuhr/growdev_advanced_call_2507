import 'package:call_2507/models/todo.dart';
import 'package:call_2507/models/user.dart';
import 'package:call_2507/repositories/todo_repository.dart';
import 'package:call_2507/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TodoRepository _todoRepository;
  UserRepository _userRepository;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _descriptionController = TextEditingController();
  Todo _todo;

  @override
  void initState() {
    super.initState();
    _todo = Todo.empty();
    _todoRepository = TodoRepository();
    _userRepository = UserRepository();
  }

  Future<void> addNewTodo() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await _todoRepository.newTodo(
        _todo,
      );
      _formKey.currentState.reset();
      _descriptionController.clear();
      setState(() {
        _todo = Todo.empty();
      });
    }
  }

  List<DropdownMenuItem> _getDropdownItens(List<User> users) {
    return users
        .map(
          (user) => DropdownMenuItem(
            child: Text('${user.name}'),
            value: user.id,
          ),
        )
        .toList()
          ..add(
            DropdownMenuItem(
              child: Text('todos'),
              value: 0,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Call 25/07'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FutureBuilder<List<User>>(
                    initialData: <User>[],
                    future: _userRepository.getUsers(),
                    builder: (context, snapshot) {
                      final users = snapshot.data;
                      return DropdownButtonFormField<int>(
                        value: _todo.userId ?? 0,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'usuário',
                        ),
                        items: _getDropdownItens(users),
                        onChanged: (value) =>
                            setState(() => _todo.userId = value),
                        validator: (value) =>
                            value <= 0 ? 'Selecione um usuário' : null,
                        onSaved: (newValue) => _todo.userId = newValue,
                      );
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'descrição',
                    ),
                    controller: _descriptionController,
                    validator: (value) =>
                        value.isEmpty ? 'Descrição obrigatória' : null,
                    onSaved: (newValue) => _todo.description = newValue,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  OutlineButton(
                    onPressed: addNewTodo,
                    child: Text('Adicionar'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Todo>>(
                initialData: <Todo>[],
                future: _todoRepository.getTodos(userId: _todo.userId ?? 0),
                builder: (context, snapshot) {
                  final _todos = snapshot.data;
                  return ListView.builder(
                    itemCount: _todos.length,
                    itemBuilder: (context, index) {
                      final _item = _todos[index];
                      return ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          _item?.user?.name != null
                              ? _item.user.name
                              : 'Sem usuário',
                        ),
                        subtitle: Text(_item?.description ?? ''),
                        isThreeLine: true,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
