import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUserProfile extends ProfileEvent {}

class EditUserProfile extends ProfileEvent {
  final String? imageUrl;
  final String username;
  final int yearOfBirth;
  final bool gender;
  final num height;
  final num weight;

  EditUserProfile({
    this.imageUrl,
    required this.username,
    required this.yearOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
  });

  @override
  List<Object?> get props => [
        imageUrl,
        username,
        yearOfBirth,
        gender,
        height,
        weight,
      ];
}

class EditUserGoalPerWeek extends ProfileEvent {
  final int stepPerWeek;
  final int exercisePerWeek;

  EditUserGoalPerWeek({
    required this.stepPerWeek,
    required this.exercisePerWeek,
  });

  @override
  List<Object?> get props => [stepPerWeek, exercisePerWeek];
}

class ImagePicked extends ProfileEvent {
  final File imageFile;

  ImagePicked(this.imageFile);
}
