import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'FetalParametersPage.dart';
import 'PatientList.dart';
import 'apgarscorepage.dart';
import 'bishopcorepage.dart';
import 'pages.dart';
import 'variables.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBS | GYN',
      theme: ThemeData(
        primaryColor: Color(0xFF6a1b9a),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime toDAyNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Widget allWidgets;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('OBS | GYN')),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: gradient1,
              ),
              child: Center(
                child: Text(
                  'OBS | GYN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.child_care,
              ),
              title: Text('Pregnancy Calculator'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PregnancyCalculatorpage()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.registered,
              ),
              title: Text('RMI'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RMIIndexPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.users),
              title: Text('Patients List'),
              onTap: () {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientListPage()),
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.heartbeat),
              title: Text('USS Fetal Parameters'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FetalParameterPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.amilia),
              title: Text('APGAR Score'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApgarscorePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.bold),
              title: Text('Bishop Score for Vaginal Delivery'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BishopscorePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.exclamationTriangle),
              title: Text('VBAC Risk Score'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsPageStateful()),
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.link),
              title: Text('Visit My Site'),
              onTap: () {
                launch('https://pcd.xyz.lk/');
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient2,
          ),
          child: Center(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PregnancyCalculatorpage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.child_care,
                            size: 40,
                            color: HomepagebuttonsiconColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Preganancy\nCalculator',
                            textAlign: TextAlign.center,
                            style: HomePageButtonTexts,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RMIIndexPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.registered,
                            size: 40,
                            color: HomepagebuttonsiconColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'RMI\nIndex',
                            textAlign: TextAlign.center,
                            style: HomePageButtonTexts,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientListPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.users,
                            size: 40,
                            color: HomepagebuttonsiconColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Patient List',
                            textAlign: TextAlign.center,
                            style: HomePageButtonTexts,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FetalParameterPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.heartbeat,
                            size: 40,
                            color: HomepagebuttonsiconColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'USS Fetal Parameters',
                            textAlign: TextAlign.center,
                            style: HomePageButtonTexts,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ApgarscorePage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.amilia,
                            size: 40,
                            color: HomepagebuttonsiconColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'APGAR Score',
                            textAlign: TextAlign.center,
                            style: HomePageButtonTexts,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BishopscorePage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.bold,
                            size: 40,
                            color: HomepagebuttonsiconColor,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Bishop Score',
                            textAlign: TextAlign.center,
                            style: HomePageButtonTexts,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
