import 'package:firebase_storage/firebase_storage.dart';
enum ProcessType{create,delete}
class CrudState{
}
class LoadingState extends CrudState{
}

class ReadState extends CrudState{
  List<Reference> reference ;
  ReadState(this.reference);
}
class ProcessStat extends CrudState{
  final String message;
  final bool sussecc;
  final ProcessType processType;
  ProcessStat(this.message, this.sussecc, this.processType);
}
