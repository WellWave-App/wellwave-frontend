class NoteRequestModel {
  final int lID;
  final String logName; 
  final DateTime date;
  final double value;
  final int uID;
  
  NoteRequestModel({
    required this.lID,
    required this.logName,
    required this.date,
    required this.value,
    required this.uID,
  });

  NoteRequestModel copyWith({
    int? lID,
    String? logName,
    DateTime? date,
    double? value,
    int? uID,
  }) {
    return NoteRequestModel(
      lID: lID ?? this.lID,
      logName: logName ?? this.logName,
      date: date ?? this.date,
      value: value ?? this.value,
      uID: uID ?? this.uID,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lID': lID,
      'logName': logName,
      'date': date.millisecondsSinceEpoch,
      'value': value,
      'uID': uID,
    };
  }

  Map<String, dynamic> toEditNoteRequestJson(String isShowToEmployee) {
    return {
      'lID': lID, // Include id if needed
      'logName': logName,
      'date': date.toIso8601String(), // Use ISO format for date
      'value': value,
      'uID': uID,
      'ShowToEmployee': isShowToEmployee, // Similar to the previous function
    };
  }
}
