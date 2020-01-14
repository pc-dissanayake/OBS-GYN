import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'PatientDetails.dart';
import 'database_patients.dart';
import 'pages.dart';

var formatter = new DateFormat('yyyy-MM-dd');
DateTime toDAyNow = DateTime.now();

class PatientListPage extends StatefulWidget {
  @override
  _PatientListPageState createState() => _PatientListPageState();
}

class _PatientListPageState extends State<PatientListPage> {
  final dbHelper = DatabaseHelper();
  List<PatientDetails> items = new List();

  int count = 2;
  void initState() {
    super.initState();

    dbHelper.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(PatientDetails.fromMap(note));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient List'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, position) {
                      return Card(
                        color: Colors.white,
                        elevation: 2.0,
                        child: ListTile(
                            onTap: () {
                              //debugPrint('${items[position].toString()}');
                              //nav1('Edit');
                            },
                            leading: CircleAvatar(
                              backgroundColor:
                                  (1 == 1) ? Colors.green : Colors.red,
                              child: Icon(Icons.keyboard_arrow_right),
                            ),
                            title: Text('LMP: ${items[position].LMP}'),
                            subtitle: Text(""),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteNote(
                                        context, items[position], position);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.play_arrow),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PregnancyCalculatorpage(
                                                  gettingDate: DateTime.parse(
                                                      '${items[position].LMP}'))),
                                    );
                                  },
                                ),
                              ],
                            )),
                      );
                    }),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.calculator),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PregnancyCalculatorpage()),
          );
        },
      ),
    );
  }

//all functions

  void _deleteNote(
      BuildContext context, PatientDetails note, int position) async {
    dbHelper.deleteNote(note.patient_id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _insert() async {
    setState(() {
      dbHelper.saveNote(PatientDetails("sfsdagd", "sadgsdghsdf"));
    });
    // row to insert
//    Map<String, dynamic> row = {
//      DatabaseHelper.LMP: 'Bob',
//      DatabaseHelper.columnNotes: 23
//    };
//    final id = await dbHelper.saveNote(row);
//    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.getAllNotes();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }
}
