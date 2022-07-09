import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  bool accountIsLogged = false;

  AccountBloc() : super(AccountInitial(isLogged: false)) {
    on<AccountEvent>((event, emit) {
      if (event is AccountInitEvent) {
        emit(AccountLoginState(isLogged: accountIsLogged));
      }
    });
  }
}
