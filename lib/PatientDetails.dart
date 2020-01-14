class PatientDetails {
  int _patient_id;
  String _LMP;
  String _Notes;

  static final tablepatient = 'my_patients';

  PatientDetails(this._LMP, this._Notes);

  PatientDetails.map(dynamic obj) {
    this._patient_id = obj['patient_id'];
    this._LMP = obj['LMP'];
    this._Notes = obj['Notes'];
  }

  int get patient_id => _patient_id;
  String get LMP => _LMP;
  String get Notes => _Notes;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_patient_id != null) {
      map['patient_id'] = _patient_id;
    }
    map['LMP'] = _LMP;
    map['Notes'] = _Notes;

    return map;
  }

  PatientDetails.fromMap(Map<String, dynamic> map) {
    this._patient_id = map['patient_id'];
    this._LMP = map['LMP'];
    this._Notes = map['Notes'];
  }
}
