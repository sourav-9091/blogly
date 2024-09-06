import 'package:blog_firebase/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_firebase/core/common/entities/user.dart';
import 'package:blog_firebase/features/auth/domain/repository/usecases/current_user.dart';
import 'package:blog_firebase/features/auth/domain/repository/usecases/user_sign_in.dart';
import 'package:blog_firebase/features/auth/domain/repository/usecases/user_sign_up.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignup,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignup,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>(
      (_, emit) => emit(
        AuthLoading(),
      ),
    );
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(
        AuthFailure(l.message),
      ),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  Future<void> _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final response = await _userSignUp.call(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  Future<void> _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final response = await _userSignIn.call(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.UpdateUser(user);
    emit(AuthSuccess(user));
  }
}
