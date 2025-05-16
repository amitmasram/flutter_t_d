

// user_event.dart
abstract class UserEvent {}

class LoadUsers extends UserEvent {}

class ToggleUserSelection extends UserEvent {
  final int index;
  ToggleUserSelection(this.index);
}

class SelectAllUsers extends UserEvent {}

class ResetSelections extends UserEvent {}

class DeleteSelectedUsers extends UserEvent {}

class SubmitSelectedUsers extends UserEvent {}


// part of 'users_bloc.dart';

// @immutable
// sealed class UsersEvent {}

// class SelectAllUsersEvent extends UsersEvent {
//   final bool selectAll;

//   SelectAllUsersEvent({required this.selectAll});

//   @override
//   List<Object> get props => [selectAll];
// }

// class ResetSelectionEvent extends UsersEvent {}

// class DeleteSelectedUsersEvent extends UsersEvent {}

// class SubmitSelectedUsersEvent extends UsersEvent {}
