import 'package:flutter/material.dart';
import 'package:mobigic_task/grid_size.dart';

class GridScreen extends StatefulWidget {
  final int rowC;
  final int colC;
  final String characters;

  GridScreen(
      {required this.rowC, required this.colC, required this.characters});
  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  TextEditingController searchText = TextEditingController();
  final _form = GlobalKey<FormState>();

  List<int>? alphabetPositions;

  void matchText() {
    List<int> charactersNum = [];
    String? searchKey = searchText.text.toLowerCase();

    //find alphabet positions
    for (var i = 0; i < searchKey.length; i++) {
      if (widget.characters.contains(searchKey[i])) {
        charactersNum.add(widget.characters.indexOf(searchKey[i]) + 1);
      }
    }
    var reversedNumList = charactersNum;
    //Reverse alphabet positions
    if (charactersNum[charactersNum.length - 1] > charactersNum[0])
      reversedNumList = charactersNum.reversed.toList();

    //Find match type Left-Right:1, Top-bottom:no of Coulumn, Diagonal: no of Column - 1
    List<int> diff = []; //[1,1,1]

    for (var i = 0; i < reversedNumList.length; i++) {
      if (i != reversedNumList.length - 1)
        diff.add(reversedNumList[i] - reversedNumList[i + 1]);
    }
    int countLR = 0;
    int countTB = 0;
    int countD = 0;

    for (var i = 0; i < diff.length; i++) {
      if (diff[i] == 1) countLR++;
      if (diff[i] == widget.colC) countTB++;
      if (diff[i] == widget.colC - 1) countD++;
    }

    if (countLR == searchKey.length - 1 ||
        countTB == searchKey.length - 1 ||
        countD == searchKey.length - 1 && charactersNum.length > 1) {
      setState(() {
        alphabetPositions = charactersNum;
      });
    } else {
      setState(() {
        alphabetPositions = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Grid'),
      actions: <Widget>[
        FlatButton(
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => GridSize()));
          },
          child: Text(
            "Reset",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.35,
                child: GridView.builder(
                  //itemCount: widget.colC * widget.rowC,
                  itemCount: widget.characters.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.colC,
                      childAspectRatio: widget.colC * widget.rowC / widget.rowC,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                      child: Center(
                        child: Text(
                          widget.characters[index].toUpperCase(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: alphabetPositions != null &&
                              alphabetPositions!.contains(index + 1)
                          ? Colors.red
                          : Colors.greenAccent),
                ),
              ),
              Form(
                key: _form,
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Search Alphabets'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                  controller: searchText,
                  maxLength: widget.rowC * widget.colC,
                  validator: (searchText) {
                    if (searchText!.isEmpty) {
                      return 'Please provide search alphabets.';
                    }

                    return null;
                  },
                ),
              ),
              RaisedButton(
                onPressed: () {
                  final isValid = _form.currentState!.validate();

                  if (!isValid) {
                    return;
                  }
                  matchText();
                },
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Text(
                  "Match Alphabets",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
