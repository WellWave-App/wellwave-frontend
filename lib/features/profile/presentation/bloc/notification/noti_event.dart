import 'package:equatable/equatable.dart';

abstract class BedtimeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateBedtimeEvent extends BedtimeEvent {
  final int uid;
  final bool isActive;
  final String bedtime;

  CreateBedtimeEvent({
    required this.uid,
    required this.isActive,
    required this.bedtime,
  });

  @override
  List<Object> get props => [uid, isActive, bedtime];
}
