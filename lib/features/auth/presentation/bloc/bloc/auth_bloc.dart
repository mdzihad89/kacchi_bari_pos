
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/auth_repository.dart';
import '../event/auth_event.dart';
import '../state/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent ,AuthState>{
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()){
    on<SignInWithEmailPassword>((event, emit) async {
      emit(AuthLoading());
      final result = await authRepository.signInWithEmailPassword(event.loginRequestDto);
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (user) => emit(Authenticated(user)),
      );
    });


    on<SignOutRequested>((event, emit) async {
      final result = await authRepository.signOut();
      if(result){
        emit(UnAuthenticated());
      }else{
        emit(const AuthError("Sign Out Failed"));
      }
    });

    on<GetUserData> ((event, emit) async{
      emit(AuthLoading());
      final result=await authRepository.getUserData();
      result.fold(
            (failure) => emit(AuthError(failure.message)),
            (user) => emit(Authenticated(user)),
      );
    });
  }






}