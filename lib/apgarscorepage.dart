import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

int txttotal = 0,
    txtheartrate = 0,
    txtrespiratoryeffort = 0,
    txtmuscletone = 0,
    txtreflexirritability = 0,
    txtappearence = 0;
Color totalcolor = Color(0xffffffff);
Color totaltextcolor = Color(0xffffffff);

var Appearence = ['Blue/Pale', 'Bluish extremeties', 'Pink'];
var Pulserate = [
  'None',
  'Less than 100 beats/minute',
  'More than 100 beats/minute'
];
var Grimace = [
  'Crying',
  'Minimul Response to Stimulation',
  'No Response to Stimulation'
];
var Activity = ['Floppy / No Muscle Tone', 'Some Flexion', 'Active Motion'];
var Respiration = ['Absent', 'Weak / Irregular / Gasping', 'Regular Breathing'];

class ApgarscorePage extends StatefulWidget {
  @override
  _ApgarscorePageState createState() => _ApgarscorePageState();
}

class _ApgarscorePageState extends State<ApgarscorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("APGAR Score"),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('Appearcence : ' + Appearence[txtappearence]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtappearence.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtappearence = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtappearence.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Pulse : ' + Pulserate[txtheartrate]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtheartrate.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtheartrate = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtheartrate.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Grimace : ' + Grimace[txtreflexirritability]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtreflexirritability.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtreflexirritability = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtreflexirritability.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Activity : ' + Activity[txtmuscletone]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtmuscletone.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtmuscletone = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtmuscletone.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title:
                    Text('Respiration : ' + Respiration[txtrespiratoryeffort]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtrespiratoryeffort.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtrespiratoryeffort = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtrespiratoryeffort.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Expanded(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: totalcolor,
                child: Text(
                  txttotal.toString(),
                  style: TextStyle(
                    color: totaltextcolor,
                    fontSize: 30,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.info),
        onPressed: () {
          _showtheinfodialog();
        },
      ),
    );
  }

  totalcalculate() {
    setState(() {
      txttotal = txtappearence +
          txtheartrate +
          txtmuscletone +
          txtreflexirritability +
          txtrespiratoryeffort;
      (txttotal < 7)
          ? totalcolor = Color(0xffbf360c)
          : totalcolor = Color(0xff558b2f);
    });
  }

  void _showtheinfodialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("USS Fetal Parameters "),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  "APGAR Score is a quick summerized method to  measure Newborn Mortality and MOrbidity.\nIt consist of componentsAppearance, Pulse, Grimace, Activity, Respiration",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 20,
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
                          'https://pediatrics.aappublications.org/content/136/4/819');
                    },
                    child: Text(
                      "The APGAR Score",
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
                          'https://www.ncbi.nlm.nih.gov/pubmed/28493508');
                    },
                    child: Text(
                      "pgar Score Components at 5 Minutes: Risks and Prediction of Neonatal Mortality",
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

launchURL01(String url) {
  launch(url);
}
