class CrudEvent{

}
class CreateEvent extends CrudEvent{
  final String path;

  CreateEvent(this.path);
}

class Read extends CrudEvent{

}
class Delete extends CrudEvent{
  final int index;
  Delete(this.index);
}