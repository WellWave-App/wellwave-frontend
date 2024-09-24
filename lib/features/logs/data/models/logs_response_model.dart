class LogsResponseModel {
  final int lID;
  final String logName; // Assuming this is a string, but can change to enum
  final DateTime date;
  final double value;
  final int uID;

  LogsResponseModel({
    required this.lID,
    required this.logName,
    required this.date,
    required this.value,
    required this.uID,
  });

  factory LogsResponseModel.fromJson(Map<String, dynamic> json) =>
      LogsResponseModel(
        lID: json['LID'] ?? 0, // Provide a default value
        logName: json['LOG_NAME'] ?? "", // Provide a default value
        date: DateTime.fromMillisecondsSinceEpoch(json['DATE'] ?? 0), // Handle potential null values
        value: (json['VALUE'] as num?)?.toDouble() ?? 0.0, // Safely convert to double
        uID: json['UID'] ?? 0, // Provide a default value
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'LID': lID,
      'LOG_NAME': logName,
      'DATE': date.millisecondsSinceEpoch,
      'VALUE': value,
      'UID': uID,
    };
  }
}
