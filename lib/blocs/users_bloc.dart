import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/api/models/user.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';

abstract class UsersBlocEvent {}

class UsersBlocEventGetData extends UsersBlocEvent {}

class GetUserBlocEvent extends UsersBlocEvent {
  final int userId;

  GetUserBlocEvent(this.userId);
}

abstract class UsersBlocState {}

class UsersBlocStateInitial extends UsersBlocState {}

class UsersBlocStateDataFetched extends UsersBlocState {}

class UsersBlocStateGoUserDetails extends UsersBlocState {}

class UsersBlocStateError extends UsersBlocState {
  final String message;

  UsersBlocStateError(this.message);
}

class UsersBloc extends Bloc<UsersBlocEvent, UsersBlocState> {
  UsersBloc(this._dataProvider) : super(UsersBlocStateInitial()) {
    on<UsersBlocEventGetData>((event, emit) async {
      try {
        await _dataProvider.getUsers();
        emit(UsersBlocStateDataFetched());
      } catch (e) {
        debugPrint(e.toString());
        emit(UsersBlocStateError(
            'Данные не удалось получить, повторите позже.'));
      }
    });
    on<GetUserBlocEvent>((event, emit) {
      _dataProvider.getCurrentUser(event.userId);
      emit(UsersBlocStateGoUserDetails());
    });
  }

  final DataProvider _dataProvider;

  List<User> get users => _dataProvider.allUsers;

  User get currentUser => _dataProvider.currentUser;
}
