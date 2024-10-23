import 'package:flutter/material.dart';
import 'package:todo_app/core/my_text_styles.dart';
import 'package:todo_app/core/utils/date_utils.dart';

class AddTaskBottomSheet extends StatefulWidget {
   AddTaskBottomSheet({super.key});
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();

  static void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddTaskBottomSheet(),
            ));
  }
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime userSelectedDate=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add new task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium),
          SizedBox(height: 8,),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter task title',
              hintStyle: AppLightStyles.greyStyle,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
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
            onTap: (){
              showTaskDatePicker();
            },
            child: Text(
              userSelectedDate.toFormattedDate,
              textAlign: TextAlign.center,
              style: AppLightStyles.greyStyle,
            ),
          ),
          Spacer(),
          ElevatedButton(onPressed: () {}, child: Text('Add task')),
        ],
      ),
    );
  }

  void showTaskDatePicker()async {
    userSelectedDate=await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)))??userSelectedDate;
    setState(() {

    });
  }
}
