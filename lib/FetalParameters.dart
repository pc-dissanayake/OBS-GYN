class FetalParameters {
  int _id;
  String _Locale;
  String _Measurement;
  int _GestationalAge;
  String _Percentiles;

  static final tableParameters = 'Fetal_Parameters';

  FetalParameters(
      this._Locale, this._Measurement, this._GestationalAge, this._Percentiles);

  FetalParameters.map(dynamic obj) {
    this._id = obj['id'];
    this._Locale = obj['Locale'];
    this._Measurement = obj['Measurement'];
    this._GestationalAge = obj['GestationalAge'];
    this._Percentiles = obj['Percentiles'];
  }

  int get id => _id;
  String get Locale => _Locale;
  int get Measurement => Measurement;
  int get GestationalAge => _GestationalAge;
  String get Percentiles => _Percentiles;

  Map<dynamic, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['Locale'] = _Locale;
    map['Measurement'] = _Measurement;
    map['GestationalAge'] = _GestationalAge;
    map['_Percentiles'] = Percentiles;

    return map;
  }

  FetalParameters.fromMap(Map<dynamic, dynamic> map) {
    this._id = map['_id'];
    this._Locale = map['Locale'];
    this._Measurement = map['Measurement'];
    this._GestationalAge = map['GestationalAge'];
    this._Percentiles = map['Percentiles'];
  }
}
