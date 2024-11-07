import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/my_text_styles.dart';
import 'package:todo_app/core/utils/date_utils.dart';
import 'package:todo_app/database_manager/model/todo_dm.dart';
import 'package:todo_app/database_manager/model/userdm.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final String taskId;
  final String title;
  final String description;
  final DateTime date;

  EditTaskBottomSheet({
    super.key,
    required this.taskId,
    required this.title,
    required this.description,
    required this.date,
  });

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();

  static Future show(
      BuildContext context,
      String taskId,
      String newTitle,
      String newDescription,
      DateTime newDate,
      ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: EditTaskBottomSheet(
          taskId: taskId,
          title: newTitle,
          description: newDescription,
          date: newDate,
        ),
      ),
    );
  }
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  late DateTime userSelectedDate;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final formKey = GlobalKey<FormState>();
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    userSelectedDate = widget.date;
    titleController = TextEditingController(text: widget.title);
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.all(14),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edit Task',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (input) =>
              (input == null || input.trim().isEmpty) ? 'Enter correct title' : null,
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter new title',
                hintStyle: AppLightStyles.greyStyle,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              validator: (input) =>
              (input == null || input.trim().isEmpty) ? 'Enter description' : null,
              controller: descriptionController,
              decoration: const InputDecoration(
                hintText: 'Enter new description',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Select new date',
              style: AppLightStyles.greyStyle?.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: showTaskDatePicker,
              child: Text(
                userSelectedDate.toFormattedDate,
                textAlign: TextAlign.center,
                style: AppLightStyles.greyStyle,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: isSaving
                  ? null
                  : () {
                if (formKey.currentState!.validate()) {
                  editTask(
                    titleController.text,
                    descriptionController.text,
                    userSelectedDate,
                  );
                }
              },
              child: isSaving
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Save Edit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showTaskDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: userSelectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        userSelectedDate = pickedDate;
      });
    }
  }

  Future<void> editTask(
      String newTitle,
      String newDescription,
      DateTime newDate,
      ) async {
    setState(() {
      isSaving = true;
    });
    try {
      var tasksCollection = FirebaseFirestore.instance
          .collection(UserDM.collectionName)
          .doc(UserDM.userDM!.id)
          .collection(TodoDM.collectionName);
      await tasksCollection.doc(widget.taskId).update({
        'title': newTitle,
        'description': newDescription,
        'date': Timestamp.fromDate(newDate),
      });
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to edit task: $e')),
      );
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }
}
