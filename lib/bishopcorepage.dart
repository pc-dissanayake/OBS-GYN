import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

int txttotal = 0,
    txtEffacement = 0,
    txtCervixPosition = 0,
    txtStation = 0,
    txtCervicalConsistancy = 0,
    txtCervicalDilation = 0;
Color totalcolor = Color(0xffffffff);
Color totaltextcolor = Color(0xffffffff);

var CervicalDilation = ['Closed', '1-2', '3-4', '5-6'];
var Effacement = [
  '0%-30%',
  '40%-50%',
  '60%-70%',
  'More than 80%',
];
var CervixPosition = ['Anterior', 'MMid Position', 'Anterior', 'Anterior'];
var Station = ['-3', '-2', '-1 , 0', '+1 , +2'];
var CervicalConsistancy = ['Firm', 'Medium', 'Soft', 'Soft'];

class BishopscorePage extends StatefulWidget {
  @override
  _BishopscorePageState createState() => _BishopscorePageState();
}

class _BishopscorePageState extends State<BishopscorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Bishop Score for Vaginal Delivery"),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text('Cervical Dialatation : ' +
                    CervicalDilation[txtCervicalDilation]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtCervicalDilation.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtCervicalDilation = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtCervicalDilation.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Effacement : ' + Effacement[txtEffacement]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtEffacement.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtEffacement = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtEffacement.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                    'Cervix Position : ' + CervixPosition[txtCervixPosition]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtCervixPosition.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtCervixPosition = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtCervixPosition.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Station : ' + Station[txtStation]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtStation.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtStation = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtStation.toString(),
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Cervical Consistancy : ' +
                    CervicalConsistancy[txtCervicalConsistancy]),
                subtitle: Slider(
                  min: 0,
                  max: 2,
                  value: txtCervicalConsistancy.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      txtCervicalConsistancy = valchanged.toInt();
                      totalcalculate();
                    });
                  },
                ),
                trailing: Text(
                  txtCervicalConsistancy.toString(),
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
      txttotal = txtCervicalDilation +
          txtEffacement +
          txtCervixPosition +
          txtStation +
          txtCervicalConsistancy;
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
                  "The Bishop score is the most commonly used method to rate the readiness of the cervix for induction of labour.\nThe total score is calculated by assessing the following five components on manual vaginal examination by a trained professional: Cervical dilation in centimeters, Cervical effacement as a percentage,Cervical consistency by provider assessment/judgement, Cervical position, Fetal station, the position of the fetal head in relation to the pelvic bones.\nA Bishop score of 8 or greater is considered to be favorable for induction, or the chance of a vaginal delivery with induction is similar to spontaneous labor.  A score of 6 or less is considered to be unfavorable if an induction is indicated cervical ripening agents may be utilized.",
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
                          'https://www.ncbi.nlm.nih.gov/books/NBK470368/#article-18340.s1');
                    },
                    child: Text(
                      "Bishop Score",
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
                          'https://www.ncbi.nlm.nih.gov/pubmed/28181995');
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
