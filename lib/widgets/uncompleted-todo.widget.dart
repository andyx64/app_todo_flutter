import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/model.dart';

class UncompletedTodoWidget extends StatelessWidget {

  final Todo todo;

  UncompletedTodoWidget({this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 24),
        child: Row(
        children: <Widget>[
            Icon(Icons.radio_button_unchecked,
                color: Theme.of(context).accentColor,
                size: 25
            ),
            SizedBox(width: 28),
            Text(todo.text != null ? todo.text : '', style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}
