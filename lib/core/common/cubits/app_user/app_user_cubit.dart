import 'package:blog_firebase/core/common/entities/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void UpdateUser(User? user) {
    if (user == null)
      emit(AppUserInitial());
    else {
      emit(AppUserLoggedIn(user));
    }
  }
}
