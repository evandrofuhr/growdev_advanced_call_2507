import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  String email;

  User.empty();

  User({
    @required this.id,
    @required this.name,
    @required this.email,
  });

  User.fromMap(Map<String, dynamic> obj) {
    id = obj['id'];
    name = obj['nome'];
    email = obj['email'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'email': email,
    };
  }
}
