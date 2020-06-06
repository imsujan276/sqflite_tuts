import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_tuts/generated/l10n.dart';
import 'package:sqflite_tuts/models/todo.dart';

import '../database_helper.dart';
import 'todo_form_screen.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List _todos = [];
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final _data = await _databaseHelper.fetchTodos();
    setState(() {
      _todos = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) {
                return TodoForm(databaseHelper: _databaseHelper);
              },
            ),
          ).then((value) async {
            await _fetchTodos();
          });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchTodos,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${S.of(context).todo}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.translate),
                      onPressed: () async {
                        final _loc = Intl.getCurrentLocale();

                        if (_loc == 'ne') {
                          await S.load(Locale('en'));
                        } else {
                          await S.load(Locale('ne'));
                        }
                        setState(() {});
                      },
                    ),
                    PopupMenuButton(
                      onSelected: (val) async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: Text('${S.of(context).areyouSureMsg}'),
                              content: Text('${S.of(context).removeAllMsg}'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('${S.of(context).noLabel}'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                FlatButton(
                                    child: Text('${S.of(context).yesLabel}'),
                                    onPressed: () async {
                                      await _databaseHelper.clear();
                                      await _fetchTodos();
                                      Navigator.pop(context);
                                    }),
                              ],
                            );
                          },
                        );
                      },
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Text('${S.of(context).clearAllLabel}'),
                            value: 1,
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ),
              Flexible(
                child: _todos.length > 0
                    ? Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, i) => Divider(),
                          itemCount: _todos.length,
                          itemBuilder: (context, i) {
                            final Todo _todo = _todos[i];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _todo.status == 1
                                    ? Colors.green
                                    : Colors.grey[200],
                                child: Icon(
                                  _todo.status == 1
                                      ? Icons.done
                                      : Icons.hourglass_empty,
                                  color: _todo.status == 1
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                '${_todo.desc}',
                                maxLines: 1,
                              ),
                              title: Text(
                                '${_todo.title}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) {
                                      return TodoForm(
                                          todo: _todo,
                                          databaseHelper: _databaseHelper);
                                    },
                                  ),
                                ).then((value) async {
                                  await _fetchTodos();
                                });
                              },
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Text('${S.of(context).emptyTodoMsg}'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
