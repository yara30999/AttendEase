import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  CreateGroupBloc() : super(CreateGroupInitial()) {
    on<CreateGroupEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
