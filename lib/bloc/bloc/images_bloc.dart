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
  List<Reference> _references = <Reference>[];

  void _onCreateEvent(CreateEvent event, Emitter<CrudState> emit) {
    UploadTask uploadTask = _storageController.upload(event.path);
    uploadTask.snapshotEvents.listen((event) {
      if (event.state == TaskState.success) {
         _references.add(event.ref);
         emit(ReadState(_references));
        emit(ProcessState(
            'Image uploaded successfully', true, ProcessType.create));
      } else if (event.state == TaskState.error) {
        emit(ProcessState('Image Not uploaded', false, ProcessType.create));
      }
    });
    emit(ReadState(_references));

  }

  void _onReadEvent(ReadEvent event, Emitter<CrudState> emit) async {
    emit(LoadingState());
    _references = await _storageController.read();
    emit(ReadState(_references));
  }

  void _onDeleteEvent(DeleteEvent event, Emitter<CrudState> emit) async {
    FbResponse response =
        await _storageController.delete(_references[event.index].fullPath);
    if (response.success) {
      _references.removeAt(event.index);
      emit(
          ProcessState(response.message, response.success, ProcessType.delete));
      emit(ReadState(_references));
    }
    emit(ProcessState(response.message, !response.success, ProcessType.delete));
  }
}
