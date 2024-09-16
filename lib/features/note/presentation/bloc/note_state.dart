part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

class NoteLoadInProgress extends NoteState {}

class NoteError extends NoteState {
  final String errorMessage;

  NoteError(this.errorMessage);
}

class NoteSuccess extends NoteState {
  //water model
  //sleep model

  //weekly chart 
}
