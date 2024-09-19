class NoteRequestModel {
  final int lid;
  final String logName; 
  final DateTime date;
  final double value;
  final int uid;
  
  NoteRequestModel({
    required this.lid,
    required this.logName,
    required this.date,
    required this.value,
    required this.uid,
  });

  NoteRequestModel copyWith({
    int? lID,
    String? logName,
    DateTime? date,
    double? value,
    int? uID,
  }) {
    return NoteRequestModel(
      lid: lID ?? lid,
      logName: logName ?? this.logName,
      date: date ?? this.date,
      value: value ?? this.value,
      uid: uID ?? uid,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lID': lid,
      'logName': logName,
      'date': date.millisecondsSinceEpoch,
      'value': value,
      'uID': uid,
    };
  }

  Map<String, dynamic> toEditNoteRequestJson(String isShowToEmployee) {
    return {
      'lID': lid, // Include id if needed
      'logName': logName,
      'date': date.toIso8601String(), // Use ISO format for date
      'value': value,
      'uID': uid,
      'ShowToEmployee': isShowToEmployee, // Similar to the previous function
    };
  }
}
