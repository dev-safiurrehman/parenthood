import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parenthood/model/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TodoWidget extends StatefulWidget {
  const TodoWidget({Key? key}) : super(key: key);

  TodoWidgetManager createState() => TodoWidgetManager();
}

class TodoWidgetManager extends State<TodoWidget> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TodoModel todoModel = TodoModel();

  late SharedPreferences prefs;
  bool taskCompleted = false;

  @override
  void initState() {
    super.initState();
    initPrefs();
    taskCompleted = prefs.getBool('taskCompleted') ?? false;
  }

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void incrementTask() {
    int taskCompletedCount = prefs.getInt('taskCompleted') ?? 0;
    taskCompletedCount++;
    prefs.setInt('taskCompleted', taskCompletedCount);
    setState(() {
      taskCompleted = true;
    });
  }

  void decrementTask() {
    int taskCompletedCount = prefs.getInt('taskCompleted') ?? 0;
    if (taskCompletedCount > 0) {
      taskCompletedCount--;
      prefs.setInt('taskCompleted', taskCompletedCount);
    }
    setState(() {
      taskCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }






  //widget for todo list view from firebase
  Future<Widget> todoWidget(BuildContext context, DateTime startDate, DateTime endDate) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = await _auth.currentUser!;
    final String uid = user.uid;
    Timestamp startDateTimestamp = Timestamp.fromDate(startDate);
    Timestamp endDateTimestamp = Timestamp.fromDate(endDate);
    Stream<QuerySnapshot> _userData = _firestore.collection('users').doc(uid).collection('todo')
        .where('date', isGreaterThanOrEqualTo: startDateTimestamp)
        .where('date', isLessThanOrEqualTo: endDateTimestamp)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Error getting todos"),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!.docs;
          if (data.isEmpty) {
            print('Snapshot data: ${snapshot.data!.docs}');
            return const Center(
              child: Text("No tasks for this week."),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Padding( // Added Padding for card size increase.
                    padding: const EdgeInsets.all(20),
                    child: Column( // Changed from ListTile to Column.
                      children: [
                     
                        Padding(
                          padding: EdgeInsets.only(bottom: 8), // Added some padding below the icon.
                          child: Align(
                            alignment: Alignment.centerLeft, // Align to the right.
                              child: Image.network(
                                data[index]['iconUrl'],
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),),
                        ),

                        SizedBox(
                          height: 8,
                        ), // Added some space between icon and title.
                        Align(
                          alignment: Alignment.centerLeft, // Align to the left.
                          child: Text(
                            data[index]['title'],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Adjust your font size and style as needed.
                          ),
                        ),
                        SizedBox(height: 8), // Added some space between title and description.
                        Align(
                          alignment: Alignment.centerLeft, // Align to the left.
                          child: Text(
                            data[index]['description'],
                            style: TextStyle(fontSize: 16), // Adjust your font size and style as needed.
                          ),
                        ),
                        SizedBox(height: 8), // Added some space between description and date.
                        Align(
                          alignment: Alignment.centerRight, // Align to the left.
                          child: Text(
                            DateFormat('dd-MM-yyyy').format(data[index]['date'].toDate()) + ' ' + data[index]['time'],
                            style: TextStyle(fontSize: 14, color: Colors.grey), // Adjust your font size and style as needed.
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        } else {
          return const Center(
            child: Text("No tasks to display."),
          );
        }
      },
    );
  }
}