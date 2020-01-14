import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PatientDetails.dart';
import 'PatientList.dart';
import 'database_patients.dart';

int ussWeeks = 0;
int ussDays = 0;
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
                  Text('Settings are Still on the Development phase'),
                  FlatButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          child: AlertDialog(
                            title: Text(
                                "By using and installing this app user agrees  to the Privacy Policy and Terms and Conditions"),
                            content: Column(
                              children: <Widget>[
                                Text(
                                    "This app does not collect any information nor transmit any data to any place.\nThats all.\nReleased under GNU General Public License v3.0\nRead More: "),
                                FlatButton(
                                  onPressed: () {
                                    launchURL01(
                                        'https://github.com/pc-dissanayake/GYN-OBS/blob/master/LICENSE');
                                  },
                                  child: Text(
                                      'https://github.com/pc-dissanayake/GYN-OBS/blob/master/LICENSE'),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    launchURL01(
                                        'https://pcd.xyz.lk/privacy/obsgyn/privacy.html');
                                  },
                                  child:
                                      Text('Read all Terms and Regulations.'),
                                )
                              ],
                            ),
                          ));
                    },
                    child: Text(
                        'By using and installing this app user agrees to the Privacy Policy and Terms and Conditions'),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class PregnancyCalculatorpage extends StatefulWidget {
  DateTime gettingDate;

  PregnancyCalculatorpage({@required this.gettingDate}) {
    LMP = gettingDate;
  }
  @override
  _PregnancyCalculatorpageState createState() =>
      _PregnancyCalculatorpageState();
}

class _PregnancyCalculatorpageState extends State<PregnancyCalculatorpage> {
  final dbHelper = DatabaseHelper();
  var formatter = new DateFormat('yyyy-MM-dd');

  void _insert() async {
    dbHelper.saveNote(PatientDetails(formatter.format(LMP).toString(), ""));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PatientListPage()),
    );
  }

  Function ChangedDates() {
    DOC = Jiffy(LMP, "yyyy-MM-dd").add(days: 14);
    EDD = Jiffy(LMP, "yyyy-MM-dd").add(days: 280);
    ET1 = Jiffy(LMP, "yyyy-MM-dd").add(days: 84);
    ET2 = Jiffy(LMP, "yyyy-MM-dd").add(days: 182);
    var pogint = GTD.difference(LMP).inDays + 1;
    POG = (pogint / 7).toInt().toString() +
        " Weeks  " +
        (pogint % 7).toString() +
        " Days";
  }

  ussDateCalculate88() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return new CupertinoAlertDialog(
          title: new Text('Please select'),
          actions: <Widget>[
            new CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop('Cancel');
              },
              child: new Text('Cancel'),
            ),
            new CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(context).pop('Accept');
              },
              child: new Text('Accept'),
            ),
          ],
        );
      },
      barrierDismissible: false,
    );
  }

  void ussDateCalculatetoLMP() {
    setState(() {
      DateTime today = new DateTime.now();
      int alldaycount = ussWeeks * 7 + ussDays;
      LMP = today.subtract(new Duration(days: alldaycount));
      ChangedDates();
      //print(LMP);
    });
  }

  ussDateCalculate() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('USS Date :  $ussWeeks Weeks $ussDays Days'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text('Weeks'),
                        subtitle: Slider(
                          min: 0,
                          max: 40,
                          value: ussWeeks.toDouble(),
                          onChanged: (valchanged) {
                            setState(() {
                              ussWeeks = valchanged.toInt();
                              ussDateCalculatetoLMP();
                            });
                          },
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                          title: Text('Days'),
                          subtitle: Slider(
                            value: ussDays.toDouble(),
                            min: 0,
                            max: 7,
                            onChanged: (val) {
                              setState(() {
                                ussDays = val.toInt();
                                ussDateCalculatetoLMP();
                              });
                            },
                          )),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop('dialog');
                      },
                      child: Text('Close'),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

//14 280 84 182
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pregnancy Calculator"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        title: Text(
                          "Last Menstrual Period",
                        ),
                        subtitle: FlatButton(
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
                        title: Text(
                          "Date Of Conception",
                        ),
                        subtitle: FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              minTime: DateTime(1962, 9, 11),
                              maxTime: DateTime(2100, 6, 7),
                              onChanged: (date) {
                                setState(() {
                                  LMP = Jiffy(LMP, "yyyy-MM-dd")
                                      .subtract(days: 14);
                                  ChangedDates();
                                });
                              },
                              onConfirm: (date) {
                                setState(() {
                                  LMP = Jiffy(LMP, "yyyy-MM-dd")
                                      .subtract(days: 14);
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
                      color: Colors.grey[300],
                      child: ListTile(
                        title: Text(
                          "Estimated Delivery Date",
                        ),
                        subtitle: FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              minTime: DateTime(1962, 9, 11),
                              maxTime: DateTime(2100, 6, 7),
                              onChanged: (date) {
                                setState(() {
                                  LMP = Jiffy(LMP, "yyyy-MM-dd")
                                      .subtract(days: 280);
                                  ChangedDates();
                                });
                              },
                              onConfirm: (date) {
                                setState(() {
                                  LMP = Jiffy(LMP, "yyyy-MM-dd")
                                      .subtract(days: 280);
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
                        title: Text(
                          "Period of Gestation",
                        ),
                        subtitle: FlatButton(
                          onPressed: () {},
                          child: Text(
                            POG,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "End Of Trimester 1 - 84 Days",
                        ),
                        subtitle: FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              minTime: DateTime(1962, 9, 11),
                              maxTime: DateTime(2100, 6, 7),
                              onChanged: (date) {
                                setState(() {
                                  LMP = Jiffy(LMP, "yyyy-MM-dd")
                                      .subtract(days: 84);
                                  ChangedDates();
                                });
                              },
                              onConfirm: (date) {
                                setState(() {
                                  LMP = Jiffy(LMP, "yyyy-MM-dd")
                                      .subtract(days: 84);
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
                        title: Text(
                          "End Of Trimester 2 - 182 Days",
                        ),
                        subtitle: FlatButton(
                          onPressed: () {
                            DatePicker.showDatePicker(
                              context,
                              minTime: DateTime(1962, 9, 11),
                              maxTime: DateTime(2100, 6, 7),
                              onChanged: (date) {
                                setState(() {
                                  LMP = Jiffy(LMP, "yyyy-MM-dd")
                                      .subtract(days: 280);
                                  ChangedDates();
                                });
                              },
                              onConfirm: (date) {
                                setState(() {
                                  LMP = Jiffy(LMP, "yyyy-MM-dd")
                                      .subtract(days: 280);
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
                        title: Text(
                          "Go to a Day",
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: FlatButton(
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
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GridView.count(
                crossAxisCount: 3,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: OutlineButton(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.procedures),
                            SizedBox(
                              height: 5,
                            ),
                            Text("USS Date"),
                          ],
                        ),
                        onPressed: () {
                          ussDateCalculate();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: OutlineButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.sync),
                          SizedBox(
                            height: 5,
                          ),
                          Text("28 Day Cycle"),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: OutlineButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.plus),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              "Add Patient\nto List",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        _insert();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: OutlineButton(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.info),
                          SizedBox(
                            height: 5,
                          ),
                          Text("About Calculation"),
                        ],
                      ),
                      onPressed: () {
                        _showDialog();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // user defined function int ussWeeks,ussDays = 0;

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("About Pregnancy Calculator"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "Midwives and doctors have used Naegele’s rule, based on menstrual dates, to calculate gestational age. Naegele's rule is a standard way of calculating the due date for a pregnancy when assuming a gestational age of 280 days at childbirth. ",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'References',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Text('1'),
                  title: FlatButton(
                    onPressed: () {
                      launchURL01(
                          'https://obgyn.onlinelibrary.wiley.com/doi/pdf/10.1111/j.1471-0528.2000.tb11661.x');
                    },
                    child: Text(
                      "https://obgyn.onlinelibrary.wiley.com/doi/pdf/10.1111/j.1471-0528.2000.tb11661.x",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  leading: Text('2'),
                  title: FlatButton(
                    onPressed: () {
                      launchURL01(
                          'https://www.ncbi.nlm.nih.gov/pubmed/2342739');
                    },
                    child: Text(
                      "The length of uncomplicated human gestation.",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ),
              ], //14 280 84 280   182
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class RMIIndexPage extends StatefulWidget {
  @override
  _RMIIndexPageState createState() => _RMIIndexPageState();
}

enum MenopausalStatEnum { postmenopausal, premenopausal }

class _RMIIndexPageState extends State<RMIIndexPage> {
  MenopausalStatEnum _selectedmenopausestat;
  bool mulcyst = false;
  bool mets = false;
  bool ascites = false;
  bool billesion = false;
  bool solidtum = false;
  int selectedussscore = 0;
  double txtca125level;
  showEndGamePopUp() {
    showDialog<void>(
      context: context,
      builder: (_) {
        return Container(
          child: SimpleDialog(
            backgroundColor: Colors.red,
            elevation: 2.0,
            title: Text(
              "wins!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                height: 1.5,
              ),
            ),
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    child: SimpleDialogOption(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Play again"),
                )),
              ]),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SimpleDialogOption(
                      onPressed: () => print(0),
                      child: Text("Exit"),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RMI Index"),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Serum CA-125 Level (IU/ml)"),
                subtitle: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (txtval) {
                    txtca125level = double.parse(txtval);
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Ultrasound Score"),
                subtitle: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text('Multiocular cysts'),
                      value: mulcyst,
                      onChanged: (bool nowvalue) {
                        setState(() {
                          mulcyst = nowvalue;
                          nowvalue == true
                              ? selectedussscore++
                              : selectedussscore--;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Metastasis'),
                      value: mets,
                      onChanged: (bool nowvalue) {
                        setState(() {
                          mets = nowvalue;
                          nowvalue == true
                              ? selectedussscore++
                              : selectedussscore--;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Ascites'),
                      value: ascites,
                      onChanged: (bool nowvalue) {
                        setState(() {
                          ascites = nowvalue;
                          nowvalue == true
                              ? selectedussscore++
                              : selectedussscore--;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Bilateral Lesions'),
                      value: billesion,
                      onChanged: (bool nowvalue) {
                        setState(() {
                          billesion = nowvalue;
                          nowvalue == true
                              ? selectedussscore++
                              : selectedussscore--;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Multiocular cysts'),
                      value: solidtum,
                      onChanged: (bool nowvalue) {
                        setState(() {
                          solidtum = nowvalue;
                          nowvalue == true
                              ? selectedussscore++
                              : selectedussscore--;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                isThreeLine: true,
                title: Text("Menopausal Status"),
                subtitle: Column(
                  children: <Widget>[
                    RadioListTile(
                      title: Text('Premenopausal'),
                      groupValue: _selectedmenopausestat,
                      value: MenopausalStatEnum.premenopausal,
                      onChanged: (MenopausalStatEnum i) {
                        setState(() {
                          _selectedmenopausestat = i;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('Postmenopausal'),
                      groupValue: _selectedmenopausestat,
                      value: MenopausalStatEnum.postmenopausal,
                      onChanged: (MenopausalStatEnum i) {
                        setState(() {
                          _selectedmenopausestat = i;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1.0,
        child: Icon(FontAwesomeIcons.calculator),
        onPressed: () {
          double finalrmiscore;
          int ussscore;
          int menopasusescore;

          if (_selectedmenopausestat == MenopausalStatEnum.postmenopausal)
            menopasusescore = 3;
          else
            menopasusescore = 1;
          if (selectedussscore == 0)
            ussscore = 0;
          else if (selectedussscore == 1)
            ussscore = 1;
          else
            ussscore = 3;
          Color circlecolor;

          finalrmiscore = txtca125level * ussscore * menopasusescore;
          (finalrmiscore == null)
              ? finalrmiscore = 0.0
              : finalrmiscore = finalrmiscore;
          if (finalrmiscore >= 200) {
            circlecolor = Colors.red;
          } else if (finalrmiscore < 200 && finalrmiscore >= 25) {
            circlecolor = Colors.yellow;
          } else {
            circlecolor = Colors.green;
          }

          print(finalrmiscore);
          _showDialog(finalrmiscore, circlecolor);
        },
      ),
    );
  }

  // Alert Dialog function
  void _showDialog(finalrmiscore, circlecolor) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("RMI  Calculator"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatar(
                    minRadius: 30.0,
                    backgroundColor: circlecolor,
                    child: Text(finalrmiscore.toString()),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Interpretation",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "RMI I combines three pre-surgical features: serum CA125 (CA125), menopausal status (M) and ultrasound score (U). The RMI is a product of the ultrasound scan score, the menopausal status and the serum CA125 level (IU/ml).\nRMI = U x M x CA125",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'RMI score less than 25: low risk, with repeat clinical assessment advised, with MRI if ultrasound features are borderline\nRMI score 25-200: intermediate risk, with MRI recommended to further evaluate the lesion\nRMI score greater than 200: high risk, with referral to specialist gynecological cancer service, and staging CT advised'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "References",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ListTile(
                  leading: Text('1'),
                  title: FlatButton(
                    onPressed: () {
                      launchURL01(
                          'https://www.nice.org.uk/guidance/cg122/chapter/Appendix-Risk-of-malignancy-index-RMI-I');
                    },
                    child: Text(
                      "https://www.nice.org.uk/guidance/cg122/chapter/Appendix-Risk-of-malignancy-index-RMI-I",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ),
                ListTile(
                  leading: Text('2'),
                  title: FlatButton(
                    onPressed: () {
                      launchURL01(
                          'https://pubs.rsna.org/doi/10.1148/rg.326125520');
                    },
                    child: Text(
                      "https://pubs.rsna.org/doi/10.1148/rg.326125520",
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ], //14 280 84 280   182
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Widget colorDialog() => SimpleDialog(
      title: Text(
        "Message",
        textAlign: TextAlign.center,
      ),
      children: <Widget>[
        Text(
          "You must learn it carefully.",
          textAlign: TextAlign.center,
        ),
      ],
      elevation: 4,
    );
launchURL01(String url) {
  launch(url);
}
