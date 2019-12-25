import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';

int bottomnavigationbarindex = 0;
DateTime LMP, DOC, EDD, ET1, ET2, GTD = DateTime.now();
String POG = "";

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsPageStateful();
  }
}

class SettingsPageStateful extends StatefulWidget {
  @override
  _SettingsPageStatefulState createState() => _SettingsPageStatefulState();
}

class _SettingsPageStatefulState extends State<SettingsPageStateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () {
              // Navigate back to first route when tapped.
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Still on the Development'),
                  FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          child: new AlertDialog(
                            title: new Text("Privacy Policy"),
                            content: new Text(
                                "This app does not collect any information nor transmit any data to any place.\nThats all.\n GNU General Public License v3.0\nRead More: https://github.com/pc-dissanayake/GYN-OBS/blob/master/LICENSE"),
                          ));
                    },
                    child: Text('Privacy Policy'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class PregnancyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PregnancyCalculatorpage();
  }
}

class PregnancyCalculatorpage extends StatefulWidget {
  @override
  _PregnancyCalculatorpageState createState() =>
      _PregnancyCalculatorpageState();
}

class _PregnancyCalculatorpageState extends State<PregnancyCalculatorpage> {
  @override
  Widget build(BuildContext context) {
    Function ChangedDates() {
      DOC = Jiffy(LMP, "yyyy-MM-dd").add(days: 14);
      EDD = Jiffy(LMP, "yyyy-MM-dd").add(days: 280);
      ET1 = Jiffy(LMP, "yyyy-MM-dd").add(days: 84);
      ET2 = Jiffy(LMP, "yyyy-MM-dd").add(days: 280);
      var pogint = GTD.difference(LMP).inDays;
      POG = (pogint / 7).toInt().toString() +
          " Weeks  " +
          (pogint % 7).toString() +
          " Days";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Pregnancy Calculator"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Text(
                  "Last\nMenstrual\nPeriod",
                  style: TextStyle(fontSize: 14),
                ),
                title: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(1962, 9, 11),
                      maxTime: DateTime(2100, 6, 7),
                      onChanged: (date) {
                        setState(() {
                          LMP = date;
                          ChangedDates();
                        });
                      },
                      onConfirm: (date) {
                        setState(() {
                          LMP = date;
                          ChangedDates();
                        });
                      },
                      currentTime: LMP,
                    );
                  },
                  child: Text(
                    Jiffy(LMP).yMMMMd,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text(
                  "Date\nOf\nConception",
                  style: TextStyle(fontSize: 14),
                ),
                title: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(1962, 9, 11),
                      maxTime: DateTime(2100, 6, 7),
                      onChanged: (date) {
                        setState(() {
                          LMP = Jiffy(LMP, "yyyy-MM-dd").subtract(days: 14);
                          ChangedDates();
                        });
                      },
                      onConfirm: (date) {
                        setState(() {
                          LMP = Jiffy(LMP, "yyyy-MM-dd").subtract(days: 14);
                          ChangedDates();
                        });
                      },
                      currentTime: DOC,
                    );
                  },
                  child: Text(
                    Jiffy(DOC).yMMMMd,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text(
                  "Estimated\nDelivery\nDate",
                  style: TextStyle(fontSize: 14),
                ),
                title: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(1962, 9, 11),
                      maxTime: DateTime(2100, 6, 7),
                      onChanged: (date) {
                        setState(() {
                          LMP = Jiffy(LMP, "yyyy-MM-dd").subtract(days: 280);
                          ChangedDates();
                        });
                      },
                      onConfirm: (date) {
                        setState(() {
                          LMP = Jiffy(LMP, "yyyy-MM-dd").subtract(days: 280);
                          ChangedDates();
                        });
                      },
                      currentTime: EDD,
                    );
                  },
                  child: Text(
                    Jiffy(EDD).yMMMMd,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text(
                  "End Of\nTrimester\n1",
                  style: TextStyle(fontSize: 14),
                ),
                title: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(1962, 9, 11),
                      maxTime: DateTime(2100, 6, 7),
                      onChanged: (date) {
                        setState(() {
                          LMP = Jiffy(LMP, "yyyy-MM-dd").subtract(days: 84);
                          ChangedDates();
                        });
                      },
                      onConfirm: (date) {
                        setState(() {
                          LMP = Jiffy(LMP, "yyyy-MM-dd").subtract(days: 84);
                          ChangedDates();
                        });
                      },
                      currentTime: ET1,
                    );
                  },
                  child: Text(
                    Jiffy(ET1).yMMMMd,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text(
                  "End Of\nTrimester\n2",
                  style: TextStyle(fontSize: 14),
                ),
                title: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(1962, 9, 11),
                      maxTime: DateTime(2100, 6, 7),
                      onChanged: (date) {
                        setState(() {
                          LMP = Jiffy(LMP, "yyyy-MM-dd").subtract(days: 280);
                          ChangedDates();
                        });
                      },
                      onConfirm: (date) {
                        setState(() {
                          LMP = Jiffy(LMP, "yyyy-MM-dd").subtract(days: 280);
                          ChangedDates();
                        });
                      },
                      currentTime: ET2,
                    );
                  },
                  child: Text(
                    Jiffy(ET2).yMMMMd,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text(
                  "Go\nto a\nDay",
                  style: TextStyle(fontSize: 14),
                ),
                title: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(1962, 9, 11),
                      maxTime: DateTime(2100, 6, 7),
                      onChanged: (date) {
                        setState(() {
                          GTD = date;
                          ChangedDates();
                        });
                      },
                      onConfirm: (date) {
                        setState(() {
                          GTD = date;
                          ChangedDates();
                        });
                      },
                      currentTime: GTD,
                    );
                  },
                  child: Text(
                    Jiffy(GTD).yMMMMd,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text(
                  "Period\nof\nGestation",
                  style: TextStyle(fontSize: 14),
                ),
                title: FlatButton(
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      minTime: DateTime(1962, 9, 11),
                      maxTime: DateTime(2100, 6, 7),
                      onChanged: (date) {},
                      onConfirm: (date) {},
                      currentTime: ET2,
                    );
                  },
                  child: Text(
                    POG,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ButtonBar(
                children: <Widget>[
                  IconButton(
                    tooltip: "Add New Patient currently on Development",
                    onPressed: () {},
                    icon: Icon(FontAwesomeIcons.plus),
                  ),
                  IconButton(
                    onPressed: () {
                      // modalToShowInfo();
                    },
                    icon: Icon(FontAwesomeIcons.info),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PatientListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient List"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Still on development folks",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
