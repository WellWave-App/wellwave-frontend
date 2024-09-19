class NoteResponseModel {
  final int lID;
  final String logName; // Assuming this is a string, but can change to enum
  final DateTime date;
  final double value;
  final int uID;

  NoteResponseModel({
    required this.lID,
    required this.logName,
    required this.date,
    required this.value,
    required this.uID,
  });

  factory NoteResponseModel.fromJson(Map<String, dynamic> json) =>
      NoteResponseModel(
        lID: json['lID'] ?? 0, // Provide a default value
        logName: json['logName'] ?? "", // Provide a default value
        date: DateTime.fromMillisecondsSinceEpoch(json['date'] ?? 0), // Handle potential null values
        value: (json['value'] as num?)?.toDouble() ?? 0.0, // Safely convert to double
        uID: json['uID'] ?? 0, // Provide a default value
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'lID': lID,
      'logName': logName,
      'date': date.millisecondsSinceEpoch,
      'value': value,
      'uID': uID,
    };
  }
}
