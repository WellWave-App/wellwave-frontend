import 'package:equatable/equatable.dart';

abstract class BedtimeState extends Equatable {
  @override
  List<Object> get props => [];
}

class BedtimeInitial extends BedtimeState {}

class BedtimeLoading extends BedtimeState {}

class BedtimeSuccess extends BedtimeState {}

class BedtimeFailure extends BedtimeState {
  final String error;

  BedtimeFailure(this.error);

  @override
  List<Object> get props => [error];
}
