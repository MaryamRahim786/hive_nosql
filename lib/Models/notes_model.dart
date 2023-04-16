import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 0)
class NotesModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  // @HiveField(3)
  // List<dynamic> carsList = ['a', 'c', 'f', 4, 'ajskd'];

  NotesModel({
    required this.title,
    required this.description,
    // required this.carsList
  });
}

// @HiveType(typeId: 1)
// class ContactsModel {
//   late String title;
//   late String description;

//   ContactsModel({required this.title, required this.description});
// }
