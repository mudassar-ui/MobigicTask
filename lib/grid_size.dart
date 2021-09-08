import 'package:flutter/material.dart';
import 'package:mobigic_task/grid_text.dart';

class GridSize extends StatefulWidget {
  @override
  _GridSizeState createState() => _GridSizeState();
}

class _GridSizeState extends State<GridSize> {
  TextEditingController row = TextEditingController();
  TextEditingController column = TextEditingController();
  final _form = GlobalKey<FormState>();

  int rowC = 0;
  int colC = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Size'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
            child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter Rows'),
                controller: row,
                keyboardType: TextInputType.number,
                validator: (row) {
                  if (row!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  if (int.parse(row) > 6) {
                    return 'value should be 6 or less than 6';
                  }
                  if (int.parse(row) == 0) {
                    return 'value can not be zero';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter Columns'),
                controller: column,
                keyboardType: TextInputType.number,
                validator: (column) {
                  if (column!.isEmpty) {
                    return 'Please provide a value.';
                  }
                  if (int.parse(column) > 4) {
                    return 'value should be 4 or less than 4';
                  }
                  if (int.parse(column) == 0) {
                    return 'value can not be zero';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  final isValid = _form.currentState!.validate();
                  if (!isValid) {
                    return;
                  }
                  rowC = int.parse(row.text);
                  colC = int.parse(column.text);

                  setState(() {});
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => GridText(
                              row: rowC,
                              col: colC,
                            )),
                  );
                },
                padding: EdgeInsets.all(20),
                color: Colors.blue,
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
