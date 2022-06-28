import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_categories_event.dart';
part 'home_categories_state.dart';

class HomeCategoriesBloc
    extends Bloc<HomeCategoriesEvent, HomeCategoriesState> {
  HomeCategoriesBloc() : super(HomeCategoriesInitial()) {
    on<HomeCategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
