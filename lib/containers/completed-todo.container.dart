import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/model/model.dart';
import 'package:todo_app/widgets/widgets.dart';

class CompletedTodoContainer extends StatelessWidget {
  final List<Todo> todos;
  final bool loading;
  final Function onTodoDelete;
  final Function onUncompleteTodo;

  CompletedTodoContainer({this.todos, this.loading, this.onTodoDelete, this.onUncompleteTodo});


  showSnack(context, String text) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }


  @override
  Widget build(BuildContext context) {



    print(todos);
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, int index) {
        return Dismissible(
          key: Key(todos[index].id.toString()),
          child: CompletedTodoWidget(todo: todos[index]),
          background: Container(
            padding: EdgeInsets.all(8),
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          secondaryBackground: Container(
            padding: EdgeInsets.all(8),
            color: Colors.yellow,
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Uncomplete',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                )),
          ),
          onDismissed: (DismissDirection direction) {

            print(direction);
            if (direction == DismissDirection.startToEnd) {
              showSnack(context, 'Todo removed!');
              onTodoDelete(todos[index]);
            } else {
              showSnack(context, 'Todo uncompleted!');
              onUncompleteTodo(todos[index]);
            }
          },
        );
      },
    );
  }
}
