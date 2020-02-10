import 'package:flutter/material.dart';
import 'containers/container.dart';
import 'package:todo_app/model/model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController tabController;
  List<Todo> completedTodos = [];
  bool completedLoading = true;

  List<Todo> unCompletedTodos = [];
  bool unCompletedLoading = true;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
    getAllCompletedTodos();
    getAllUncompletedTodos();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  getAllCompletedTodos() async {
    var result = await Todo().select().completed.equals(true).toList();
    setState(() {
      completedTodos = result == null ? [] : result;
      completedLoading = false;
    });
  }

  getAllUncompletedTodos() async {
    var result = await Todo().select().completed.equals(false).toList();
    setState(() {
      unCompletedTodos = result == null ? [] : result;
      unCompletedLoading = false;
    });
  }

  createTodo() async {
    var res = await createTodoDialog();
    if (res == null) {
      return;
    }

    await Todo(completed: false, text: res).save();
    getAllUncompletedTodos();
  }

  completeTodo(Todo todo) {
    todo.completed = true;
    todo.save();
    getAllUncompletedTodos();
    getAllCompletedTodos();
  }

  uncompletedTodo(Todo todo) {
    todo.completed = false;
    todo.save();
    getAllUncompletedTodos();
    getAllCompletedTodos();
  }

  deleteTodo(Todo todo) {
    todo.delete();
    getAllUncompletedTodos();
    getAllCompletedTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        bottom: TabBar(
            controller: tabController, tabs: [Text('Open'), Text('Done')]),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          unCompletedTodos.length > 0
              ? UncompletedTodoContainer(
                  todos: unCompletedTodos,
                  loading: unCompletedLoading,
                  onTodoComplete: completeTodo,
                  onTodoDelete: deleteTodo,
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Nothing to do...',
                  ),
                ),
          completedTodos.length > 0
              ? CompletedTodoContainer(
                  todos: completedTodos,
                  loading: completedLoading,
                  onTodoDelete: deleteTodo,
                  onUncompleteTodo: uncompletedTodo)
              : Align(
                  alignment: Alignment.center, child: Text('Nothing done...')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTodo,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<String> createTodoDialog() {
    TextEditingController createTodoController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create Todo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  controller: createTodoController,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(null);
                },
              ),
              RaisedButton(
                  child: Text('Create'),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pop(createTodoController.text.toString());
                  }),
            ],
          );
        });
  }
}
