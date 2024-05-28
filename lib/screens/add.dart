import 'package:flutter/material.dart';
import 'package:flutter_sq/db/db.dart';
import 'package:flutter_sq/screens/index.dart';

class AddTodosComponent extends StatefulWidget {
  final Function() fetchData;
  const AddTodosComponent({required this.fetchData, super.key});
  static const routeName = "/add";

  @override
  State<AddTodosComponent> createState() => _AddTodosComponentState();
}

class _AddTodosComponentState extends State<AddTodosComponent> {
  final TextEditingController _controller = TextEditingController();
  String value = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161b21),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161b21),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Add new todo"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Input here...",
                    focusColor: Colors.black,
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    final db = await DbService().addTodo(_controller.text);
                    if (db == 'ok') {
                      setState(() {
                        Navigator.popUntil(context,
                            ModalRoute.withName(IndexComponent.routeName));
                        widget.fetchData();
                      });
                    }
                  },
                  child: const Text(
                    "SAVE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
