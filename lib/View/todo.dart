// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:advance_todo/controller/database.dart';
import 'package:advance_todo/Model/todomodel.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});
  @override
  State createState() => _ToDoState();
}

class _ToDoState extends State {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await databaseFun();
      await getallTask();
    });
  }

  Future getallTask() async {
    log("IN GET ALL TASKS");
    List tasklist = await getData();
    setState(() {
      cardlist = tasklist;
    });
  }

  List cardlist = [];

  // Future<void> insertdata() async {
  //   print("new data");
  //   Tasksmodelclass task1 = Tasksmodelclass(
  //       title: titlecontroller.text,
  //       description: descriptioncontroller.text,
  //       date: datecontroller.text);

  //   await insertOrderData(task1);
  // }

  void showBottomSheet(bool isediting, [Todo? obj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("add tasks"),
                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "title",
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11)),
                    ),
                    TextFormField(
                      controller: titlecontroller,
                      decoration: const InputDecoration(
                          hintText: "enter title of task",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "description",
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11)),
                    ),
                    TextFormField(
                      controller: descriptioncontroller,
                      decoration: const InputDecoration(
                          hintText: "enter description of task",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "date",
                      style: GoogleFonts.quicksand(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 11)),
                    ),
                    TextFormField(
                      controller: datecontroller,
                      readOnly: true,
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.date_range_rounded),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Color.fromRGBO(0, 139, 148, 1))),
                          border: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.purpleAccent),
                              borderRadius: BorderRadius.circular(12))),
                      onTap: () async {
                        DateTime? pickdate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2025));
                        String formatedDate =
                            DateFormat.yMMMd().format(pickdate!);
                        setState(() {
                          datecontroller.text = formatedDate;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!isediting) {
                            submit(isediting);
                          } else {
                            submit(isediting, obj);
                          }
                          setState(() {
                            titlecontroller.clear();
                            descriptioncontroller.clear();
                            datecontroller.clear();
                            Navigator.of(context).pop();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            // fixedSize: const Size(100, 50),
                            backgroundColor:
                                const Color.fromRGBO(89, 57, 241, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        child: const Text(
                          "add task",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          );
        });
  }

  List tasks = [];

  void submit(bool isedit, [Todo? todoObj]) {
    if (titlecontroller.text.trim().isNotEmpty &&
        descriptioncontroller.text.trim().isNotEmpty &&
        datecontroller.text.trim().isNotEmpty) {
      if (!isedit) {
        setState(() {
          importData(Todo(
              title: titlecontroller.text,
              desc: descriptioncontroller.text,
              date: datecontroller.text));
          getallTask();
        });
      } else {
        setState(() {
          todoObj!.title = titlecontroller.text.trim();
          todoObj.date = datecontroller.text.trim();
          todoObj.desc = descriptioncontroller.text.trim();
          updateTask(todoObj);
        });
      }
    }
    titlecontroller.clear();
    datecontroller.clear();
    descriptioncontroller.clear();
  }

  void editTask(Todo todoObj) {
    titlecontroller.text = todoObj.title;
    descriptioncontroller.text = todoObj.desc;
    datecontroller.text = todoObj.date;

    showBottomSheet(true, todoObj);
  }

  @override
  void dispose() {
    super.dispose();
    titlecontroller.dispose();
    descriptioncontroller.dispose();
    datecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 360,
                child: Text(
                  "Good Morning",
                  style: GoogleFonts.quicksand(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 22)),
                ),
              ),
              Text(
                "Tushar",
                style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 30)),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: Text(
                    "CREATE A TO DO LIST",
                    style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12)),
                  ),
                ),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: cardlist.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(89, 57, 241, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: GestureDetector(
                                        onTap: () {
                                          editTask(cardlist[index]);

                                          setState(() {});
                                        },
                                        child: const Icon(Icons.edit_outlined),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: const BoxDecoration(
                                          color: Color.fromRGBO(89, 57, 241, 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: GestureDetector(
                                        onTap: () async {
                                          deleteTask(cardlist[index]);
                                          getallTask();
                                        },
                                        child: const Icon(Icons.delete_outline),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5,
                                      color:
                                          const Color.fromRGBO(0, 0, 0, 0.05))),
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromRGBO(217, 217, 217, 1)),
                                    child: Image.asset(
                                        "lib/assets/images/image1.png"),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cardlist[index].title,
                                        style: GoogleFonts.quicksand(
                                            textStyle: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 11)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(cardlist[index].desc,
                                          style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 8))),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(cardlist[index].date,
                                          style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 8)))
                                    ],
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Checkbox(
                                    value: cardlist[index].flag,
                                    onChanged: (value) {
                                      cardlist[index].flag = true;
                                      setState(() {});
                                    },
                                    activeColor: getColor(index),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ))
              ],
            ),
          )),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await insertdata();
          setState(() {
            showBottomSheet(false);
            titlecontroller.clear();
            descriptioncontroller.clear();
            datecontroller.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Color getColor(int index) {
    if (cardlist[index] == true) {
      return Colors.green;
    } else {
      return Colors.white;
    }
  }
}
