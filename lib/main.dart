// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:todo_app_version2/widgets/counter.dart';
import 'package:todo_app_version2/widgets/todo_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class Task {
  String title;
  bool isDone;
  Task({required this.title, required this.isDone});
}

final myController = TextEditingController();
String? myText;

class _TodoAppState extends State<TodoApp> {
  List myActs = [
    Task(title: "Publish Video", isDone: false),
    Task(title: "Coding", isDone: false),
    Task(title: "Gym", isDone: true),
  ];

  changeStatus(int taskIndex) {
    setState(
      () {
        myActs[taskIndex].isDone = !myActs[taskIndex].isDone;

        //Alternative

        //   if (myActs[0].isDone == false) {
        //     myActs[0].isDone = true;
        //   } else {
        //     myActs[0].isDone = false;
        //   }
      },
    );
  }

  int counterCompletedTasks() {
    int counter = 0;
    for (var item in myActs) {
      if (item.isDone) {
        counter++;
      }
    }
    return counter;
  }

  tasksCheck(bool done) {
    setState(() {
      if (done == false) {
        done = true;
      }
    });
  }

  addTask() {
    setState(() {
      myText = myController.text;
      if (myText?.isNotEmpty ?? true) {
        myActs.add(Task(title: myText!, isDone: false));
        myController.clear();
      }
    });
    Navigator.pop(context);
  }

  clearDataTasks() {
    setState(() {
      if (myActs.isNotEmpty) {
        myActs.clear();
      }
    });
  }

  removeTodoItem(int taskIndex) {
    setState(() {
      myActs.removeAt(taskIndex);
    });
  }

  bool allTasksCompletedCheck1() {
    bool allDone = false;
    if (counterCompletedTasks() == myActs.length) {
      allDone = true;
    }
    return allDone;
  }

  bool allTasksCompletedCheck2() {
    bool allDone = false;
    int counter = 0;
    setState(() {
      for (var item in myActs) {
        if (item.isDone == true) {
          ++counter;
        }
      }
      if (counter == myActs.length) {
        allDone = true;
      } else {
        allDone = false;
      }
    });
    return allDone;
  }

  int? indexItem;
  @override
  Widget build(BuildContext context) {
    // List mycounter = myActs
    //     .where(
    //       (e) => e.isDone == true,
    //     )
    //     .toList();
    // this is same like CounterCompletedTasks Function but heigh level
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 0.7),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              clearDataTasks();
            },
            icon: Icon(
              Icons.delete_forever,
              color: const Color.fromARGB(255, 247, 218, 228),
              size: 35,
            ),
          ),
        ],
        title: Text(
          "TO DO APP",
          style: TextStyle(
            fontSize: 33,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            CounterTasks(
              completedTasks: counterCompletedTasks(),
              tasksCount: myActs.length,
              allDone: allTasksCompletedCheck1(),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: myActs.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return TODOCard(
                    title: myActs[index].title,
                    isDone: myActs[index].isDone,
                    changeStatus: changeStatus,
                    taskIndex: index,
                    deleteTask: removeTodoItem,
                  );
                },
              ),
            )
            // ...myActs.map(
            //   (item) => TODOCard(
            //     title: item.title,
            //     isDone: item.isDone,
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: () {
          showDialog(
            // useSafeArea: true,
            context: context,
            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: EdgeInsets.all(22),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: myController,
                        onChanged: (value) {
                          setState(() {
                            myText = value;
                          });
                        },
                        maxLength: 20,
                        decoration: InputDecoration(
                          hintText: "Add new Task",
                        ),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.redAccent),
                        ),
                        onPressed: () {
                          addTask();
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 23),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
          // showModalBottomSheet(
          //   isScrollControlled: true,
          //   useSafeArea: true,
          //   context: context,
          //   builder: (context) {
          //     return Container(
          //       padding: EdgeInsets.all(22),
          //       height: double.infinity,
          //       color: Colors.grey,
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           TextField(
          //             controller: myController,
          //             onChanged: (value) {
          //               setState(() {
          //                 myText = value;
          //               });
          //             },
          //             maxLength: 20,
          //             decoration: InputDecoration(
          //               hintText: "Add new Task",
          //             ),
          //           ),
          //           SizedBox(
          //             height: 22,
          //           ),
          //           TextButton(
          //             style: ButtonStyle(
          //               backgroundColor:
          //                   MaterialStatePropertyAll(Colors.redAccent),
          //             ),
          //             onPressed: () {
          //               addTask();
          //             },
          //             child: Text(
          //               "Add",
          //               style: TextStyle(color: Colors.white, fontSize: 23),
          //             ),
          //           )
          //         ],
          //       ),
          //     );
          //   },
          // );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
