import 'package:equatable/equatable.dart';

abstract class ArcheivementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchArcheivement extends ArcheivementEvent {}
