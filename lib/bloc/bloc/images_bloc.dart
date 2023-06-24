import 'package:app_note/bloc/events/crud_event.dart';
import 'package:app_note/bloc/states/curd_state.dart';
import 'package:app_note/firebase/fb_storage_controller.dart';
import 'package:app_note/models/fb_response.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesBloc extends Bloc<CrudEvent, CrudState> {
  ImagesBloc(super.initialState) {
    on<CreateEvent>(_onCreateEvent);
    on<ReadEvent>(_onReadEvent);
    on<DeleteEvent>(_onDeleteEvent);
  }

  final FbStorageController _storageController = FbStorageController();
  List<Reference> _reference = <Reference>[];

  void _onCreateEvent(CreateEvent event, Emitter<CrudState> emit) {
    UploadTask uploadTask = _storageController.upload(event.path);
    uploadTask.snapshotEvents.listen((event) {
      if (event.state == TaskState.success) {
        emit(LoadingState());
        _reference.add(event.ref);
        emit(ReadState(_reference));
        emit(ProcessStat('Image uploaded successfully ', true, ProcessType.create));
      } else if (event.state == TaskState.error) {
        emit(ProcessStat('Image Not upload field ', false, ProcessType.create));
      }
    });
  }

  void _onReadEvent(ReadEvent event, Emitter<CrudState> emit) async {
    _reference = await _storageController.read();
    emit(ReadState(_reference));
  }

  void _onDeleteEvent(DeleteEvent event, Emitter<CrudState> emit) async {
    FbResponse response = await _storageController.delete(_reference[event.index].fullPath);
    if(response.success){
      _reference.removeAt(event.index);
      emit(ProcessStat(response.message, response.success, ProcessType.delete));
      emit(ReadState(_reference));
    }
    emit(ProcessStat(response.message, !response.success, ProcessType.delete));
  }
}
