import 'package:flutter/material.dart';
import 'package:mobigic_task/grid_view.dart';

class GridText extends StatefulWidget {
  final int row;
  final int col;
  GridText({required this.row, required this.col});

  @override
  _GridTextState createState() => _GridTextState();
}

class _GridTextState extends State<GridText> {
  TextEditingController characters = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid Alphabets'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
            child: Form(
          key: _form,
          child: ListView(
            children: [
              Text(
                'Please enter ${widget.row * widget.col} alphabets',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter alphabets'),
                style: TextStyle(fontWeight: FontWeight.bold),
                controller: characters,
                maxLength: widget.row * widget.col,
                validator: (characters) {
                  if (characters!.isEmpty) {
                    return 'Please provide value.';
                  }
                  if (characters.length != widget.row * widget.col) {
                    return 'Length should be ${widget.row * widget.col}';
                  }
                  var newChar = characters
                      .toLowerCase()
                      .split('')
                      .toSet(); //'somethingg' ---> ['s', 'o'.....,getc]

                  if (characters.length != newChar.length) {
                    //If duplicate characters appearing then return
                    return 'Do not Repeat alphabets';
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
                  // rowC = int.parse(row.text);
                  // colC = int.parse(column.text);

                  //setState(() {});
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => GridScreen(
                              rowC: widget.row,
                              colC: widget.col,
                              characters: characters.text,
                            )),
                  );
                },
                color: Colors.blue,
                padding: EdgeInsets.all(20),
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
