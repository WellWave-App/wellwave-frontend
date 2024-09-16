part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

class NoteFetched extends NoteEvent{}
class WaterRecordClicked extends NoteEvent{}
class SleepRecordClicked extends NoteEvent{}
class WeeklyRecordClicked extends NoteEvent{}
