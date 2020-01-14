import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:obs_gyn/variables.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chartdata.dart';
import 'database_fetalpara.dart';

class FetalParameterPage extends StatefulWidget {
  @override
  _FetalParameterPageState createState() => _FetalParameterPageState();
}

String valLocale;
String varMeasurement;
double valsize;
int varGestationalAge = 14;
bool isShowingMainData = true;
double chartmaxYval, chartminYval = 1;
String percentilebetweentext = 'Between';

class _FetalParameterPageState extends State<FetalParameterPage> {
  final dbHelperFetalPara = DatabaseHelperFetalParameters();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USS Fetal Parameters'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Percentile"),
                subtitle: Center(
                  child: Text(
                    percentilebetweentext,
                    style: TextStyle(
                      color: Colors.red[900],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Value (mm)"),
                subtitle: Center(
                  child: TextFormField(
                    onChanged: (txtval) {
                      // valsize = valsize.toDouble();
                      valsize = double.parse(txtval);
                    },
                    keyboardType: TextInputType.numberWithOptions(
                      signed: false,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Locale"),
                subtitle: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: valLocale,
                      isExpanded: true,
                      items: <String>['WHO 2017'].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (valuechanged) {
                        setState(() {
                          valLocale = valuechanged;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Measurement"),
                subtitle: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: varMeasurement,
                      isExpanded: true,
                      items: <String>[
                        'Fetal Abdominal Circumference',
                        'Fetal Head Circumference',
                        'Fetal Femur Length',
                        'Estimated Fetal Weight Regardless of Fetal Sex'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (valuechanged) {
                        setState(() {
                          switch (valuechanged) {
                            case 'Fetal Abdominal Circumference':
                              chartmaxYval = 410.0;
                              chartminYval = 69;
                              break;
                            case 'Fetal Head Circumference':
                              chartmaxYval = 380.0;
                              chartminYval = 85;

                              break;
                            case 'Fetal Femur Length':
                              chartmaxYval = 80.0;
                              chartminYval = 8;
                              break;
                            case 'Estimated Fetal Weight Regardless of Fetal Sex':
                              chartmaxYval = 4520.0;
                              chartminYval = 65;
                              break;
                          }
                          varMeasurement = valuechanged;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Gestational Age : $varGestationalAge"),
                subtitle: Slider(
                  min: 14,
                  max: 40,
                  value: varGestationalAge.toDouble(),
                  onChanged: (valchanged) {
                    setState(() {
                      varGestationalAge = valchanged.toInt();
                      //varGestationalAge();
                    });
                  },
                ),
              ),
            ), //varGestationalAge
            Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                elevation: 2,
                color: primaryColor,
                child: Text(
                  "Calculate",
                  style: ButtonTextcolorforPrimary,
                ),
                onPressed: () {
                  setState(() {
                    //var percentes = [0,   1,  2,  3, 4,  5,  6,  7,   8];
                    var percentiles = [2.5, 5, 10, 25, 50, 75, 90, 95, 97.5];
                    int maxedoutpercentile = 0;
                    String centilestext;
                    dbHelperFetalPara
                        .getParameters(
                            valLocale, varMeasurement, varGestationalAge)
                        .then((fetal) {
                      if (valsize < chartmaxYval && valsize > chartminYval) {
                        spotdata =
                            FlSpot(varGestationalAge.toDouble(), valsize);
                      } else {
                        spotdata = FlSpot(0, 0);
                      }
                      String gotpercentiles = fetal.Percentiles.toString();
                      var listedgotpercentiles = gotpercentiles.split(",");

                      print(fetal.Percentiles.toString());
                      outerloop:
                      for (int ii = 0; ii < 9; ii++) {
                        print(ii);
                        if (valsize <= double.parse(listedgotpercentiles[ii]) &&
                            ii == 0) {
                          print("less 2.5");
                          percentilebetweentext = "Less than 2.5th centile";
                          break outerloop;
                        } else if (valsize >=
                                double.parse(listedgotpercentiles[ii]) &&
                            ii == 8) {
                          print("less 97.5");
                          percentilebetweentext = "More than 97.5th centile";
                          break outerloop;
                        } else if (valsize <=
                            double.parse(listedgotpercentiles[ii])) {
                          percentilebetweentext = "Between " +
                              percentiles[ii -= 1].toString() +
                              "th and " +
                              percentiles[ii += 1].toString() +
                              "th";
                          break outerloop;
                        }
                      }

                      //print(percentiles[maxedoutpercentile += 1]);

                      print(percentilebetweentext);
                      //percentilebetweentext  Between 25th and 75th
                      // gotparametersmap = fetal.Percentiles;
                    });
                  });
                },
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                child: LineChart(
                  varMeasurement == 'Fetal Abdominal Circumference'
                      ? Dataprocessmm()
                      : varMeasurement == 'Fetal Head Circumference'
                          ? Dataprocessmm()
                          : varMeasurement == 'Fetal Femur Length'
                              ? Dataprocessmm()
                              : varMeasurement ==
                                      'Estimated Fetal Weight Regardless of Fetal Sex'
                                  ? Dataprocessmm()
                                  : Dataprocessmm(),
                  swapAnimationDuration: Duration(milliseconds: 250),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _query();
        },
        child: Icon(FontAwesomeIcons.info),
      ),
    );
  }

  //models
  void _query() {
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
                  "Ultrasound estimation of fetal weight  is a key tool in identifying and managing high-risk pregnancies and available in most of the OBS/GYN centers.",
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
                          'https://www.who.int/reproductivehealth/topics/maternal_perinatal/fetal-growth-charts/en/');
                    },
                    child: Text(
                      "WHO publishes new multinational fetal growth charts",
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
                          'https://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1002220');
                    },
                    child: Text(
                      "https://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.1002220",
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

LineChartData Dataprocessnopes() {
  return LineChartData();
}

LineChartData Dataprocessgrams() {
  return LineChartData();
}

LineChartData Dataprocessmm() {
  return LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
      ),
      touchCallback: (LineTouchResponse touchResponse) {
        print(touchResponse);
      },
      handleBuiltInTouches: true,
    ),
    gridData: const FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 25:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '25';
              case 50:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '50';
              case 75:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '75';
              case 100:
                return '100';
              case 150:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '150';
              case 200:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '200';
              case 250:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '250';
              case 300:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '300';
              case 350:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '350';
              case 400:
                return (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? ''
                    : '400';
              case 500:
                return '500';
              case 600:
                return (varMeasurement !=
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? '600'
                    : '';
              case 900:
                return '900';
              case 1200:
                return '1200';
              case 1500:
                return '1500';
              case 2000:
                return '2000';
              case 3000:
                return '3000';
              case 4000:
                return '4000';
            }
            return '';
          },
          margin: 4,
          reservedSize: 50,
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: const Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 14:
                return '14';
              case 21:
                return '21';
              case 28:
                return '28';
              case 35:
                return '35';
              case 40:
                return '40';
            }
            return '';
          },
          margin: 10,
          reservedSize: 10,
        )),
    borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
            color: const Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        )),
    minX: 14,
    maxX: 40,
    maxY: chartmaxYval,
    minY: chartminYval, //
    lineBarsData: (varMeasurement == 'Fetal Abdominal Circumference')
        ? linesBarDataabdomenCircumference(spotdata)
        : (varMeasurement == 'Fetal Head Circumference')
            ? linesBarDataFetalHeadCircumference(spotdata)
            : (varMeasurement == 'Fetal Femur Length')
                ? linesBarDataFetalFemurLength(spotdata)
                : (varMeasurement ==
                        'Estimated Fetal Weight Regardless of Fetal Sex')
                    ? linesBarDataFwtalWeightregardlessofsex(spotdata)
                    : linesBarDataabdomenblanlk(spotdata),
  );
}

FlSpot spotdata = FlSpot(0, 0);
launchURL01(String url) {
  launch(url);
}
