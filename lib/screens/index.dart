import 'package:flutter/material.dart';
import 'package:flutter_sq/components/todos.dart';
import 'package:flutter_sq/db/db.dart';
import 'package:flutter_sq/screens/add.dart';

class IndexComponent extends StatefulWidget {
  const IndexComponent({super.key});
  static const routeName = '/';

  @override
  State<IndexComponent> createState() => _IndexComponentState();
}

class _IndexComponentState extends State<IndexComponent> {
  List<dynamic> datas = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final data = await DbService().getTodos();
    setState(() {
      datas = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF161b21),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161b21),
        foregroundColor: Colors.white,
        title: const Text("Todos"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 80),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: datas
                  .map(
                    (data) => TodosComponent(
                      data: data,
                      fetchData: fetchData,
                    ),
                  )
                  .toList()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.pushNamed(context, AddTodosComponent.routeName,
              arguments: {fetchData: fetchData});
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
