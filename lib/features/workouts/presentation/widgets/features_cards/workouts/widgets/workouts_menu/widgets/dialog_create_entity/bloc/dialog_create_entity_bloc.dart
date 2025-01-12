import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dialog_create_entity_event.dart';
part 'dialog_create_entity_state.dart';

class DialogCreateEntityBloc extends Bloc<DialogCreateEntityEvent, DialogCreateEntityState> {
  DialogCreateEntityBloc() : super(DialogCreateEntityInitial()) {
    on<DialogCreateEntityEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
