import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/my_text_styles.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/userdm.dart';
class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
  static Future show(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddTaskBottomSheet(),
            ));
  }
}
class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime userSelectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: EdgeInsets.all(14),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Add new task',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Enter correct title';
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter task title',
                hintStyle: AppLightStyles.greyStyle,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return 'Enter description';
                }
                return null;
              },
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter task description',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Select Date',
              style: AppLightStyles.greyStyle?.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () {
                showTaskDatePicker();
              },
              child: Text(
                userSelectedDate.toFormattedDate,
                textAlign: TextAlign.center,
                style: AppLightStyles.greyStyle,
              ),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  addTodoToFireStore();
                },
                child: Text('Add task')),
          ],
        ),
      ),
    );
  }

  void showTaskDatePicker() async {
    userSelectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        userSelectedDate;
    setState(() {});
  }

  void addTodoToFireStore() {
    if (formKey.currentState?.validate() == false) return;
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.userDM!.id)
        .collection(TodoDM.collectionName);
    DocumentReference doc = todoCollection.doc();
    TodoDM todo = TodoDM(
        id: doc.id,
        title: titleController.text,
        description: descriptionController.text,
        date: userSelectedDate,
        isDone: false);
    doc
        .set(todo.toJson())
        .then((value) {
      //Navigator.pop(context);
    })
        .onError(
          (error, stackTrace) {},
        )
        .timeout(Duration(microseconds: 500), onTimeout: () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }
}
