import 'package:hive/hive.dart';
import 'package:hive_nosql/Models/notes_model.dart';

class Boxes {
  static Box<NotesModel> getData() {
    //get box data from NotesModel
    return Hive.box<NotesModel>('notes');
  }
}
