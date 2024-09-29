// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LogsRequestModel {
  final int lid;
  final String logName;
  final DateTime date;
  final double value;
  final int uid;
  LogsRequestModel({
    required this.lid,
    required this.logName,
    required this.date,
    required this.value,
    required this.uid,
  });

  // LogsRequestModel copyWith({
  //   int? lid,
  //   String? logName,
  //   DateTime? date,
  //   double? value,
  //   int? uid,
  // }) {
  //   return LogsRequestModel(
  //     lid: lid ?? this.lid,
  //     logName: logName ?? this.logName,
  //     date: date ?? this.date,
  //     value: value ?? this.value,
  //     uid: uid ?? this.uid,
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lid': lid,
      'logName': logName,
      'date': date.millisecondsSinceEpoch,
      'value': value,
      'uid': uid,
    };
  }

  factory LogsRequestModel.fromMap(Map<String, dynamic> map) {
    return LogsRequestModel(
      lid: map['lid'] as int,
      logName: map['logName'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      value: map['value'] as double,
      uid: map['uid'] as int,
    );
  }
}
