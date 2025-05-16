// part of 'users_bloc.dart';

// @immutable
// sealed class UsersState {}


// // user_state.dart
import 'package:cv_d_project/features/data/models/users_model.dart';

class UserState {
  final List<UsersModel> users;
  final bool allSelected;

  UserState({required this.users, this.allSelected = false});

  UserState copyWith({List<UsersModel>? users, bool? allSelected}) {
    return UserState(
      users: users ?? this.users,
      allSelected: allSelected ?? this.allSelected,
    );
  }
}
