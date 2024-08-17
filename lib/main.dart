import 'package:flutter/material.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/health_connect.dart';
import 'package:wellwave_frontend/features/home/presentation/screen/to_do_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to HealthConnect screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HealthConnect()),
                );
              },
              child: Text('Go to HealthConnect'),
            ),
            SizedBox(height: 20),  // Add some space between the buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to ToDoList screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToDoList()),
                );
              },
              child: Text('Go to ToDo List'),
            ),
          ],
        ),
      ),
    );
  }
}