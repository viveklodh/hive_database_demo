import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory document = await getApplicationDocumentsDirectory();

  Hive.init(document.path);

  await Hive.openBox("students");

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController rollNoController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Box? studentBox;

  @override
  void initState() {
    studentBox = Hive.box("students");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("hive database")),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.yellowAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                  child: Column(children: [
                                TextField(
                                  controller: rollNoController,
                                ),
                                TextField(
                                  controller: nameController,
                                ),
                                TextButton(
                                  onPressed: () {
                                    studentBox?.put(rollNoController.text,
                                        nameController.text);
                                    rollNoController.clear();
                                    nameController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text("submit"),
                                )
                              ]));
                            });
                      },
                      child: Text("Add Student")),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                  child: Column(children: [
                                TextField(
                                  controller: rollNoController,
                                ),
                                TextField(
                                  controller: nameController,
                                ),
                                TextButton(
                                  onPressed: () {
                                    studentBox?.put(rollNoController.text,
                                        nameController.text);
                                    rollNoController.clear();
                                    nameController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text("submit"),
                                )
                              ]));
                            });
                      },
                      child: Text("Update Student")),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                  child: Column(children: [
                                TextField(
                                  controller: rollNoController,
                                ),
                                TextButton(
                                  onPressed: () {
                                    studentBox?.delete(rollNoController.text);
                                    rollNoController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text("submit"),
                                )
                              ]));
                            });
                      },
                      child: Text("Delete Student")),
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                  child: Column(children: [
                                TextField(
                                  controller: rollNoController,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print(
                                        studentBox?.get(rollNoController.text));

                                    rollNoController.clear();
                                    Navigator.pop(context);
                                  },
                                  child: Text("submit"),
                                )
                              ]));
                            });
                      },
                      child: Text("Show Student"))
                ],
              ),
              ValueListenableBuilder(
                  valueListenable: studentBox!.listenable(),
                  builder: (context, Box studentBox, _) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: studentBox.keys.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(studentBox.keyAt(index)),
                              subtitle: Text(studentBox.getAt(index)),
                            );
                          }),
                    );
                  })
            ],
          ),
        ));
  }
}
