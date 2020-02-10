import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/model/model.dart';
import 'package:todo_app/widgets/widgets.dart';

class UncompletedTodoContainer extends StatelessWidget {
  final List<Todo> todos;
  final bool loading;
  final Function onTodoDelete;
  final Function onTodoComplete;

  UncompletedTodoContainer({this.todos, this.loading, this.onTodoDelete, this.onTodoComplete});

  showSnack(context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  completeTodo(Todo todo) {
    todo.completed = true;
    todo.save();
  }

  @override
  Widget build(BuildContext context) {
    print(todos);
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, int index) {
        return Dismissible(
          key: Key(todos[index].id.toString()),
          child: UncompletedTodoWidget(todo: todos[index]),
          secondaryBackground: Container(
            padding: EdgeInsets.all(8),
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          background: Container(
            padding: EdgeInsets.all(8),
            color: Colors.green,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                )),
          ),
          onDismissed: (DismissDirection direction) {
            print(direction);
            if (direction == DismissDirection.startToEnd) {
              showSnack(context, 'Todo completed!');
              onTodoComplete(todos[index]);
            } else {
              showSnack(context, 'Todo deleted!');
              onTodoDelete(todos[index]);
            }
          },
        );
      },
    );
  }
}
