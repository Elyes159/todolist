import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoList(),
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> _tasks = [];

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Ajouter une tâche'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(hintText: 'Entrez la nouvelle tâche'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  if (newTask.isNotEmpty) {
                    _tasks.add(newTask);
                  }
                  Navigator.of(context).pop();
                });
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _completeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_tasks[index]),
            onDismissed: (direction) {
              _completeTask(index);
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0),
            ),
            child: ListTile(
              title: Text(_tasks[index]),
              onTap: () {
                _completeTask(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Ajouter une tâche',
        child: Icon(Icons.add),
      ),
    );
  }
}
