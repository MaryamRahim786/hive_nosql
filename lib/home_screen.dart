import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_nosql/Models/notes_model.dart';

import 'Boxes/boxes.dart';

class HomeScreenScreen extends StatefulWidget {
  const HomeScreenScreen({super.key});

  @override
  State<HomeScreenScreen> createState() => _HomeScreenScreenState();
}

class _HomeScreenScreenState extends State<HomeScreenScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Hive Database'))),
      body: ValueListenableBuilder<Box<NotesModel>>(
          valueListenable: Boxes.getData().listenable(),
          builder: ((context, box, _) {
            var data = box.values.toList().cast<NotesModel>();
            return ListView.builder(
                itemCount: box.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10),
                    child: SizedBox(
                      height: 120,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Title: ${data[index].title.toString()}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Text(
                                          "Description: ${data[index].description.toString()}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      delete(data[index]);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  InkWell(
                                      onTap: () {
                                        _editDialog(
                                            data[index],
                                            data[index].title.toString(),
                                            data[index].description.toString());
                                      },
                                      child: const Icon(Icons.edit)),
                                  const SizedBox(width: 18),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          })),
      // body: SingleChildScrollView(
      //   child: Column(children: [
      //     FutureBuilder(
      //         future: Hive.openBox('maryam'),
      //         builder: (context, snapshot) {
      //           return Center(
      //             child: Card(
      //               child: ListTile(
      //                 title: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Text(snapshot.data!.get('name').toString()),
      //                 ),
      //                 subtitle: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Text(snapshot.data!.get('age').toString()),
      //                       Text(snapshot.data!.get('details').toString()),
      //                     ],
      //                   ),
      //                 ),
      //                 trailing: IconButton(
      //                     onPressed: () {
      //                       snapshot.data!.put('name', 'Ajjjjjja');
      //                       snapshot.data!.put('age', '29');
      //                       snapshot.data!.put('details', 'absdfghjk');

      //                       setState(() {});
      //                     },
      //                     icon: const Icon(
      //                       Icons.edit,
      //                       color: Color.fromARGB(255, 44, 161, 144),
      //                     )),
      //               ),
      //             ),
      //           );
      //         }),
      //     FutureBuilder(
      //         future: Hive.openBox('Programming'),
      //         builder: (context, snapshot) {
      //           return Center(
      //             child: Column(
      //               children: [
      //                 Card(
      //                   child: ListTile(
      //                     title: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child:
      //                           Text(snapshot.data!.get('language').toString()),
      //                     ),
      //                     subtitle: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Text(snapshot.data!.get('age').toString()),
      //                     ),
      //                     trailing: IconButton(
      //                         onPressed: () {
      //                           snapshot.data!.delete(
      //                             'language',
      //                           );
      //                           snapshot.data!.delete(
      //                             'age',
      //                           );
      //                           setState(() {});
      //                         },
      //                         icon: const Icon(
      //                           Icons.delete,
      //                           color: Color.fromARGB(255, 44, 161, 144),
      //                         )),
      //                   ),
      //                 )
      //                 //   Text(snapshot.data!.get('details').toString()),
      //               ],
      //             ),
      //           );
      //         }),
      //   ]),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showMyDialog();
//           //creating box(file)
//           var box = await Hive.openBox('maryam');
//           var box2 = await Hive.openBox('Programming');

// // //insert or put data in db
//           box.put('name', 'maryam');
//           box.put('age', '21');
//           box.put('details', {'pro': 'developer', 'abc': 'def'});

//           box2.put('language', 'Flutter');
//           box2.put('age', '40');

// // //get or fetching data from db
//           print(box.get('name'));
//           print(box.get('age'));
//           print(box.get('details')['pro']);

//           print(box2.get('language'));
//           print(box2.get('age'));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

// FOR DELETE
  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

//FOR EDIT
  Future<void> _editDialog(
      NotesModel notesModel, String title, String description) async {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(
                child: Text(
              'Edit Notes',
              style: TextStyle(color: Colors.red),
            )),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Title'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Description'),
                ),
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  // ignore: prefer_const_constructors
                  child: Text(
                    'Cancel',
                    style: const TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () async {
                    notesModel.title = titleController.text.toString();
                    notesModel.description =
                        descriptionController.text.toString();

                    await notesModel.save();
                    titleController.clear();
                    descriptionController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        });
  }

// fOR DIALOG BOX
  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Notes'),
            content: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Enter Title'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Description'),
                ),
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    final data = NotesModel(
                        title: titleController.text,
                        description: descriptionController.text);
                    final box = Boxes.getData();
                    box.add(data);
                    // data.description.toString();
                    // data.save();
                    // await Future.delayed(const Duration(seconds: 2));
                    print(">>>>>>>${box.get(data.description)}");
                    print(box.get);

                    titleController.clear();
                    descriptionController.clear();
                    // print(box.get('0'));
                    Navigator.pop(context);
                  },
                  child: const Text('Add')),
            ],
          );
        });
  }
}
