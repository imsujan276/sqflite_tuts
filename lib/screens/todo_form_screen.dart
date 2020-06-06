import 'package:flutter/material.dart';
import 'package:sqflite_tuts/models/todo.dart';

import '../database_helper.dart';

class TodoForm extends StatefulWidget {
  final DatabaseHelper databaseHelper;
  final Todo todo;

  TodoForm({
    this.databaseHelper,
    this.todo,
  });
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _desc;
  bool _status = false;

  _changeStatus(bool val) => setState(() => _status = val);

  _validateAndSave() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final _todo = Todo(
        id: widget.todo?.id,
        title: _title,
        desc: _desc,
        status: _status == true ? 1 : 0,
      );

      try {
        if (widget.todo == null) {
          await widget.databaseHelper.addTodo(_todo);
        } else {
          await widget.databaseHelper.editTodo(_todo);
        }
        Navigator.pop(context, true);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    _status = widget.todo?.status == 1 ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: IconButton(
                            color: Colors.black,
                            icon: Icon(Icons.clear),
                            onPressed: () => Navigator.pop(context, true),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          widget.todo == null ? 'Create Todo' : 'Edit Todo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        Spacer(),
                        if (widget.todo != null)
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: IconButton(
                              color: Colors.black,
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      title: Text('Are you sure?'),
                                      content: Text(
                                          'The data will be remved from the app'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('No'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        FlatButton(
                                            child: Text('Ok'),
                                            onPressed: () async {
                                              await widget.databaseHelper
                                                  .deleteTodo(widget.todo.id);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.todo?.title,
                    onSaved: (val) => _title = val,
                    validator: (val) =>
                        val.isEmpty ? 'Todo title is required' : null,
                    decoration: InputDecoration(
                      labelText: 'Todo Title',
                    ),
                  ),
                  TextFormField(
                    initialValue: widget.todo?.desc,
                    onSaved: (val) => _desc = val,
                    validator: (val) =>
                        val.isEmpty ? 'Todo description is required' : null,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Todo Description',
                    ),
                  ),
                  SwitchListTile(
                    title: Text('Status'),
                    value: _status,
                    onChanged: _changeStatus,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    child: RaisedButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(34),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: _validateAndSave,
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
