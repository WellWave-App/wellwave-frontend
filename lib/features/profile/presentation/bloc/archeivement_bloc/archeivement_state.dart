import '../../../data/models/archeivement_request_model.dart';

abstract class ArcheivementState {}

class ArcheivementInitial extends ArcheivementState {}

class ArcheivementLoading extends ArcheivementState {}

class ArcheivementLoaded extends ArcheivementState {
  final List<ArcheivementRequestModel> achievements;

  ArcheivementLoaded(this.achievements);
}

class ArcheivementError extends ArcheivementState {
  final String message;

  ArcheivementError(this.message);
}
