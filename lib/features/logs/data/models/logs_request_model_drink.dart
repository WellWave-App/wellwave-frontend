class LogsDrinkRequestModel {
  final DateTime date;
  final double value;

  LogsDrinkRequestModel({
    required this.date,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'DATE': date.millisecondsSinceEpoch,
      'VALUE': value,
    };
  }

  factory LogsDrinkRequestModel.fromJson(Map<String, dynamic> json) {
    return LogsDrinkRequestModel(
      date: json['DATE'] is int
          ? DateTime.fromMillisecondsSinceEpoch(json['DATE'])
          : DateTime.tryParse(json['DATE']) ?? DateTime.now(),
      value: (json['VALUE'] is num)
          ? (json['VALUE'] as num).toDouble()
          : double.tryParse(json['VALUE'] ?? '0.0') ?? 0.0,
    );
  }

  // Method for editing logs request
  Map<String, dynamic> toEditLogsRequestJson(String isShowToEmployee) {
    return {
      'DATE': date.toIso8601String(), // Use ISO format for date
      'VALUE': value,
    };
  }
}
