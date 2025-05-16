// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'users_event.dart';
// part 'users_state.dart';

// class UsersBloc extends Bloc<UsersEvent, UsersState> {
//   UsersBloc() : super(UsersInitialState()) {
//     on<UsersEvent>((event, emit) {

//     });
//   }
// }


//user_bloc.dart
import 'package:cv_d_project/features/data/models/users_model.dart';
import 'package:cv_d_project/features/data/repositories/api_service.dart';
import 'package:cv_d_project/features/presentation/bloc/users_event.dart';
import 'package:cv_d_project/features/presentation/bloc/users_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Box<UsersModel> hiveBox;
  final ApiService apiService;

  UserBloc(this.hiveBox,this.apiService) : super(UserState(users: [])) {
    on<LoadUsers>((event, emit) async {
      try {
        final apiUsers = await apiService.getUsers();

        // Save to Hive
        await hiveBox.clear();
        for (var user in apiUsers) {
          hiveBox.add(user);
        }

        emit(UserState(users: apiUsers));
      } catch (e) {
        emit(UserState(users: [])); // Or create error state
      }
    });


    on<ToggleUserSelection>((event, emit) {
      final updatedUsers = [...state.users];
      updatedUsers[event.index].isSelected = !updatedUsers[event.index].isSelected;
      emit(state.copyWith(users: updatedUsers));
    });

    on<SelectAllUsers>((event, emit) {
      final updatedUsers = state.users.map((u) {
        u.isSelected = true;
        return u;
      }).toList();
      emit(state.copyWith(users: updatedUsers, allSelected: true));
    });

    on<ResetSelections>((event, emit) {
      final updatedUsers = state.users.map((u) {
        u.isSelected = false;
        return u;
      }).toList();
      emit(state.copyWith(users: updatedUsers, allSelected: false));
    });

    on<DeleteSelectedUsers>((event, emit) {
      final updatedUsers = state.users.where((u) => !u.isSelected).toList();
      hiveBox.clear(); // optional: or just remove selected keys
      updatedUsers.forEach(hiveBox.add);
      emit(UserState(users: updatedUsers));
    });

    on<SubmitSelectedUsers>((event, emit) {
      hiveBox.clear();
      state.users.forEach(hiveBox.add);
      emit(state); // re-emit current state
    });
  }
}
