import 'package:flutter/material.dart';
import 'package:flutter_sq/db/db.dart';

class TodosComponent extends StatelessWidget {
  final dynamic data;
  final Function() fetchData;
  const TodosComponent(
      {required this.data, required this.fetchData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      color: data['completed'] == 1
          ? const Color.fromARGB(46, 93, 89, 89)
          : const Color(0xFF0D1017),
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Text(
              data['value'],
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: data['completed'] == 1 ? Colors.grey : Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              final db = await DbService().completedTodo(data['id'], 1);
              if (db == 'ok') {
                fetchData();
              }
            },
            icon: Icon(
              Icons.done,
              color: data['completed'] == 1 ? Colors.green : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () async {
              final db = await DbService().deleteTodo(data['id']);
              if (db == 'ok') {
                fetchData();
              }
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
