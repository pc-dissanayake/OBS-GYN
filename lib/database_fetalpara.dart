import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'FetalParameters.dart';

class DatabaseHelperFetalParameters {
  static final DatabaseHelperFetalParameters _instance =
      new DatabaseHelperFetalParameters.internal();
//  int _id;
//  String _Locale;
//  String _GestationalAge;
//  String _Percentiles;
//  static final tableParameters = 'Fetal_Parameters';

  factory DatabaseHelperFetalParameters() => _instance;

  final String pt_tableParameters = 'PatientListV6';
  final String pt_columnId = 'id';
  final String pt_columnLocale = 'Locale';
  final String pt_columnMeasurement = 'Measurement';
  final String pt_columnGestationalAge = 'GestationalAge';
  final String pt_columnPercentiles = 'Percentiles';

  static Database _db;

  DatabaseHelperFetalParameters.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'FetalParametersv6.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS " + pt_tableParameters);
    await db.execute('CREATE TABLE $pt_tableParameters('
        '$pt_columnId INTEGER PRIMARY KEY, '
        '$pt_columnLocale TEXT, '
        '$pt_columnMeasurement TEXT, '
        '$pt_columnGestationalAge INT, '
        '$pt_columnPercentiles TEXT)');

    await db.execute(
        "INSERT INTO $pt_tableParameters ($pt_columnLocale,$pt_columnMeasurement,$pt_columnGestationalAge,$pt_columnPercentiles) VALUES"
        "('WHO 2017','Fetal Head Circumference',14,'86,88,91,95,100,104,107,110,112'),"
        "('WHO 2017','Fetal Head Circumference',15,'97,99,102,106,111,115,119,122,124'),"
        "('WHO 2017','Fetal Head Circumference',17,'120,123,126,130,135,140,144,147,149'),"
        "('WHO 2017','Fetal Head Circumference',16,'108,111,114,118,123,128,132,134,137'),"
        "('WHO 2017','Fetal Head Circumference',18,'132,135,138,143,148,153,157,160,162'),"
        "('WHO 2017','Fetal Head Circumference',19,'145,147,150,155,161,166,170,173,175'),"
        "('WHO 2017','Fetal Head Circumference',20,'157,159,163,168,173,179,183,186,188'),"
        "('WHO 2017','Fetal Head Circumference',21,'169,172,175,180,186,191,196,199,201'),"
        "('WHO 2017','Fetal Head Circumference',22,'181,184,187,193,198,204,209,212,214'),"
        "('WHO 2017','Fetal Head Circumference',23,'193,196,199,205,210,216,221,224,227'),"
        "('WHO 2017','Fetal Head Circumference',24,'204,207,211,216,222,228,233,236,239'),"
        "('WHO 2017','Fetal Head Circumference',25,'215,218,222,227,233,239,245,248,251'),    "
        "('WHO 2017','Fetal Head Circumference',26,'225,228,232,238,244,250,256,259,262'),    "
        "('WHO 2017','Fetal Head Circumference',27,'234,238,242,248,254,261,267,270,273'),    "
        "('WHO 2017','Fetal Head Circumference',28,'243,247,251,257,264,270,277,280,283'),    "
        "('WHO 2017','Fetal Head Circumference',29,'251,256,260,266,273,280,286,290,293'),    "
        "('WHO 2017','Fetal Head Circumference',30,'259,264,268,274,281,288,295,299,302'),    "
        "('WHO 2017','Fetal Head Circumference',31,'266,271,275,282,289,296,303,307,311'),    "
        "('WHO 2017','Fetal Head Circumference',32,'273,278,282,289,296,304,311,315,318'),    "
        "('WHO 2017','Fetal Head Circumference',33,'279,284,289,295,303,311,318,322,326'),    "
        "('WHO 2017','Fetal Head Circumference',34,'285,290,295,302,309,317,324,328,332'),    "
        "('WHO 2017','Fetal Head Circumference',35,'291,296,300,307,315,323,330,335,338'),    "
        "('WHO 2017','Fetal Head Circumference',36,'296,301,306,313,321,329,336,340,344'),    "
        "('WHO 2017','Fetal Head Circumference',37,'302,306,311,318,326,334,341,345,349'),    "
        "('WHO 2017','Fetal Head Circumference',38,'307,311,315,324,332,339,347,350,354'),    "
        "('WHO 2017','Fetal Head Circumference',39,'313,316,320,329,337,344,352,355,359'),    "
        "('WHO 2017','Fetal Head Circumference',40,'319,321,325,334,342,350,357,360,363'),"
        "( 'WHO 2017','Fetal Abdominal Circumference',14,'69,71,73,77,81,86,89,92,95'), "
        "( 'WHO 2017','Fetal Abdominal Circumference',15,'79,81,83,87,92,96,100,103,106'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',16,'89,91,93,98,103,108,112,115,118'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',17,'99,102,104,109,114,119,124,127,130'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',18,'110,113,116,121,126,131,136,139,142'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',19,'121,124,127,132,138,143,148,152,155'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',20,'132,136,139,144,150,155,161,164,167'),"
        "( 'WHO 2017','Fetal Abdominal Circumference',21,'143,147,150,156,162,168,173,177,180'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',22,'154,159,162,167,173,180,186,189,193'), "
        "( 'WHO 2017','Fetal Abdominal Circumference',23,'165,170,173,179,185,192,198,202,205'), "
        "( 'WHO 2017','Fetal Abdominal Circumference',24,'176,181,184,190,197,203,210,214,217'), "
        "( 'WHO 2017','Fetal Abdominal Circumference',25,'186,191,195,201,208,215,222,226,229'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',26,'196,201,205,212,219,226,233,238,241'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',27,'206,211,215,222,230,237,245,249,253'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',28,'215,220,225,232,240,248,256,260,264'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',29,'224,229,234,242,250,258,266,271,276'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',30,'233,238,243,251,260,269,277,282,287'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',31,'241,246,252,260,269,279,287,292,298'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',32,'249,254,260,269,279,288,298,303,308'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',33,'257,262,269,278,288,298,308,313,319'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',34,'265,270,277,287,298,308,318,324,330'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',35,'273,279,286,297,307,318,329,335,342'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',36,'282,287,294,306,317,329,340,346,353'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',37,'290,296,304,316,328,340,352,358,365'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',38,'299,306,313,326,338,351,364,371,378'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',39,'309,316,324,337,350,363,377,384,392'),    "
        "( 'WHO 2017','Fetal Abdominal Circumference',40,'319,327,335,349,363,377,391,399,406'),"
        "( 'WHO 2017','Fetal Femur Length',14,'10,10,11,12,13,14,15,16,17'),    "
        "( 'WHO 2017','Fetal Femur Length',15,'12,13,14,15,16,17,18,19,20'),    "
        "( 'WHO 2017','Fetal Femur Length',16,'15,16,17,18,19,20,22,22,23'),    "
        "( 'WHO 2017','Fetal Femur Length',17,'19,19,20,21,22,24,25,26,26'),    "
        "( 'WHO 2017','Fetal Femur Length',18,'22,22,23,24,26,27,28,29,30'),    "
        "( 'WHO 2017','Fetal Femur Length',19,'25,26,26,28,29,30,31,32,33'),    "
        "( 'WHO 2017','Fetal Femur Length',20,'28,29,30,31,32,33,35,35,36'),    "
        "( 'WHO 2017','Fetal Femur Length',21,'31,32,33,34,35,36,38,38,39'),    "
        "( 'WHO 2017','Fetal Femur Length',22,'34,35,35,37,38,39,40,41,42'),    "
        "( 'WHO 2017','Fetal Femur Length',23,'36,37,38,39,41,42,43,44,45'),    "
        "( 'WHO 2017','Fetal Femur Length',24,'39,40,41,42,43,45,46,47,47'),    "
        "( 'WHO 2017','Fetal Femur Length',25,'41,42,43,44,46,47,48,49,50'),    "
        "( 'WHO 2017','Fetal Femur Length',26,'43,44,45,46,48,49,51,51,52'),    "
        "( 'WHO 2017','Fetal Femur Length',27,'46,46,47,49,50,52,53,54,55'),    "
        "( 'WHO 2017','Fetal Femur Length',28,'48,48,49,51,52,54,55,56,57'),    "
        "( 'WHO 2017','Fetal Femur Length',29,'50,50,51,53,54,56,57,58,59'),    "
        "( 'WHO 2017','Fetal Femur Length',30,'51,52,53,55,56,58,60,60,61'),    "
        "( 'WHO 2017','Fetal Femur Length',31,'53,54,55,57,59,60,62,63,64'),    "
        "( 'WHO 2017','Fetal Femur Length',32,'55,56,57,59,61,62,64,65,66'),    "
        "( 'WHO 2017','Fetal Femur Length',33,'57,58,60,61,63,65,66,67,68'),    "
        "( 'WHO 2017','Fetal Femur Length',34,'59,60,61,63,65,67,68,69,70'),    "
        "( 'WHO 2017','Fetal Femur Length',35,'61,62,63,65,67,69,70,71,73'),    "
        "( 'WHO 2017','Fetal Femur Length',36,'63,64,65,67,69,70,72,73,75'),    "
        "( 'WHO 2017','Fetal Femur Length',37,'65,66,67,68,70,72,74,75,76'),    "
        "( 'WHO 2017','Fetal Femur Length',38,'66,67,68,70,72,74,75,77,78'),    "
        "( 'WHO 2017','Fetal Femur Length',39,'67,68,69,70,73,75,76,78,79'), "
        "( 'WHO 2017','Fetal Femur Length',40,'68,68,69,70,73,75,77,78,79'),"
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',14,'70,73,78,83,90,98,104,109,113'),          "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',15,'89,93,99,106,114,124,132,138,144'),        "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',16,'113,117,124,133,144,155,166,174,181'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',17,'141,146,155,166,179,193,207,217,225'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',18,'174,181,192,206,222,239,255,268,278'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',19,'214,223,235,252,272,292,313,328,340'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',20,'260,271,286,307,330,355,380,399,413'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',21,'314,327,345,370,398,428,458,481,497'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',22,'375,392,412,443,476,512,548,575,595'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',23,'445,465,489,525,565,608,650,682,705'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',24,'523,548,576,618,665,715,765,803,830'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',25,'611,641,673,723,778,836,894,938,970'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',26,'707,743,780,838,902,971,1038,1087,1125'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',27,'813,855,898,964,1039,1118,1196,1251,1295'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',28,'929,977,1026,1102,1189,1279,1368,1429,1481'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',29,'1053,1108,1165,1251,1350,1453,1554,1622,1682'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',30,'1185,1247,1313,1410,1523,1640,1753,1828,1897'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',31,'1326,1394,1470,1579,1707,1838,1964,2046,2126'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',32,'1473,1548,1635,1757,1901,2047,2187,2276,2367'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',33,'1626,1708,1807,1942,2103,2266,2419,2516,2619'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',34,'1785,1872,1985,2134,2312,2492,2659,2764,2880'),    "
        "( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',35,'1948,2038,2167,2330,2527,2723,2904,3018,3148'),   "
        " ( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',36,'2113,2205,2352,2531,2745,2959,3153,3277,3422'),  "
        "  ( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',37,'2280,2372,2537,2733,2966,3195,3403,3538,3697'),   "
        " ( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',38,'2446,2536,2723,2935,3186,3432,3652,3799,3973'),   "
        " ( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',39,'2612,2696,2905,3135,3403,3664,3897,4058,4247'),   "
        " ( 'WHO 2017','Estimated Fetal Weight Regardless of Fetal Sex',40,'2775,2849,3084,3333,3617,3892,4135,4312,4515')    ");
    //await db.execute(       "INSERT INTO $pt_tableParameters ($pt_columnId,$pt_columnLocale,$pt_columnMeasurement,$pt_columnGestationalAge,$pt_columnPercentiles) VALUES ,     ");

    //  await db.execute("     ");
  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient.query(pt_tableParameters, columns: [
      pt_columnId,
      pt_columnLocale,
      pt_columnMeasurement,
      pt_columnGestationalAge,
      pt_columnPercentiles
    ]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableParameters');

    return result.toList();
  }

  Future<FetalParameters> getParameters(String $txtcolumnLocale,
      String $txtcolumnMeasurement, int $txtcolumnGestationalAge) async {
    var dbClient = await db;

    List<Map> results = await dbClient.query("$pt_tableParameters",
        columns: [
          '$pt_columnLocale,$pt_columnMeasurement,$pt_columnGestationalAge,$pt_columnPercentiles'
        ],
        where:
            '$pt_columnLocale = ? AND $pt_columnMeasurement=? AND $pt_columnGestationalAge=? ',
        whereArgs: [
          $txtcolumnLocale,
          $txtcolumnMeasurement,
          $txtcolumnGestationalAge
        ]);

    if (results.length > 0) {
      // Map<String, dynamic> mapRead = results.first;
      // return mapRead['$pt_columnPercentiles'];
      return FetalParameters.fromMap(results.first);
    }

    return null;
  }
}

//
//'$columnId INTEGER PRIMARY KEY, '
//'$columnLocale TEXT, '
//'$columnMeasurement TEXT, '
//'$columnGestationalAge INT, '
//'$columnPercentiles TEXT)');
