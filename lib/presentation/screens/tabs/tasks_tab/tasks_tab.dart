import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/colors_manager.dart';
import 'package:todo_app/core/my_text_styles.dart';
import 'package:todo_app/core/reusable_component/task_item.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/userdm.dart';


class TasksTab extends StatefulWidget {
  TasksTab({super.key});
  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todosList = [];

  @override
  Widget build(BuildContext context) {
    readTodosFireStore();
    return Column(
      children: [
        Expanded(
          flex: 30,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: Container(
                    color: ColorsManager.blueColor,
                  )),
                  Expanded(
                      child: Container(
                    color: ColorsManager.lightScaffoldBgColor,
                  )),
                ],
              ),
              buildCalenderItem(),
            ],
          ),
        ),
        Expanded(
          flex: 70,
          child: ListView.builder(
            itemBuilder: (context, index) => TaskItem(
              todo: todosList[index],
              onDeletedTask: () {
             readTodosFireStore();
              },
            ),
            itemCount: todosList.length,
          ),
        )
      ],
    );
  }

  Future<void> readTodosFireStore() async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.userDM!.id)
        .collection(TodoDM.collectionName);
    QuerySnapshot querySnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
    todosList = documents.map((docSnapshot) {
      Map<String, dynamic> json = docSnapshot.data() as Map<String, dynamic>;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }).toList();
    todosList = todosList
        .where((todo) =>
            todo.date.day == calenderSelectedDate.day &&
            todo.date.month == calenderSelectedDate.month &&
            todo.date.year == calenderSelectedDate.year)
        .toList();
    setState(() {});
  }

  Widget buildCalenderItem() {
    return EasyInfiniteDateTimeLine(
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        focusDate: calenderSelectedDate,
        lastDate: DateTime.now().add(Duration(days: 365)),
        onDateChange: (calenderSelectedDate) async{
          // calenderSelectedDate = calenderSelectedDate;
          // await filterTodosByDate();
          // setState(() {});
        },
        itemBuilder: (context, date, isSelected, onTap) {
          return InkWell(
            onTap: () async {
              calenderSelectedDate = date;
              await readTodosFireStore();
              setState(() {});
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: ColorsManager.whiteColor,
              elevation: 12,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${date.dayName}',
                      style: isSelected
                          ? AppLightStyles.selectedCalenderDay
                          : AppLightStyles.unselectedCalenderDay,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      '${date.day}',
                      style: isSelected
                          ? AppLightStyles.selectedCalenderDay
                          : AppLightStyles.unselectedCalenderDay,
                    ),
                  ]),
            ),
          );
        }
        );
    // return Container(
    //   margin: EdgeInsets.all(4),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(5),
    //     color: ColorsManager.whiteColor,
    //   ),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text(
    //         date.dayName,
    //         style: TextStyle(
    //           fontWeight: FontWeight.w700,
    //           fontSize: 15,
    //           color: isSelected
    //               ? ColorsManager.blueColor
    //               : ColorsManager.black,
    //         ),
    //       ),
    //       SizedBox(
    //         height: 4,
    //       ),
    //       Text(
    //         '${date.day}',
    //         style: TextStyle(
    //           fontWeight: FontWeight.w700,
    //           fontSize: 15,
    //           color: isSelected
    //               ? ColorsManager.blueColor
    //               : ColorsManager.black,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
