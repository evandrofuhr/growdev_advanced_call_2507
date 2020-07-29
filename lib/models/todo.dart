import 'package:call_2507/models/user.dart';
import 'package:flutter/material.dart';

class Todo {
  int id;
  String description;
  bool done;
  int userId;
  String date;
  User user;

  Todo.empty();

  Todo({
    this.id,
    @required this.description,
    this.done,
    this.userId,
    this.date,
  });

  Todo.fromMap(Map<String, dynamic> obj) {
    id = obj['id'];
    description = obj['description'];
    done = obj['done'] == 'T';
    userId = obj['userId'];
    date = obj['date'];
    if (obj.containsKey('username')) {
      user = User.empty()..name = obj['username'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'done': done ?? false ? 'T' : 'F',
      'userid': userId,
      'date': date,
    };
  }
}
