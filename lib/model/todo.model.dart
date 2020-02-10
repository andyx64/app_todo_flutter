import 'package:sqfentity_gen/sqfentity_gen.dart';

class Todo extends SearchCriteria {

  Todo({this.text, this.completed});

  String id;
  String text;
  bool completed;

}