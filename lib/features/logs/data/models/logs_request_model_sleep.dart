class LogsSleepRequestModel {
  // final int lid;
  // final String logName;
  final DateTime date;
  final double value;
  // final int uid;

  LogsSleepRequestModel({
    // required this.lid,
    // required this.logName,
    required this.date,
    required this.value,
    // required this.uid,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'LID': lid,
      // 'LOG_NAME': logName,
      'DATE': date.millisecondsSinceEpoch,
      'VALUE': value,
      // 'UID': uid,
    };
  }

  factory LogsSleepRequestModel.fromJson(Map<String, dynamic> json) {
    return LogsSleepRequestModel(
      // lid: json['LID'] is int
      //     ? json['LID'] as int
      //     : int.tryParse(json['LID'] ?? '0') ?? 0,
      // logName: json['LOG_NAME'] ?? "",
      date: json['DATE'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['DATE'])
          : DateTime.tryParse(json['DATE']) ?? DateTime.now(),
      value: (json['VALUE'] is num)
          ? (json['VALUE'] as num).toDouble()
          : double.tryParse(json['VALUE'] ?? '0.0') ?? 0.0,
      // uid: json['UID'] is int
      //     ? json['UID'] as int
      //     : int.tryParse(json['UID'] ?? '0') ?? 0,
    );
  }

  // Method for editing logs request
  Map<String, dynamic> toEditLogsRequestJson(String isShowToEmployee) {
    return {
      // 'LID': lid, // Include id if needed
      // 'LOG_NAME': logName,
      'DATE': date.toIso8601String(), // Use ISO format for date
      'VALUE': value,
      // 'UID': uid,
    };
  }
}
