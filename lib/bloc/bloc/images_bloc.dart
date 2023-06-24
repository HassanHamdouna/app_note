import 'package:app_note/bloc/events/crud_event.dart';
import 'package:app_note/bloc/states/curd_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesBloc extends Bloc<CrudEvent,CrudState>{
  ImagesBloc(super.initialState){
    on<CreateEvent>(_onCreateEvent);
    on<ReadEvent>(_onReadEvent);
    on<DeleteEvent>(_onDeleteEvent);
  }

  void _onCreateEvent(CreateEvent event,Emitter<CrudState> emit){

  }
  void _onReadEvent(ReadEvent event ,Emitter<CrudState> emit) async {

  }
  void _onDeleteEvent(DeleteEvent event,Emitter<CrudState> emit)async {

  }
}