// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final _key1 = GlobalKey<FormState>();
  final _key2 = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  Color mainColor = Colors.indigo;
  Color iconColor = Colors.pink;
  late Box box;
  int a = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
          backgroundColor: mainColor,
          actions: [
            IconButton(
                onPressed: () => setState(() {
                      box.clear();
                    }),
                icon: const Icon(
                  Icons.cached,
                  color: Colors.white,
                ))
          ],
        ),
        body: box.isNotEmpty
            ? FutureBuilder(
                future: Hive.openBox('EmployeeData'),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Has Error'),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: ListTile(
                                tileColor: mainColor.withOpacity(0.1),
                                shape: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15)),
                                leading: CircleAvatar(
                                    backgroundColor: mainColor,
                                    child: const Icon(
                                      Icons.perm_identity,
                                      color: Colors.white,
                                    )),
                                title: Text(snapshot.data!
                                    .getAt(index)['Name']
                                    .toString()),
                                subtitle: Text(snapshot.data!
                                    .getAt(index)['jobTitle']
                                    .toString()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        name.text = snapshot.data!
                                            .getAt(index)['Name']
                                            .toString();
                                        jobTitle.text = snapshot.data!
                                            .getAt(index)['jobTitle']
                                            .toString();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Update Details'),
                                              content: Form(
                                                key: _key2,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                        controller: name,
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            filled: true,
                                                            hintText:
                                                                'Enter Name ',
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none))),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    TextFormField(
                                                        controller: jobTitle,
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            filled: true,
                                                            hintText:
                                                                'Enter Job Title',
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none))),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  color: mainColor,
                                                  shape: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  onPressed: () {
                                                    if (_key2.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        snapshot.data!.putAt(
                                                            snapshot.data!
                                                                .keyAt(index),
                                                            {
                                                              'Name': name.text,
                                                              'jobTitle':
                                                                  jobTitle.text
                                                            });
                                                        Navigator.pop(context);
                                                      });
                                                    }
                                                  },
                                                  color: mainColor,
                                                  shape: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: const Text(
                                                    'Save',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: iconColor,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          snapshot.data!.deleteAt(index);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        color: iconColor,
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        });
                  } else {
                    return const Center(
                      child: Text('data'),
                    );
                  }
                })
            : Center(
                child: Text('Box is Empty'),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            box = await Hive.openBox('EmployeeData');
            setState(() {});
            showDialog(
              context: context,
              builder: (context) {
                name.clear();
                jobTitle.clear();
                return AlertDialog(
                  title: const Text('Add Details'),
                  content: Form(
                    key: _key1,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: mainColor.withOpacity(0.1),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: mainColor.withOpacity(0.3),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: name,
                              cursorColor: mainColor,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: mainColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  filled: true,
                                  hintText: 'Enter Name ',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none)),
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return 'Name is Empty';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              controller: jobTitle,
                              cursorColor: mainColor,
                              decoration: InputDecoration(
                                  errorStyle: TextStyle(color: mainColor),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  filled: true,
                                  hintText: 'Enter Job Title',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none)),
                              validator: (value) {
                                if (value.toString().trim().isEmpty) {
                                  return 'Job Title is Empty';
                                }
                                return null;
                              }),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: mainColor,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (_key1.currentState!.validate()) {
                          setState(() {
                            box
                                .add({
                                  'Name': name.text,
                                  'jobTitle': jobTitle.text,
                                })
                                .then((value) => Navigator.pop(context))
                                .onError((error, stackTrace) =>
                                    SnackBar(content: Text(error.toString())));
                          });
                        }
                        box.add({
                          'Name': name.text,
                          'jobTitle': jobTitle.text,
                        });
                      },
                      color: mainColor,
                      shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: mainColor,
          child: const Icon(Icons.add),
        ));
  }
}
