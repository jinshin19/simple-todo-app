import 'package:flutter/material.dart';
import 'package:flutter_sq/screens/add.dart';
import 'package:flutter_sq/screens/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void test() {
    print("Test");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
          ),
          useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: IndexComponent.routeName,
      routes: {
        IndexComponent.routeName: (context) => const SafeArea(
              child: IndexComponent(),
            ),
        AddTodosComponent.routeName: (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<Function, dynamic>;
          final dynamic fetchData = args.keys.first;
          return AddTodosComponent(fetchData: fetchData);
        },
      },
    );
  }
}
