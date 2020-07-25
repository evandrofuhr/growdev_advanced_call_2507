import 'package:flutter/material.dart';

class Todo {
  int id;
  String description;
  bool done;
  int userId;

  Todo({
    this.id,
    @required this.description,
    this.done,
    this.userId,
  });

  Todo.fromMap(Map<String, dynamic> obj) {
    id = obj['id'];
    description = obj['description'];
    done = obj['done'] == 'T';
    userId = obj['userId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'done': done ?? false ? 'T' : 'F',
      'userid': userId,
    };
  }
}
